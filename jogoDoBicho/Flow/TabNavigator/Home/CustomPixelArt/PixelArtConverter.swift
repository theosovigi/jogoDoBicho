//
//  PixelArtConverter.swift
//  jogoDoBicho
//
//  Created by apple on 14.03.2024.
//

import UIKit
import CoreGraphics

class PixelArtConverter {
    
    func convertToPixelArt(image: UIImage) -> UIImage? {
        let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 20, height: 20))
        
        let grayscaleImage = convertToGrayscale(image: resizedImage)
        
        
        return grayscaleImage
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: targetSize)
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
        image.draw(in: rect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
    
    private func convertToGrayscale(image: UIImage) -> UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir")
        let beginImage = CIImage(image: image)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        
        if let output = currentFilter!.outputImage, let cgimg = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgimg)
        }
        return image
    }
}
