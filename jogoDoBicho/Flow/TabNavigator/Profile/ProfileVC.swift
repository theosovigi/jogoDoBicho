//
//  ProfileVC.swift


import Foundation
import UIKit
import AVFoundation
import RealmSwift

final class ProfileVC: UIViewController {
    
    private let uD = UD.shared
    private let post = PostServiceBack.shared
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
        main()

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
        contentView.editBtn.addTarget(self, action: #selector(tappeUpdateName), for: .touchUpInside)

    }
    
    @objc func tappedInfo() {
        let infoVC = InfoVC()
        navigationController?.pushViewController(infoVC, animated: true)
    }
    
    @objc func tappeUpdateName() {
        updateName()
    }

    private func checkFotoLoad() {
        if let savedImage = getImageFromLocal() {
            contentView.chosePhotoBtn.setImage(savedImage, for: .normal)
        }
    }

//    private func checkPlanet() {
//        
//        if realm.objects(Matrix.self).filter("namePlanet == %@ && isCompleted == false", "Africa").isEmpty {
//            
//        }
//    }
    
    
    
    func updateName() {
        if uD.userName != nil {
            let payload = UpdatePayload(name: uD.userName, score: nil)
            post.updateData(id: uD.userID!, payload: payload) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        print("Success")
                    case .failure(let failure):
                        print("Error - \(failure.localizedDescription)")
                    }
                }
            }
        }
    }
    
    @objc func goTakePhoto() {
        let alert = UIAlertController(title: "Pick Library", message: nil, preferredStyle: .actionSheet)
        
        let actionLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                print("Camera not available")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(actionCamera)
        alert.addAction(actionLibrary)
        alert.addAction(cancel)
        
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

