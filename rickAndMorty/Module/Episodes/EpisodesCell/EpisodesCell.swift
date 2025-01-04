//
//  EpisodesCell.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

import UIKit

final class EpisodesCell: UICollectionViewCell {
    private var stackView: UIStackView!
    private var stackViewEpisodesInfo: UIStackView!
    
    private let episodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "rick")
        return imageView
    }()
    
    private let nameCharacterLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let monitorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: ImageName.monitorIcon)
        return imageView
    }()
    
    private let episodeInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackViewEpisodesInfo()
        setupStackView()
        setupConstraints()
        setUpCellAppearance()
    }
    
    private func setupStackViewEpisodesInfo() {
        stackViewEpisodesInfo = UIStackView(arrangedSubviews: [monitorImageView, episodeInfoLabel])
        stackViewEpisodesInfo.axis = .horizontal
        stackViewEpisodesInfo.spacing = 4
        stackViewEpisodesInfo.alignment = .center
        stackViewEpisodesInfo.backgroundColor = .systemGray6
        stackViewEpisodesInfo.translatesAutoresizingMaskIntoConstraints = false
        stackViewEpisodesInfo.layer.cornerRadius = 8
    }
    
    private func setupStackView() {
        stackView = UIStackView(arrangedSubviews: [episodeImageView, nameCharacterLabel, stackViewEpisodesInfo])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackViewEpisodesInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackViewEpisodesInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            episodeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            episodeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            episodeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            episodeImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            nameCharacterLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1.2)
        ])
    }
    
    private func setUpCellAppearance() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }
    
    func configure(nameCharacter: String, nameEpisode: String, episodeLabel: String) {
        nameCharacterLabel.text = nameCharacter
        episodeInfoLabel.text = "\(nameEpisode) | \(episodeLabel)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
