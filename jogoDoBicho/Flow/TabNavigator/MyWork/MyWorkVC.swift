//
//  MyWorkVC.swift


import Foundation
import UIKit
import RealmSwift


class MyWorkVC: UIViewController {
    
    
    var contentView: MyWorkView {
        view as? MyWorkView ?? MyWorkView()
    }
    
    override func loadView() {
        view = MyWorkView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        tappedButtons()
        updateCollectionView()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        updateCollectionView()
        checkObjects()

    }
    
    private func checkObjects() {
        let realm = try! Realm()
        let objectsCount = realm.objects(Matrix.self).count
        print("Количество объектов в базе данных: \(objectsCount)")
    }
    
    private func configureCollectionView() {
        contentView.inProgressCollection.dataSource = self
        contentView.inProgressCollection.delegate = self
        contentView.inProgressCollection.register(InProgressCell.self, forCellWithReuseIdentifier: "InProgressCell")

    }
    
    private func tappedButtons() {
        contentView.inProgressBtn.addTarget(self, action: #selector(inProgressTapped), for: .touchUpInside)
        contentView.completedBtn.addTarget(self, action: #selector(completedTapped), for: .touchUpInside)
        
    }
    
    private func updateCollectionView() {
        
        let config = Realm.Configuration(
            schemaVersion: 1, // Предполагаем, что предыдущая версия была 0
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
         let realm = try! Realm()
         let objectsCount = realm.objects(Matrix.self).count
         
         if objectsCount == 0 {
             contentView.inProgressCollection.isHidden = true // Скрыть коллекцию, если нет объектов в Realm
         }
         contentView.inProgressCollection.reloadData()
     }
    
    @objc private func inProgressTapped() {
        let attributes: [NSAttributedString.Key: Any] = [
               .underlineStyle: NSUnderlineStyle.single.rawValue, // Добавление подчеркивания
               .font: UIFont.customFont(font: .baloo, style: .regular, size: 20), // Установка шрифта
               .foregroundColor: UIColor.customBlue // Установка цвета текста
           ]
           let attributedTitle = NSAttributedString(string: "In progress", attributes: attributes)
        contentView.inProgressBtn.setAttributedTitle(attributedTitle, for: .normal)
        
        let attributesInProgress: [NSAttributedString.Key: Any] = [
            .font: UIFont.customFont(font: .baloo, style: .regular, size: 20), // Установка шрифта
            .foregroundColor: UIColor.white // Установка белого цвета текста
        ]
        let attributedTitleInProgress = NSAttributedString(string: "Completed", attributes: attributesInProgress)
        contentView.completedBtn.setAttributedTitle(attributedTitleInProgress, for: .normal)
        contentView.inProgressCollection.isHidden = false
    }
    
    @objc private func completedTapped() {
        let attributes: [NSAttributedString.Key: Any] = [
               .underlineStyle: NSUnderlineStyle.single.rawValue, // Добавление подчеркивания
               .font: UIFont.customFont(font: .baloo, style: .regular, size: 20), // Установка шрифта
               .foregroundColor: UIColor.customBlue // Установка цвета текста
           ]
           let attributedTitle = NSAttributedString(string: "Completed", attributes: attributes)
        
        contentView.completedBtn.setAttributedTitle(attributedTitle, for: .normal)
        let attributesInProgress: [NSAttributedString.Key: Any] = [
            .font: UIFont.customFont(font: .baloo, style: .regular, size: 20), // Установка шрифта
            .foregroundColor: UIColor.white // Установка белого цвета текста
        ]
        let attributedTitleInProgress = NSAttributedString(string: "In progress", attributes: attributesInProgress)
        contentView.inProgressBtn.setAttributedTitle(attributedTitleInProgress, for: .normal)
        contentView.inProgressCollection.isHidden = true
    }
    
}

extension MyWorkVC: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let realm = try! Realm()
        return realm.objects(Matrix.self).count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InProgressCell", for: indexPath) as! InProgressCell
        let realm = try! Realm()
        let matrix = realm.objects(Matrix.self)[indexPath.item]
        cell.configure(with: matrix)
        cell.continueButtonAction = {
            let paintVC = PaintVC(image: UIImage(named: "\(matrix.name)PixColor")!, labelText: matrix.name)
            self.navigationController?.pushViewController(paintVC, animated: true)
        }
        return cell

    }
}

extension MyWorkVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10 // Расстояние между ячейками и границами экрана
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2) // Размер для 2 ячеек в ряд
    }
}

