//
//  TabBarViewController.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 17.12.2024.
//

import UIKit

final class TabBarViewController: UIViewController {
    enum Event {
        case tabBar
    }
    
    var didSendEventHandler: ((TabBarViewController.Event) -> Void)?
    var startIndex = 0
    var controllers: [UIViewController] = []
    
    private lazy var currentIndex = startIndex {
        didSet {
            switchToController(at: currentIndex)
        }
    }
    
    private var tabBarView: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
       setupInitialViewController()
    }
    
    private func setupTabBar() {
        tabBarView = UITabBar()
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarView)
        
        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 50)
        ])

        tabBarView.delegate = self
        
        let firstTabItem = UITabBarItem(title: nil, image: UIImage(named: ImageName.episodesIcon ), tag: 0)
        let secondTabItem = UITabBarItem(title: nil, image: UIImage(named: ImageName.favouritesIcon), tag: 1)
        
        tabBarView.items = [firstTabItem, secondTabItem]
        tabBarView.selectedItem = firstTabItem 
    }
    
    private func setupInitialViewController() {
        guard controllers.indices.contains(startIndex) else {
            print("Error: Invalid startIndex")
            return
        }
        
        let initialController = controllers[startIndex]
        addChild(initialController)
        initialController.view.frame = view.bounds
        view.insertSubview(initialController.view, belowSubview: tabBarView)
        initialController.didMove(toParent: self)
    }

    
    private func switchToController(at index: Int) {
        guard controllers.indices.contains(index) else {
            print("Error: Invalid index for controller")
            return
        }
        
        children.forEach { $0.view.removeFromSuperview(); $0.removeFromParent() }
        
        let selectedController = controllers[index]
        addChild(selectedController)
        selectedController.view.frame = view.bounds
        view.insertSubview(selectedController.view, belowSubview: tabBarView)
        selectedController.didMove(toParent: self)
        
        didSendEventHandler?(.tabBar)
    }
}

extension TabBarViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        currentIndex = item.tag
    }
}
