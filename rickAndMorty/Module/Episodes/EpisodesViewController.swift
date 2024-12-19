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
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
                
        layout.itemSize = CGSize(width: view.frame.width / 2 - 15, height: 150)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
                
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(EpisodesCell.self, forCellWithReuseIdentifier: "EpisodesСell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
                
        view.addSubview(collectionView)
    }
}

extension EpisodesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.episodes.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodesCell", for: indexPath) as! EpisodesCell
        cell.episodesLabel.text = viewModel?.episodes[indexPath.item].name
        cell.nameLabel.text = viewModel?.episodes[indexPath.item].name
        return cell
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.showCharacterDetails(index: indexPath.item)
        print("Item selected at index \(indexPath.item)")
    }
}

