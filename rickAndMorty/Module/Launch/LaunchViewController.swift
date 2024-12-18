//
//  LaunchViewController.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 14.12.2024.
//

import UIKit

final class LaunchViewController: UIViewController {
    enum Event {
        case launchComlpete
    }
    
    var didSendEventHandler: ((LaunchViewController.Event)-> Void)?
    
    private lazy var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startRotatingAnimation()
        showLaunchToMainFlowAnimation()
    }
    
    private lazy var imageLoadingView: UIImageView = {
        let image = UIImage(named: ImageName.launchImageLoading)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imageLogoView: UIImageView = {
        let image = UIImage(named: ImageName.launchImageLogo)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(imageLogoView)
        view.addSubview(imageLoadingView)
        
        imageLogoView.translatesAutoresizingMaskIntoConstraints = false
        imageLoadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageLogoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLogoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50),
            imageLogoView.widthAnchor.constraint(equalToConstant: 312),
            imageLogoView.heightAnchor.constraint(equalToConstant: 104),
        ])
        
        NSLayoutConstraint.activate([
            imageLoadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLoadingView.topAnchor.constraint(equalTo: imageLogoView.bottomAnchor,constant: 100)
        ])
        
    }
    
    private func startRotatingAnimation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = 0.5
        rotation.repeatCount = .infinity
        imageLoadingView.layer.add(rotation, forKey: "transform.rotation")
    }
    
    
   
    
    private func showLaunchToMainFlowAnimation() {
        animator.addAnimations {
            self.imageLoadingView.transform = .init(scaleX: 2, y: 2)
            self.imageLoadingView.alpha = 0
        }
        
        animator.addCompletion { position in
            switch position {
            case .end: self.didSendEventHandler?(.launchComlpete)
            case .start, .current: break
            @unknown default: break
            }
            
        }
        animator.startAnimation(afterDelay: 3.0)
    }
    
   
}
