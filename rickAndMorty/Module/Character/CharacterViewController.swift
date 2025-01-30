//
//  CharacterViewController.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

import UIKit

final class CharacterViewController: UIViewController {
    var viewModel: CharacterViewModelDelegate? {
        didSet {
            viewModel?.updateHandler = { [weak self] character in
                self?.character = character
            }
        }
    }
    
    private var character: [Character] = []
    private let characterImage = UIImageView()
    private let infoTableView = CharacterTableView()
    private let nameLabel = UILabel()
    
    
    
    let characterName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCharacterImage()
        setupNameCharacter()
        setupInfoTableView()
        viewModel?.getCharacterInfo()
        
    }
    
    
    func setupCharacterImage() {
        view.addSubview(characterImage)
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.contentMode = .scaleAspectFit
        characterImage.clipsToBounds = true
        
        characterImage.layer.cornerRadius = 75
        characterImage.layer.borderColor = UIColor(named: "borderColor")?.cgColor
        characterImage.layer.borderWidth = 4
        setupCharacterImageConstraint()
    }
    
    func setupNameCharacter() {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 32)
        nameLabel.textColor = UIColor(named: "cameraColor")
        nameLabel.textAlignment = .center
        nameLabel.sizeToFit()
        setupNameLabelConstraint()
    }
    
    func setupInfoTableView() {
        view.addSubview(infoTableView)
        infoTableView.translatesAutoresizingMaskIntoConstraints = false
        setupTableConstraint()
    }
    
    func setupTableConstraint() {
        NSLayoutConstraint.activate([
            infoTableView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 18),
            infoTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            infoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    func setupCharacterImageConstraint() {
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            characterImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImage.widthAnchor.constraint(equalToConstant: 147),
            characterImage.heightAnchor.constraint(equalTo: characterImage.widthAnchor)
        ])
    }
    
    func setupNameLabelConstraint(){
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: characterImage.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 49)
        ])
    }
    
}
