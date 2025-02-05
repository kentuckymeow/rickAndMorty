//
//  CharacterViewController.swift
//  rickAndMorty
//
//  Created by Arseni Khatsuk on 19.12.2024.
//

import UIKit
import AVFoundation

final class CharacterViewController: UIViewController {
    private var character: Character?
    var viewModel: CharacterViewModelDelegate? {
        didSet {
            viewModel?.updateHandler = { [weak self] character in
                self?.configure(with: character)
            }
        }
    }
    
    private let characterImage = UIImageView()
    private let infoTableView = CharacterTableView()
    private let nameLabel = UILabel()
    private let cameraButton = UIButton()
    
    
    
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
        setUpNavBar()
        setupCharacterImage()
        setupNameCharacter()
        setupInfoTableView()
        setUpCamerButton()
        viewModel?.getCharacterInfo()
        
    }
    
    func configure(with character: Character) {
        self.character = character
        nameLabel.text = character.name
        characterImage.loadImage(from: character.image) // Загружаем картинку
        infoTableView.configure(with: character) // Передаем персонажа в таблицу
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
    
    func setUpNavBar() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: ImageName.goBack), for: .normal)
        backButton.setAttributedTitle(NSAttributedString(string: " GO BACK ",
                                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18,weight: .semibold)]), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.tintColor = .black
        backButton.contentHorizontalAlignment = .leading
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let rightImage = UIImageView(image: UIImage(named: ImageName.charaterTitleImage))
        rightImage.contentMode = .scaleAspectFit
        rightImage.clipsToBounds = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightImage)
        
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cameraButtonTapped() {
        let actionSheet = UIAlertController(title: "Выберите фото", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Сделать фото", style: .default) { _ in
            self.checkCameraPermissionsAndOpen(sourceType: .camera)
        }
                                         
        let galleryAction = UIAlertAction(title: "Выбрать из галереии", style: .default) { _ in
            self.openImagePicker(sourceType: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(galleryAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
    
    func setUpCamerButton() {
        view.addSubview(cameraButton)
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.setImage(UIImage(named: ImageName.camera), for: .normal)
        setupCamerButtonConstraint()
        
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
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
    
    func setupCamerButtonConstraint() {
        NSLayoutConstraint.activate([
            cameraButton.centerYAnchor.constraint(equalTo: characterImage.centerYAnchor),
            cameraButton.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor, constant: 8),
            cameraButton.widthAnchor.constraint(equalToConstant: 24),
            cameraButton.heightAnchor.constraint(equalToConstant: 21)
            
        ])
    }
    
    func setupNameLabelConstraint(){
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: characterImage.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 49)
        ])
    }
}

extension CharacterViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

extension CharacterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func checkCameraPermissionsAndOpen(sourceType: UIImagePickerController.SourceType) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            openImagePicker(sourceType: sourceType)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.openImagePicker(sourceType: sourceType)
                    }
                }
            }
            
        case .denied, .restricted:
            showPermissionAlert()
        @unknown default:
            return
        }
    }
    
    private func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true)
    }
    
    private func showPermissionAlert() {
        let alert = UIAlertController(
            title: "Доступ запрещен",
            message: "Вы можете разрешить доступ в настройках",
            preferredStyle: .alert
        )
        
        let settingAction = UIAlertAction(title: "Открыть настройки", style: .default) { _ in
            if let settingsUrl = URL(string:  UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        present(alert,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            characterImage.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            characterImage.image = originalImage
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
