//
//  PaintVC.swift
//  jogoDoBicho
//
//  Created by apple on 18.03.2024.
//

import Foundation
import SnapKit
import UIKit

class PaintVC: UIViewController {
    private let imageView: UIImageView
    private let imageLabelText: String? 
    private var timer: Timer?
    private var elapsedTimeInSeconds = 0
    private let pixelArtConverter = PixelArtConverter()

    private var isImageFilled = false

    var contentView: PaintView {
        view as? PaintView ?? PaintView()
    }
    
    override func loadView() {
        view = PaintView()
    }

    init(image: UIImage,labelText: String?) {
        self.imageView = UIImageView(image: image)
        self.imageLabelText = labelText
        super.init(nibName: nil, bundle: nil)
        let blackAndWhiteImage = pixelArtConverter.convertToGrayscale(image: image)
        contentView.blackWhiteImgView.image = blackAndWhiteImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        tappedButtons()
        startTimer()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true

    }
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
            stopTimer()
        }

    private func configureView() {
        contentView.imageView.image = imageView.image
        contentView.imageLabel.text = imageLabelText
    }
    
    
    private func tappedButtons() {
        contentView.closeBtn.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        contentView.visionBtn.addTarget(self, action: #selector(visionButtonTouchDown), for: .touchDown)
        contentView.visionBtn.addTarget(self, action: #selector(visionButtonTouchUpInside), for: .touchUpInside)

    }
    
    private func startTimer() {
          timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
      }
    
    private func stopTimer() {
            timer?.invalidate()
        }
    
    @objc private func updateTimer() {
        elapsedTimeInSeconds += 1
        let minutes = elapsedTimeInSeconds / 60
        let seconds = elapsedTimeInSeconds % 60
        
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        contentView.timeLabel.text = timeString
    }

    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
       }
    
    @objc private func visionButtonTouchDown() {
        contentView.imageView.isHidden = false
    }

    @objc private func visionButtonTouchUpInside() {
        contentView.imageView.isHidden = true
    }
}
