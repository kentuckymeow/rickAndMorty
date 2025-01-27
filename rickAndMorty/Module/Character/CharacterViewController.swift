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
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
        setUpUI()
        viewModel?.getCharacterInfo()
        
    }
    
    private func setUpUI() {
        view.addSubview(imageView)
        view.addSubview(characterName)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            characterName.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: characterName.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CharacterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let character = character.first else { return cell }
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Gender: \(character.gender)"
        case 1:
            cell.textLabel?.text = "Status: \(character.status)"
        case 2:
            cell.textLabel?.text = "Species: \(character.species)"
        case 3:
            cell.textLabel?.text = "Type: \(character.type)"
        case 4:
            cell.textLabel?.text = "Origin: \(character.origin.name)"
        case 5:
            cell.textLabel?.text = "Location: \(character.location)"
            
        default:
            break
        }
        return cell
    }
}
