//
//  MyFotoVC.swift

import AVFoundation
import Foundation
import UIKit

class MyFotoVC: UIViewController {
    
    private var savedImageImport: UIImage?
    private let uD = UD.shared
    private let imagePicker = UIImagePickerController()

    var contentView: MyFotoView {
        view as? MyFotoView ?? MyFotoView()
    }
    
    override func loadView() {
        view = MyFotoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerDelegate()
        tappedButtons()
        checkFotoLoad()
    }
    
    private func pickerDelegate() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    }
    
    private func tappedButtons() {
        contentView.galleryBtn.addTarget(self, action: #selector(goTakePhoto), for: .touchUpInside)
        contentView.photoBtn.addTarget(self, action: #selector(goTakePhoto), for: .touchUpInside)
    
    }
    
    @objc func tappedInfo() {
        let infoVC = InfoVC()
        navigationController?.pushViewController(infoVC, animated: true)
    }
    
private func checkFotoLoad() {
        if let savedImage = getImageFromLocal() {
            self.savedImageImport = savedImage
            contentView.imageFaceView.image = savedImage
        }
    }

    
    @objc func goTakePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let alert = UIAlertController(title: "Pick Photo", message: nil, preferredStyle: .actionSheet)
            let action1 = UIAlertAction(title: "Camera", style: .default) { _ in
                self.imagePicker.sourceType = .camera
            }
            let action2 = UIAlertAction(title: "photo library", style: .default) { _ in
                self.imagePicker.sourceType = .photoLibrary
            }
            let cancel = UIAlertAction(title: "cancel", style: .cancel)
            present(imagePicker, animated: true, completion: nil)
            alert.addAction(action1)
            alert.addAction(action2)
            alert.addAction(cancel)
            present(alert, animated: true)
        } else {
            print("Камера недоступна")
        }
    }
}

extension MyFotoVC: UIImagePickerControllerDelegate {
    
    func saveImageToLocalImport(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 1.0),
            let id  = uD.userID {
            let timeStamp = Date().timeIntervalSince1970 // Получаем текущую временную метку
            let fileName = "\(id)_\(timeStamp).png" // Создаем уникальное имя файла
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
              saveImageToLocalImport(image: image)
              savedImageImport = image // Сохраняем изображение в свойство savedImage
              let importVC = MyImportVC()
              importVC.importedImage = image // Передаем изображение на MyImportVC
              importVC.imageName = "\(uD.userID ?? 0)_\(Int(Date().timeIntervalSince1970)).png" // Уникальное имя файла
              navigationController?.pushViewController(importVC, animated: true)
          }
        
        dismiss(animated: true, completion: nil)
    }
  
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension MyFotoVC: UINavigationControllerDelegate {
    
}

