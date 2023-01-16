import Foundation

final class InfoViewModel {
    
    static let shared = InfoViewModel()
    
    @Published var volume = 0.0
    
    private let service = PubService.shared
    private let databaseService = DatabaseService.shared
    
    func buyBeer(with beer: Beer, value: Double) -> Double {
        var beerToUpdate = beer
        if (beerToUpdate.volume < value) { return -1 }
                
        beerToUpdate.volume -= value
        beerToUpdate.volume = round(beerToUpdate.volume)
        volume = beerToUpdate.volume

        databaseService.updateBeer(beer: beerToUpdate)
        
        let price = value * Double(beerToUpdate.cost)
        
        let totalSelled = databaseService.getSelled() + value
        let earnings = databaseService.getEarnings() + price
        databaseService.updateTotal(earnings: round(earnings), selled: round(totalSelled))
        
        return round(price)
    }
    
    func round(_ num: Double) -> Double {
        var result = num * 100
        result += 0.5
        return Double(Int(result)) / 100
    }
    
    private init() { }
}
