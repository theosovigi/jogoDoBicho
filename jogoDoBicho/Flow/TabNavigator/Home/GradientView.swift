//
//  GradientView.swift
//  jogoDoBicho
import Foundation
import UIKit

class GradientBackgroundView: UIView {

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradient()
    }

    private func setupGradient() {
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [#colorLiteral(red: 0.6705882353, green: 0.9411764706, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.7490196078, green: 0.9568627451, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.3647058824, green: 0.8862745098, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.462745098, green: 0.9019607843, blue: 1, alpha: 1).cgColor]
        gradientLayer.locations = [0.0, 0.33, 0.67, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
}

// Пример использования:
let gradientView = GradientBackgroundView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
// Добавьте gradientView в иерархию ваших UIView, чтобы он был виден на экране
