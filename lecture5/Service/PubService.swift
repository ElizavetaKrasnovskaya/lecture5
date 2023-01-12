import Foundation

/*  Singleton
 create instance with static let shared
 */
class PubService {
    
    static let shared = PubService()
    
    //TODO remove to database
    var beers = [
        Beer(
            name: "Ferdinand",
            country: "Czech",
            cost: 10,
            volume: 10
        ),
        Beer(
            name: "Paulaner",
            country: "Germany",
            cost: 5,
            volume: 20
        ),
        Beer(
            name: "Blanche De Bruxelles",
            country: "Belgium",
            cost: 3,
            volume: 15
        ),
        Beer(
            name: "Ferdinand",
            country: "Czech",
            cost: 10,
            volume: 10
        ),
        Beer(
            name: "Paulaner",
            country: "Germany",
            cost: 5,
            volume: 20
        ),
        Beer(
            name: "Blanche De Bruxelles",
            country: "Belgium",
            cost: 3,
            volume: 15
        ),
        Beer(
            name: "Ferdinand",
            country: "Czech",
            cost: 10,
            volume: 10
        ),
        Beer(
            name: "Paulaner",
            country: "Germany",
            cost: 5,
            volume: 20
        ),
        Beer(
            name: "Blanche De Bruxelles",
            country: "Belgium",
            cost: 3,
            volume: 15
        ),
    ]
    
    var earnings = 0.0
    var totalSelled = 0.0
    
    private init() {}
    
    func getBeerByName(name: String) -> (Beer?, Int) {
        var beerResult: Beer? = nil
        var indexResult: Int = -1
        for (index, beer) in beers.enumerated(){
            if beer.name.contains(name){
                beerResult = beer
                indexResult = index
            }
        }
        return (beerResult, indexResult)
    }
    
    func buyBeer(index: Int, volume: Double) -> Double {
        if (beers[index].volume < volume) { return -1 }
        
        beers[index].volume -= volume
        beers[index].volume = round(beers[index].volume)
        
        let price = volume * Double(beers[index].cost)
        
        totalSelled += volume
        totalSelled = round(totalSelled)
        
        earnings += price
        earnings = round(earnings)
        
        return round(price)
    }
    
    func round(_ num: Double) -> Double {
        var result = num * 100
        result += 0.5
        return Double(Int(result)) / 100
    }
}
