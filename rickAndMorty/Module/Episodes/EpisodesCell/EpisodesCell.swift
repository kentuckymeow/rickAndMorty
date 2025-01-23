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
        imageView.contentMode = .scaleAspectFit
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
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let favouriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: ImageName.favouritesIcon), for: .normal)
        button.tintColor = .systemGray
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var episode: Episode?
    private var character: Character?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackViewEpisodesInfo()
        setupStackView()
        setupConstraints()
        setUpCellAppearance()
        favouriteButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }

    private func setupStackViewEpisodesInfo() {
        stackViewEpisodesInfo = UIStackView(arrangedSubviews: [monitorImageView, episodeInfoLabel, favouriteButton])
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
        
        NSLayoutConstraint.activate([
            favouriteButton.centerXAnchor.constraint(equalTo: stackViewEpisodesInfo.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            monitorImageView.centerXAnchor.constraint(equalTo: stackViewEpisodesInfo.leadingAnchor, constant: 20)
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

    @objc private func buttonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        updateFavouriteButtonImage(isFavourite: sender.isSelected)

        guard let episode = episode else { return }

        let favouritesViewModel = FavouritesViewModel.shared

        if sender.isSelected {
            if let characters = character {
                favouritesViewModel.addToFavourites(episode: episode, character: characters)
            } else {
                print("Characters data is missing")
            }
        } else {
            favouritesViewModel.removeFromFavourites(episode: episode)
        }
    }

    private func updateFavouriteButtonImage(isFavourite: Bool) {
        let imageName = isFavourite ? ImageName.activeFavouritesIcon : ImageName.favouritesIcon
        favouriteButton.setImage(UIImage(named: imageName), for: .normal)
    }
 
    func configure(with episode: Episode, character: Character, nameCharacter: String, nameEpisode: String, episodeLabel: String, episodeImageURL: String) {
        self.episode = episode
        self.character = character
        nameCharacterLabel.text = nameCharacter
        episodeInfoLabel.text = "\(nameEpisode) | \(episodeLabel)"

        if let url = URL(string: episodeImageURL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self, error == nil, let data = data, let image = UIImage(data: data) else {
                    print("Failed to load image from URL: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                DispatchQueue.main.async {
                    self.episodeImageView.image = image
                }
            }.resume()
        } else {
            print("Invalid URL string: \(episodeImageURL)")
        }

        let isFavourite = FavouritesViewModel.shared.isFavourite(episode: episode)
        updateFavouriteButtonImage(isFavourite: isFavourite)
        favouriteButton.isSelected = isFavourite
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
