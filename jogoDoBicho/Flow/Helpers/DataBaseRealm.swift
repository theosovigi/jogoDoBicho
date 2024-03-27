//
//  DataBaseRealm.swift



import Foundation
import RealmSwift

class Matrix: Object {
    
    @Persisted var savedColors: List<Int> // Используем List<Int> для хранения числовых значений цветов
    @Persisted var name: String
    @Persisted var totalCountPix: Int = 0
    @Persisted var coloredCountPix: Int = 0
    @Persisted var isCompleted: Bool = false
//    @Persisted var namePlanet: String

}

func checkIfAllCompleted(_ matrices: Results<Matrix>) -> Bool {
    for matrix in matrices {
        if !matrix.isCompleted {
            return false
        }
    }
    return true
}

func checkAfrica() {
    // Создание экземпляра Realm и запрос к базе данных
    let realm = try! Realm()
    let allMatrices = realm.objects(Matrix.self)
    
    // Проверка, есть ли объекты в базе данных
    if allMatrices.isEmpty {
        print("Нет объектов в базе данных")
        return
    }
    
    let africaNames: [String] = ["Ostrich", "Crocodile", "Lion", "Monkey", "Peacock", "Elephant", "Camel"]
    
    var allCompleted = true
    
    // Проверяем, присутствуют ли все значения из перечисления ImageAfricaName в базе данных
    for africaName in africaNames {
        if let matrix = realm.objects(Matrix.self).filter("name = '\(africaName)'").first {
            print("Объект с именем '\(africaName)' найден")
            if !matrix.isCompleted {
                allCompleted = false
            }
        } else {
            print("Объект с именем '\(africaName)' не найден")
            allCompleted = false
        }
    }
    
    if allCompleted {
        print("Победа")
    } else {
        print("Не подходит")
    }
}

func checkPlanet() {
    // Создание экземпляра Realm и запрос к базе данных
    let realm = try! Realm()
    let allMatrices = realm.objects(Matrix.self)
    
    // Проверка, есть ли объекты в базе данных
    if allMatrices.isEmpty {
        print("Нет объектов в базе данных")
        return
    }
    
    let imageNames: [String] = ["Donkey", "Crocodile", "Lion", "Monkey", "Peacock", "Elephant", "Camel"]
    
    var allCompleted = true
    
    // Проверяем, присутствуют ли все значения из перечисления ImageAfricaName в базе данных
    for imageName in imageNames {
        if let matrix = realm.objects(Matrix.self).filter("name = '\(imageName)'").first {
            print("Объект с именем '\(imageName)' найден")
            if !matrix.isCompleted {
                allCompleted = false
            }
        } else {
            print("Объект с именем '\(imageName)' не найден")
            allCompleted = false
        }
    }
    
    if allCompleted {
        print("Победа")
    } else {
        print("Не подходит")
    }
}


