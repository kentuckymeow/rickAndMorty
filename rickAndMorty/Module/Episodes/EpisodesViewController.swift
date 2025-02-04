//
//  EpisodesViewController.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 18.12.2024.
//

import UIKit

protocol EpisodesViewControllerDelegate: AnyObject {
    func didSelectEpisode()
}

protocol FilterDelegate: AnyObject {
    func filterDidChose()
}

final class EpisodesViewController: UIViewController {
    // MARK: - Properties
    private var episodes: [Episode] = []
    private var characters: [Character] = []
    private var episodeCharactersCache: [Int: [Character]] = [:]
    private var collectionView: UICollectionView!
    private let searchBar = UISearchBar()
    private let filterButton = UIButton(type: .system)
    
    weak var delegate: EpisodesViewControllerDelegate?
    var filterDelegate: FilterDelegate?
    
    var viewModel: EpisodeViewModelDelegate? {
        didSet {
            viewModel?.updateHandler = { [weak self] episodes, characters in
                self?.episodes = episodes
                self?.characters = characters
                self?.cacheCharactersForEpisodes()
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    private lazy var imageLogoView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ImageName.launchImageLogo))
        return imageView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCollectionView()
        setupUI()
        setupSearchBar()
        setupFilterButton()
        setupMenu()
        
        viewModel?.getEpisodeAndCharacter()
    }
    
    // MARK: - UI Setup
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 1.1, height: 300)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 50
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(EpisodesCell.self, forCellWithReuseIdentifier: "EpisodesCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setupUI() {
        view.addSubview(imageLogoView)
        view.addSubview(searchBar)
        view.addSubview(filterButton)
        view.addSubview(collectionView)
        
        [imageLogoView, searchBar, filterButton, collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLogoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageLogoView.widthAnchor.constraint(equalToConstant: 312),
            imageLogoView.heightAnchor.constraint(equalToConstant: 104),
            
            searchBar.topAnchor.constraint(equalTo: imageLogoView.bottomAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            filterButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            filterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterButton.heightAnchor.constraint(equalToConstant: 56),
            
            collectionView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Name or episode (ex. S01E01)"
        searchBar.backgroundImage = UIImage()
    }
    
    private func setupFilterButton() {
        let image = UIImageView(image: UIImage(named: "filter"))
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        
        filterButton.addSubview(image)
        image.frame = CGRect(x: 19, y: 20, width: 22, height: 14)
        
        filterButton.backgroundColor = UIColor(named: "backFilterButtonColor")
        filterButton.setTitle("ADVANCED FILTERS", for: .normal)
        filterButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        filterButton.layer.cornerRadius = 4
        filterButton.clipsToBounds = true
    }
    
    private func setupMenu() {
        let statusMenu = UIMenu(title: "Status", children: [
            UIAction(title: "Alive") { [weak self] _ in self?.viewModel?.statusSelected(status: "Alive") },
            UIAction(title: "Dead") { [weak self] _ in self?.viewModel?.statusSelected(status: "Dead") },
            UIAction(title: "Unknown") { [weak self] _ in self?.viewModel?.statusSelected(status: "unknown") }
        ])
        
        let genderMenu = UIMenu(title: "Gender", children: [
            UIAction(title: "Female") { [weak self] _ in self?.viewModel?.genderSelected(gender: "Female") },
            UIAction(title: "Male") { [weak self] _ in self?.viewModel?.genderSelected(gender: "Male") },
            UIAction(title: "Genderless") { [weak self] _ in self?.viewModel?.genderSelected(gender: "Genderless") },
            UIAction(title: "Unknown") { [weak self] _ in self?.viewModel?.genderSelected(gender: "unknown") }
        ])
        
        let mainMenu = UIMenu(children: [statusMenu, genderMenu, UIAction(title: "Default") { [weak self] _ in self?.viewModel?.getEpisodeAndCharacter() }])
        
        filterButton.menu = mainMenu
        filterButton.showsMenuAsPrimaryAction = true
    }
    
    private func cacheCharactersForEpisodes() {
        episodeCharactersCache.removeAll()
        for episode in episodes {
            episodeCharactersCache[episode.id] = characters.filter { episode.characters.contains($0.url) }
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension EpisodesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return episodes.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodesCell", for: indexPath) as? EpisodesCell else {
            return UICollectionViewCell()
        }
            
        let episode = episodes[indexPath.item]
        let episodeCharacters = episodeCharactersCache[episode.id] ?? []
        let character = episodeCharacters.randomElement() ?? Character.defaultCharacter()
            
        cell.configure(with: episode, character: character, nameCharacter: character.name, nameEpisode: episode.name, episodeLabel: episode.episode, episodeImageURL: character.image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectEpisode()
    }
}

// MARK: - UISearchBarDelegate
extension EpisodesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchEpisodes(query: searchText)
    }
}

// MARK: - FilterDelegate
extension EpisodesViewController: FilterDelegate {
    func filterDidChose() {
        collectionView.reloadData()
    }
}
