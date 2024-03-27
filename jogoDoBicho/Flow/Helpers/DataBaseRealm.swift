//
//  DataBaseRealm.swift
//  jogoDoBicho
//
//  Created by apple on 25.03.2024.
//

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

func main() {
    // Создание экземпляра Realm и запрос к базе данных
    let realm = try! Realm()
    let allMatrices = realm.objects(Matrix.self)
    
    // Проверка, все ли элементы из перечисления ImageAfricaName имеют isCompleted = true
    if checkIfAllCompleted(allMatrices) {
        print("Все заполнено")
    } else {
        print("Неудача")
    }
    if let matrixAfrica = realm.objects(Matrix.self).filter("name = 'Africa'").first {
         // Проверяем, есть ли в этом объекте Matrix нужные значения из ImageAfricaName
         if let africaImage = ImageAfricaName(rawValue: matrixAfrica.name) {
             print("Matrix содержит информацию о \(africaImage.rawValue)")
         } else {
             print("Matrix не содержит информацию о ImageAfricaName")
         }
     } else {
         print("Matrix с именем 'Africa' не найден")
     }
}

