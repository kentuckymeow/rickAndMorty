//
//  FavoritesViewController.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 18.12.2024.
//

import UIKit

final class FavouritesViewController: UIViewController {
    var viewModel: FavouriteViewModelDelegate? {
        didSet {
            viewModel?.updateHandler = { [weak self] episodes, characters in
                print("Update handler triggered with episodes: \(episodes), characters: \(characters)")
                self?.favouriteEpisodes = episodes
                self?.characters = characters
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Favourites Episodes"
        label.textAlignment = .center
        return label
    }()
    
    private var collectionView: UICollectionView!
    private var favouriteEpisodes: [Episode] = []
    private var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavouritesViewModel.shared 
        setUpCollectionView()
        setUpUI()
        viewModel?.getFavourites()
    }

    private func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width * 0.9, height: 300)
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
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension FavouritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of favourite episodes: \(favouriteEpisodes.count)")
        return min(favouriteEpisodes.count, characters.count)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodesCell", for: indexPath) as? EpisodesCell else {
            return UICollectionViewCell()
        }

        let episode = favouriteEpisodes[indexPath.row]
        let character = characters[indexPath.row]
        
        cell.configure(
            with: episode,
            character: character,
            nameCharacter: character.name,
            nameEpisode: episode.name,
            episodeLabel: episode.episode,
            episodeImageURL: character.image
        )
        
        return cell
    }
}
