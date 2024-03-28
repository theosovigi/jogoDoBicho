//
//  MyFotoVC.swift

import AVFoundation
import Foundation
import UIKit

class MyFotoVC: UIViewController {
    private var imageName: String?
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
        contentView.photoBtn.addTarget(self, action: #selector(goTakeCamera), for: .touchUpInside)
        
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
        let alert = UIAlertController(title: "Pick Library", message: nil, preferredStyle: .actionSheet)
       
        let actionLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(actionLibrary)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @objc func goTakeCamera() {
        let alert = UIAlertController(title: "Pick Photo", message: nil, preferredStyle: .actionSheet)
        
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
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }

}

extension MyFotoVC: UIImagePickerControllerDelegate {
    
//    func saveImageToLocalImport(image: UIImage) {
//        if let data = image.jpegData(compressionQuality: 1.0),
//            let id = uD.userID {
//            // Получаем текущий массив путей
//            var savedImages = uD.savedImagePaths ?? []
//            
//            // Определяем номер следующего изображения
//            let nextImageNumber = savedImages.count + 1
//            
//            // Создаем имя файла на основе порядкового номера изображения
//            let fileName = "Your image \(nextImageNumber).png"
//            let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
//            
//            do {
//                try data.write(to: fileURL)
//                
//                // Добавляем новый путь к массиву и сохраняем его в UserDefaults
//                savedImages.append(fileURL.path)
//                uD.savedImagePaths = savedImages
//                
//            } catch {
//                print("Error saving image: \(error)")
//            }
//        }
//    }

    func saveImageToLocalImport(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 1.0),
            let id = uD.userID {
            // Получаем текущий массив путей
            var savedImages = uD.savedImagePaths ?? []
            
            // Определяем номер следующего изображения
            let nextImageNumber = savedImages.count + 1
            
            // Создаем имя файла на основе порядкового номера изображения
            let fileName = "image \(nextImageNumber)"
            let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
            
            do {
                try data.write(to: fileURL)
                
                // Добавляем новый путь к массиву и сохраняем его в UserDefaults
                savedImages.append(fileURL.path)
                uD.savedImagePaths = savedImages
                
                // Сохраняем имя файла в переменной imageName
                self.imageName = fileName
                
            } catch {
                print("Error saving image: \(error)")
            }
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
              importVC.imageName = self.imageName ?? "DefaultImageName"
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

