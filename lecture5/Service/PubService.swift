import Foundation

/*  Singleton
 create instance with static let shared
 */
class PubService {
    
    static let shared = PubService()
        
    var earnings = 0.0
    var totalSelled = 0.0
    
    private init() {}
    
    func buyBeer(index: Int, volume: Double) -> Double {
//        if (beers[index].volume < volume) { return -1 }
//
//        beers[index].volume -= volume
//        beers[index].volume = round(beers[index].volume)
//
//        let price = volume * Double(beers[index].cost)
//
//        totalSelled += volume
//        totalSelled = round(totalSelled)
//
//        earnings += price
//        earnings = round(earnings)
//
//        return round(price)
        return 0.0
    }
    
    func round(_ num: Double) -> Double {
        var result = num * 100
        result += 0.5
        return Double(Int(result)) / 100
    }
}
