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

}
