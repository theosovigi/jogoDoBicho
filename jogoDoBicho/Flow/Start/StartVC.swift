//
//  StartVC.swift
//  jogoDoBicho


import Foundation
import UIKit
import SnapKit

class StartVC: UIViewController {
    
    private let authBack = AuthServiceBack.shared
    private let ud = UD.shared
    private let postBack = PostServiceBack.shared

    var contentView: StartView {
        view as? StartView ?? StartView()
    }
    
    override func loadView() {
        view = StartView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        animateProgressBar()
    }
    
    func animateProgressBar() {
        UIView.animate(withDuration: 1.5) {
            self.contentView.loadView.setProgress(1.0, animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                  self.loadHomeVC()
    }
}
    

    func loadHomeVC() {
            Task {
                do {
                    try await authBack.authenticate()
                    checkToken()
                    createUserIfNeeded()
                    let vc = TabBarNavigator()
                    let navigationController = UINavigationController(rootViewController: vc)
                    navigationController.modalPresentationStyle = .fullScreen
                    present(navigationController, animated: true)
                    navigationController.setNavigationBarHidden(true, animated: false)
                } catch {
                    print("Error: \(error.localizedDescription)")
                    let vc = TabBarNavigator()
                    let navigationController = UINavigationController(rootViewController: vc)
                    navigationController.modalPresentationStyle = .fullScreen
                    present(navigationController, animated: true)
                    navigationController.setNavigationBarHidden(true, animated: false)
                }
            }
        }
    
    private func createUserIfNeeded() {
        if ud.userID == nil {
            let payload = CreateRequestPayload(name: nil, score: 300)
            postBack.createUser(payload: payload) { [weak self] createResponse in
                guard let self = self else { return }
                ud.userID = createResponse.id
            } errorCompletion: { error in
                print("Ошибка получени данных с бека")
            }
        }
    }
    
    private func checkToken() {
        guard let token = authBack.token else {
            return
        }
        print("token -- \(token)")

    }

    
}
