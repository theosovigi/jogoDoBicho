//
//  ProfileVC.swift


import Foundation
import UIKit
import AVFoundation


final class ProfileVC: UIViewController {
    
    private let uD = UD.shared
    private let imagePicker = UIImagePickerController()
    
    private var contentView: ProfileView {
        view as? ProfileView ?? ProfileView()
    }
    
    override func loadView() {
        view = ProfileView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerDelegate()
        tappedButtons()
        checkFotoLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkUpdateAchiev()
    }
    
    private func pickerDelegate() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }
    
    private func checkUpdateAchiev() {
        let minutes = uD.elapsedTimeInSeconds / 60
        let seconds = uD.elapsedTimeInSeconds % 60
        contentView.scoreTimeLabel.text = contentView.formatTime(minutes: minutes, seconds: seconds)
        contentView.achievementImage.image = uD.scorePaint > 1 ? .achievementDoneImg : .achievementImg
        contentView.achievementImageTwo.image = minutes > 5 ? .achievementDoneImg : .achievementImg
        contentView.achievementImageThree.image = uD.scorePaint > 9 ? .achievementDoneImg : .achievementImg
        contentView.achievementImageFour.image = uD.scorePaint > 19 ? .achievementDoneImg : .achievementImg
        contentView.achievementImageFive.image = uD.scorePaint > 14 ? .achievementDoneImg : .achievementImg
    }
    
    private func tappedButtons() {
        contentView.chosePhotoBtn.addTarget(self, action: #selector(goTakePhoto), for: .touchUpInside)
        contentView.infoBtn.addTarget(self, action: #selector(tappedInfo), for: .touchUpInside)
    
    }
    
    @objc func tappedInfo() {
        let infoVC = InfoVC()
        navigationController?.pushViewController(infoVC, animated: true)
    }
    
    private func checkFotoLoad() {
        if let savedImage = getImageFromLocal() {
            contentView.chosePhotoBtn.setImage(savedImage, for: .normal)
        }
    }

    
    @objc func goTakePhoto() {
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            let alert = UIAlertController(title: "Pick Photo", message: nil, preferredStyle: .actionSheet)
//            let action1 = UIAlertAction(title: "Camera", style: .default) { _ in
//                self.imagePicker.sourceType = .camera
//            }
//            let action2 = UIAlertAction(title: "photo library", style: .default) { _ in
//                self.imagePicker.sourceType = .photoLibrary
//            }
//            let cancel = UIAlertAction(title: "cancel", style: .cancel)
//            present(imagePicker, animated: true, completion: nil)
//            alert.addAction(action1)
//            alert.addAction(action2)
//            alert.addAction(cancel)
//            present(alert, animated: true)
//        } else {
//            print("Камера недоступна")
//        }
        
        checkCameraAccess()

    }
    private func checkCameraAccess() {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
                case .authorized:
                    // Доступ уже предоставлен
                    self.presentCameraOptions()
                case .notDetermined:
                    // Доступ еще не запрашивался, запрашиваем
                    AVCaptureDevice.requestAccess(for: .video) { granted in
                        DispatchQueue.main.async {
                            if granted {
                                self.presentCameraOptions()
                            } else {
                                self.showAccessDeniedAlert()
                            }
                        }
                    }
                case .denied, .restricted:
                    // Доступ отклонен или ограничен, оповещаем пользователя
                    showAccessDeniedAlert()
                @unknown default:
                    // Непредвиденная ситуация, можно добавить обработку
                    break
            }
        }
        
        private func presentCameraOptions() {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let alert = UIAlertController(title: "Pick Photo", message: nil, preferredStyle: .actionSheet)
                let action1 = UIAlertAction(title: "Camera", style: .default) { _ in
                    self.imagePicker.sourceType = .camera
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
                let action2 = UIAlertAction(title: "Photo Library", style: .default) { _ in
                    self.imagePicker.sourceType = .photoLibrary
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
                let cancel = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(action1)
                alert.addAction(action2)
                alert.addAction(cancel)
                present(alert, animated: true)
            } else {
                print("Камера недоступна")
            }
        }
        
        private func showAccessDeniedAlert() {
            let alert = UIAlertController(title: "Доступ к камере отклонен", message: "Для съемки фото необходим доступ к камере. Пожалуйста, измените настройки доступа в настройках iOS.", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (_) in
                guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(settingsURL)
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
            alert.addAction(settingsAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
}

extension ProfileVC: UIImagePickerControllerDelegate {
    
    func saveImageToLocal(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 1.0),
            let id  = uD.userID {
            let fileURL = getDocumentsDirectory().appendingPathComponent("\(id).png")
            try? data.write(to: fileURL)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getImageFromLocal() -> UIImage? {
        guard let id = uD.userID else { return nil }
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(id).png")
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("Error loading image from local storage")
            return nil
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            contentView.chosePhotoBtn.setImage(image, for: .normal)
            saveImageToLocal(image: image)
        }
        
        dismiss(animated: true, completion: nil)
    }
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension ProfileVC: UINavigationControllerDelegate {
    
}

