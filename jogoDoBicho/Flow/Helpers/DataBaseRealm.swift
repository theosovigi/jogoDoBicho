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
    @Persisted var imageIdentifier: String? // Уникальный идентификатор или имя файла изображения
}

func checkIfAllCompleted(_ matrices: Results<Matrix>) -> Bool {
    for matrix in matrices {
        if !matrix.isCompleted {
            return false
        }
    }
    return true
}


 func checkGlobal() {
     checkAfrica()
     checkPlanet()
     checkCanada()
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
        UD.shared.africaIsOpen = true
        print("Победа")
    } else {
        print("Не подходит Африка")
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
    
    let planetNames: [String] = ["Donkey", "Dog", "Goat", "Sheep", "Rabbit", "Horse", "Rooster","Cat","Pig","Bull","Cow","Turkey",]
    
    var allCompleted = true
    
    // Проверяем, присутствуют ли все значения из перечисления ImageAfricaName в базе данных
    for imageName in planetNames {
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
        UD.shared.planetIsOpen = true

        print("Победа")
    } else {
        print("Не подходит Планета")
    }
}

func checkCanada() {
    // Создание экземпляра Realm и запрос к базе данных
    let realm = try! Realm()
    let allMatrices = realm.objects(Matrix.self)
    
    // Проверка, есть ли объекты в базе данных
    if allMatrices.isEmpty {
        print("Нет объектов в базе данных")
        return
    }
    
    let canadaNames: [String] = ["Tiger", "Bear", "Dear", "Eagle", "Snake", "Butterfly"]
    
    var allCompleted = true
    
    // Проверяем, присутствуют ли все значения из перечисления ImageAfricaName в базе данных
    for imageName in canadaNames {
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
        UD.shared.canadaIsOpen = true
        print("Победа")
    } else {
        print("Не подходит Канада")
    }
}
