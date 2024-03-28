

import Foundation

class UD {
    
    static let shared = UD()
    
    private let defaults = UserDefaults.standard
    
    var scoreCoints: Int {
        get {
            return defaults.integer(forKey: "scoreCoints", defaultValue: 300)
        }
        set {
            defaults.set(newValue, forKey: "scoreCoints")
        }
    }
    
    var scorePaint: Int {
        get {
            return defaults.integer(forKey: "scorePaint", defaultValue: 0)
        }
        set {
            defaults.set(newValue, forKey: "scorePaint")
        }
    }
    
    var lastBonusDate: Date? {
        get {
            return defaults.object(forKey: "lastBonusDate") as? Date
        }
        set {
            defaults.set(newValue, forKey: "lastBonusDate")
        }
    }
    
    var africaIsOpen: Bool {
        get {
            return defaults.bool(forKey: "isOpen")
        }
        set {
            defaults.set(newValue, forKey: "isOpen")
        }
    }
    
    var planetIsOpen: Bool {
        get {
            return defaults.bool(forKey: "isOpen")
        }
        set {
            defaults.set(newValue, forKey: "isOpen")
        }
    }

    var canadaIsOpen: Bool {
        get {
            return defaults.bool(forKey: "isOpen")
        }
        set {
            defaults.set(newValue, forKey: "isOpen")
        }
    }

    var userName: String? {
        get {
            return defaults.string(forKey: "userName")
        }
        set {
            defaults.set(newValue, forKey: "userName")
        }
    }
    
    var userID: Int? {
        get {
            return defaults.object(forKey: "userID") as? Int
        }
        set {
            defaults.set(newValue, forKey: "userID")
        }
    }
    
    var elapsedTimeInSeconds: Int {
        get {
            return defaults.integer(forKey: "elapsedTimeInSeconds", defaultValue: 0)
        }
        set {
            defaults.set(newValue, forKey: "elapsedTimeInSeconds")
        }
    }

    var savedImagePaths: [String]? {
          get {
              // Получение массива из UserDefaults
              return UserDefaults.standard.array(forKey: "savedImagePaths") as? [String]
          }
          set {
              // Сохранение массива в UserDefaults
              UserDefaults.standard.set(newValue, forKey: "savedImagePaths")
          }
      }
    
}

extension UserDefaults {
    func integer(forKey key: String, defaultValue: Int) -> Int {
        return self.object(forKey: key) as? Int ?? defaultValue
    }
    
    func setTimerElapsedTime(_ time: Int, forKey key: String) {
        self.set(time, forKey: key)
    }
    
    func timerElapsedTime(forKey key: String) -> Int {
        return self.integer(forKey: key, defaultValue: 0)
    }
}

