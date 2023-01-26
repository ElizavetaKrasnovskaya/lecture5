import Foundation
import CoreData
import UIKit

final class PubViewModel {
    
    static let shared = PubViewModel()
    
    @Published var beers = [Beer]()
    @Published var totalSelled = 0.0
    @Published var earnings = 0.0
    
    private let databaseService = DatabaseService.shared
    
    // TODO mapper
    func getBeers() {
        beers.removeAll()
        let beerObjects = databaseService.getBeer()
        beerObjects.forEach { beer in
            beers.append(Beer(
                name: beer.value(forKeyPath: "name") as? String ?? "",
                country: beer.value(forKeyPath: "country") as? String ?? "",
                cost: beer.value(forKeyPath: "cost") as? Int ?? 0,
                volume: beer.value(forKeyPath: "volume") as? Double ?? 0.0))
        }
    }
    
    func getInfo() {
        totalSelled = databaseService.getSelled()
        earnings = databaseService.getEarnings()
    }
    
    func updateForNewDay() {
        databaseService.updateTotal(earnings: 0.0, selled: 0.0)
        earnings = 0
        totalSelled = 0
    }
    
    private init() { }
}
