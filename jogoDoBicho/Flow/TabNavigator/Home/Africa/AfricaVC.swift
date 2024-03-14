//
//  Image1VC.swift


import Foundation
import UIKit
import SnapKit

class AfricaVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    var pixelArtImage: UIImage?
    
    private lazy var imageArt: PixelArtView = {
       let iv = PixelArtView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private lazy var imageArtOne: PixelArtView = {
       let iv = PixelArtView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    var contentView: AfricaView {
        view as? AfricaView ?? AfricaView()
    }
    
    override func loadView() {
        view = AfricaView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        imagePicker.delegate = self
        view.addSubview(imageArt)
        view.addSubview(imageArtOne)

        imageArt.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(100)
            make.size.equalTo(100)
        }
        
        imageArtOne.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(100)
            make.size.equalTo(100)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePixArt(_:)))
        imageArt.addGestureRecognizer(tapGesture)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let converter = PixelArtConverter()
            let image = UIImage(resource: .tiger)
            let imageOne = UIImage(resource: .ball)
            let convertedImage = converter.convertToPixelArt(image: image)
            let convertedImageOne = converter.convertToPixelArt(image: imageOne)
            self.imageArt.setup(image: convertedImage!)
            self.imageArtOne.setup(image: convertedImageOne!)
//        }
    }

    private func setupGestureRecognizer() {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePixArt(_:)))
       }
    
    

       @objc private func handlePixArt(_ gesture: UITapGestureRecognizer) {
           let vc = CanadaVC()
           navigationController?.pushViewController(vc, animated: true)
           
       }
    
    func openPhotoLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // - MARK: - Create PixelArt image

    func createPixelArt(from image: UIImage) -> UIImage? {
        let grayscaleImage = convertToGrayscale(image: image)
        let width = view.frame.width * 0.9 / 10
        let size = CGSize(width: width, height: width)
        
        // Resize to 20x20
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        grayscaleImage?.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
    
    // - MARK: - Create white-black image
    func convertToGrayscale(image: UIImage) -> UIImage? {
            let context = CIContext(options: nil)
            let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
            let beginImage = CIImage(image: image)
            currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
            
            if let output = currentFilter!.outputImage, let cgimg = context.createCGImage(output, from: output.extent) {
                return UIImage(cgImage: cgimg)
            }
            return nil
        }
}



