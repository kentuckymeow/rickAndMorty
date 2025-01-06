//
//  EpisodesViewController.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 18.12.2024.
//

import UIKit

final class EpisodesViewController: UIViewController {
    var viewModel: EpisodesViewModel?
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setUpUI()
        viewModel?.fetchEpisodes()
    }
    
    private lazy var imageLogoView: UIImageView = {
        let image = UIImage(named: ImageName.launchImageLogo)
        let imageView = UIImageView(image: image)
        return imageView
    }()

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width/1.1, height: 300)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 50
        layout.scrollDirection = .vertical
                
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(EpisodesCell.self, forCellWithReuseIdentifier: "EpisodesCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(imageLogoView)
        view.addSubview(collectionView)
        
        imageLogoView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLogoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageLogoView.widthAnchor.constraint(equalToConstant: 312),
            imageLogoView.heightAnchor.constraint(equalToConstant: 104),
            
            collectionView.topAnchor.constraint(equalTo: imageLogoView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)                  
        ])
    }
}

extension EpisodesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.episodes.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodesCell", for: indexPath) as? EpisodesCell else {
            return UICollectionViewCell()
        }
        if let episode = viewModel?.episodes[indexPath.item] {
            cell.configure(
                nameCharacter: episode.characters.first?.name ?? "",
                nameEpisode: episode.name ?? "",
                episodeLabel: episode.episode ?? "",
                episodeImageURL: episode.characters.first?.image ?? ""
            )
           
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected at index \(indexPath.item)")
    }
}

