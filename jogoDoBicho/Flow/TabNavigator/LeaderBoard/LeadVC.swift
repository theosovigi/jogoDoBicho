//
//  LeadVC.swift


import Foundation
import UIKit
import SnapKit


class LeadVC: UIViewController {
    
    var users = [User]()
    let getRequestService = GetServiceBack.shared
    private var loader: UIActivityIndicatorView!

    private var contentView: LeadView {
        view as? LeadView ?? LeadView()
    }
    
    override func loadView() {
        view = LeadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loaderConfigure()
        loadUsers()
        configureTableView()
    }
    
    private func configureTableView() {
        contentView.leaderBoardTableView.dataSource = self
        contentView.leaderBoardTableView.delegate = self
        contentView.leaderBoardTableView.separatorStyle = .none
        
    }

    private func loaderConfigure() {
        loader = UIActivityIndicatorView(style: .medium)
        loader.hidesWhenStopped = true
        loader.color = .customBlue
        contentView.addSubview(loader)
        loader.transform = CGAffineTransform(scaleX: 2, y: 2)
        loader.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }


func sorterScoreUsers() {
    users.sort {
        $1.score < $0.score
    }
}

func loadUsers() {
    loader.startAnimating()
    getRequestService.fetchData { [weak self] users in
        guard let self = self else { return }
        self.users = users
        self.contentView.leaderBoardTableView.reloadData()
        self.sorterScoreUsers()
        self.loader.stopAnimating()
    } errorCompletion: { [weak self] error in
        guard self != nil else { return }
        self?.loader.stopAnimating()
        
        }
    }
}

extension LeadVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeadCell.reuseId, for: indexPath)
        
        guard let leaderCell = cell as? LeadCell else {
            
            return cell
        }
        
        
        let index = indexPath.row
        
        let user = users[index]
        
        setupCell(leaderBoardCell: leaderCell, user: user)
        
        return leaderCell
    }
    
    func setupCell(leaderBoardCell: LeadCell, user: User) {
        
        leaderBoardCell.scoreLabel.text = String(user.score)
        leaderBoardCell.nameLabel.text = user.name == nil || user.name == "" ? "USER# \(user.id ?? 0)" : user.name
        
    }
    
}

