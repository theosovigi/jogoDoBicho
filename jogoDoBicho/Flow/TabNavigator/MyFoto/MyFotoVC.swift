//
//  MyFotoVC.swift

import AVFoundation
import Foundation
import UIKit
import RealmSwift

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
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @objc func goTakeCamera() {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
    }

}

extension MyFotoVC: UIImagePickerControllerDelegate {
    
    func saveImageToLocalImport(image: UIImage) {
        if let data = image.jpegData(compressionQuality: 1.0),
           let id = uD.userID {
            let fileName = UUID().uuidString  // Генерация уникального имени файла
            let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
            self.imageName = fileName

            do {
                try data.write(to: fileURL)
                
                // Сохраняем идентификатор изображения в объект Matrix
                let realm = try! Realm()
                if let matrix = realm.objects(Matrix.self).filter("name == %@",fileName).first {
                    try! realm.write {
                        matrix.name = fileName
                        matrix.imageIdentifier = fileName
                    }
                }
                
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
              savedImageImport = image
              let importVC = MyImportVC()
              importVC.importedImage = image
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

