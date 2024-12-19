//
//  EpisodesCell.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

import UIKit

final class EpisodesCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let episodesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(episodesLabel)
        
        NSLayoutConstraint.activate([
            episodesLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            episodesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            episodesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            episodesLabel.heightAnchor.constraint(equalToConstant: frame.height - 30),
                    
            nameLabel.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
