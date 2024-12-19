//
//  CharacterViewController.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

import UIKit

final class CharacterViewController: UIViewController {
    var nameLabel: UILabel!
    var character: Character!
    
    private var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        nameLabel = UILabel()
        nameLabel.textColor = .label
        nameLabel.font = .systemFont(ofSize: 24)
        nameLabel.textAlignment = .center
        view.addSubview(nameLabel)
    }
    
    func configure(with index: Int) {
        self.index = index
    }
}
