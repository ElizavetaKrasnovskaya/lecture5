import Foundation

final class PubViewModel {
    
    static let shared = PubViewModel()
    
    @Published var beers = [Beer]()
    @Published var totalSelled = 0.0
    @Published var earnings = 0.0
    
    private let service = PubService.shared
    
    func getBeers() {
        beers.removeAll()
        service.beers.forEach {
            beers.append($0)
        }
    }
    
    func getInfo() {
        totalSelled = service.totalSelled
        earnings = service.earnings
    }
    
    func updateForNewDay() {
        service.totalSelled = 0
        service.earnings = 0
        earnings = 0
        totalSelled = 0
    }
    
    private init() { }
}
