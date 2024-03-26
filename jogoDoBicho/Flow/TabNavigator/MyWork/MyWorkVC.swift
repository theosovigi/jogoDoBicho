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
        configureCompletedCollectionView()
        tappedButtons()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateCollectionView()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
    
    private func configureCompletedCollectionView() {
        contentView.completedCollection.dataSource = self
        contentView.completedCollection.delegate = self
        contentView.completedCollection.register(CompletedCell.self, forCellWithReuseIdentifier: "CompletedCell")
        contentView.completedCollection.isHidden = true // Скрыть при инициализации
    }
    
    private func tappedButtons() {
        contentView.inProgressBtn.addTarget(self, action: #selector(inProgressTapped), for: .touchUpInside)
        contentView.completedBtn.addTarget(self, action: #selector(completedTapped), for: .touchUpInside)
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getImageForUserID(_ userID: String) -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent("\(userID).png")
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("Error loading image from local storage")
            return nil
        }
    }

    private func updateCollectionView() {
        
        let config = Realm.Configuration(
            schemaVersion: 3, // Предполагаем, что предыдущая версия была 0
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
            contentView.completedCollection.isHidden = true // Скрыть коллекцию, если нет объектов в Realm
            
        }
        contentView.inProgressCollection.reloadData()
        contentView.completedCollection.reloadData()
        
    }
    
    @objc private func inProgressTapped() {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.customFont(font: .baloo, style: .regular, size: 20),
            .foregroundColor: UIColor.customBlue]
        let attributedTitle = NSAttributedString(string: "In progress", attributes: attributes)
        contentView.inProgressBtn.setAttributedTitle(attributedTitle, for: .normal)
        
        let attributesInProgress: [NSAttributedString.Key: Any] = [
            .font: UIFont.customFont(font: .baloo, style: .regular, size: 20),
            .foregroundColor: UIColor.white]
        let attributedTitleInProgress = NSAttributedString(string: "Completed", attributes: attributesInProgress)
        contentView.completedBtn.setAttributedTitle(attributedTitleInProgress, for: .normal)
        contentView.inProgressCollection.isHidden = false
        contentView.completedCollection.isHidden = true
    }
    
    @objc private func completedTapped() {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.customFont(font: .baloo, style: .regular, size: 20),
            .foregroundColor: UIColor.customBlue
        ]
        let attributedTitle = NSAttributedString(string: "Completed", attributes: attributes)
        
        contentView.completedBtn.setAttributedTitle(attributedTitle, for: .normal)
        let attributesInProgress: [NSAttributedString.Key: Any] = [
            .font: UIFont.customFont(font: .baloo, style: .regular, size: 20),
            .foregroundColor: UIColor.white         ]
        let attributedTitleInProgress = NSAttributedString(string: "In progress", attributes: attributesInProgress)
        contentView.inProgressBtn.setAttributedTitle(attributedTitleInProgress, for: .normal)
        contentView.inProgressCollection.isHidden = true
        contentView.completedCollection.isHidden = false
    }
    
}

extension MyWorkVC: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let realm = try! Realm()
        if collectionView == contentView.inProgressCollection {
            // Возвращает количество объектов, которые не завершены
            return realm.objects(Matrix.self).filter("isCompleted == false").count
        } else if collectionView == contentView.completedCollection {
            // Возвращает количество завершенных объектов
            return realm.objects(Matrix.self).filter("isCompleted == true").count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let realm = try! Realm()
        
        // Получаем объекты в зависимости от статуса завершенности и выбранного collectionView
        let matrixObjects = collectionView == contentView.inProgressCollection ?
            realm.objects(Matrix.self).filter("isCompleted == false") :
            realm.objects(Matrix.self).filter("isCompleted == true")
        
        let matrix = matrixObjects[indexPath.row] // Получаем данные для конкретной ячейки

        if collectionView == contentView.inProgressCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InProgressCell", for: indexPath) as! InProgressCell
            let userImage = getImageForUserID("\(UD.shared.userID ?? 0)")
            cell.configure(with: matrix, userImage: userImage)
//            cell.configure(with: matrix)
            cell.continueButtonAction = {
                // Попытка загрузить изображение по имени из ресурсов проекта
                if let image = UIImage(named: "\(matrix.name.lowercased())PixColor") {
                    let paintVC = PaintVC(image: image, labelText: matrix.name)
                    self.navigationController?.pushViewController(paintVC, animated: true)
                } else {
                    // Попытка загрузить пользовательское изображение из локального хранилища
                    if let userImage = self.getImageForUserID("\(UD.shared.userID ?? 0)") {
                        // Создаем PaintVC с пользовательским изображением
                        let paintVC = PaintVC(image: userImage, labelText: matrix.name)
                        self.navigationController?.pushViewController(paintVC, animated: true)
                    } else {
                        // Если изображение не найдено, выводим сообщение об ошибке
                        print("Изображение \(matrix.name.lowercased())PixColor или пользовательское изображение не найдено")
                    }
                }
            }

            
            return cell
        } else if collectionView == contentView.completedCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompletedCell", for: indexPath) as! CompletedCell
            cell.configureCompleted(with: matrix) // Предполагаем, что у вас есть такой метод для CompletedCell
            // Дополнительная конфигурация cell
            return cell
        }
        
        return UICollectionViewCell()
    }
}

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let realm = try! Realm()
//        let matrix = realm.objects(Matrix.self)[indexPath.row] // Пример получения данных
//        
//        if collectionView == contentView.inProgressCollection {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InProgressCell", for: indexPath) as! InProgressCell
//            cell.configure(with: matrix)
//            cell.continueButtonAction = {
//                let paintVC = PaintVC(image: UIImage(named: "\(matrix.name)PixColor")!, labelText: matrix.name)
//                self.navigationController?.pushViewController(paintVC, animated: true)
//            }
//            return cell
//        } else if collectionView == contentView.completedCollection {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompletedCell", for: indexPath) as! CompletedCell
//            cell.configureCompleted(with: matrix) // Предполагаем, что у вас есть такой метод для CompletedCell
//            // Дополнительная конфигурация cell
//            return cell
//        }
//        return UICollectionViewCell()
//    }
//
extension MyWorkVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let numberOfItemsPerRow: CGFloat = 5
        let cellWidth = collectionViewWidth / numberOfItemsPerRow
        return CGSize(width: cellWidth, height: 100) // Ширина ячейки будет равна ширине коллекции, деленной на количество ячеек в строке
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // Устанавливаем отступы между ячейками по горизонтали
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // Устанавливаем отступы между ячейками по вертикали
    }
}
