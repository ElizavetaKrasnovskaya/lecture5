import Foundation

final class InfoViewModel {
    
    static let shared = InfoViewModel()
    
    @Published var beer = Beer(name: "", country: "", cost: 0, volume: 0)
    
    private let service = PubService.shared
    
    func getBeer(with index: Int) {
        beer = service.beers[index]
    }
    
    func buyBeer(with index: Int, volume: Double) -> Double {
        return service.buyBeer(index: index, volume: volume)
    }
    
    private init() { }
}
