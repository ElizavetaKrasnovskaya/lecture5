import Foundation

final class StorageService {
    
    static let shared = StorageService()
    private let storage = UserDefaults.standard
    
    var isFirstLaunch: Bool {
        get {
            !storage.bool(forKey: "FIRST_LAUNCH_KEY")
        }
        set {
            storage.set(!newValue, forKey: "FIRST_LAUNCH_KEY")
        }
    }
}
