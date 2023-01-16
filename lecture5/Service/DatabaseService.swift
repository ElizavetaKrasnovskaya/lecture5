import Foundation
import UIKit
import CoreData

final class DatabaseService {
    
    static let shared = DatabaseService()
    
    private let isFirstLaunch = StorageService.shared.isFirstLaunch
    
    private init() {
        if isFirstLaunch {
            initBeerDatabase()
            StorageService.shared.isFirstLaunch = false
        }
    }
    
    func saveBeer(beer insert: Beer) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Beer", in: managedContext)!
        let beer = NSManagedObject(entity: entity, insertInto: managedContext)
        
        beer.setValue(insert.name, forKeyPath: "name")
        beer.setValue(insert.country, forKeyPath: "country")
        beer.setValue(insert.cost, forKeyPath: "cost")
        beer.setValue(insert.volume, forKeyPath: "volume")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Couldn't save beer. \(error), \(error.userInfo)")
        }
    }
    
    func saveTotal() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Total", in: managedContext)!
        let total = NSManagedObject(entity: entity, insertInto: managedContext)
        
        total.setValue(0.0, forKeyPath: "earnings")
        total.setValue(0.0, forKey: "selled")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Couldn't save. \(error), \(error.userInfo)")
        }
    }
    
    func getBeer() -> [NSManagedObject] {
        var beers = [NSManagedObject]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return beers }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Beer")
        
        do {
            try managedContext.fetch(fetchRequest).forEach { beers.append($0) }
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
        
        return beers
    }
    
    //doesn't work
    func getBeer(by name: String) -> Beer {
        var result = Beer(name: "", country: "", cost: 0, volume: 0.0)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return result }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "")
        let predicate = NSPredicate(format: "name = %@", argumentArray: [name])
        fetchRequest.predicate = predicate
        
        do {
            let object = try managedContext.fetch(fetchRequest).first as? NSManagedObject
            result = Beer(
                name: object?.value(forKeyPath: "name") as? String ?? "",
                country: object?.value(forKeyPath: "country") as? String ?? "",
                cost: object?.value(forKeyPath: "cost") as? Int ?? 0,
                volume: object?.value(forKeyPath: "volume") as? Double ?? 0.0)
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
        return result
    }
    
    func getEarnings() -> Double {
        var result = 0.0
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return result}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Total")
        
        do {
            try result = managedContext.fetch(fetchRequest).last?.value(forKeyPath: "earnings") as? Double ?? 0.0
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
        
        return result
    }
    
    func getSelled() -> Double {
        var result = 0.0
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return result}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Total")
        
        do {
            try result = managedContext.fetch(fetchRequest).last?.value(forKeyPath: "selled") as? Double ?? 0.0
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
        
        return result
    }
    
    func updateTotal(earnings: Double, selled: Double) {
        var total = NSManagedObject()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Total")
        
        do {
            total = try managedContext.fetch(fetchRequest).first ?? NSManagedObject()
            total.setValue(earnings, forKeyPath: "earnings")
            total.setValue(selled, forKeyPath: "selled")
            try managedContext.save()
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
    }
    
    // add id and replace with select by id
    func updateBeer(beer: Beer){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Beer")
        
        do {
            let beers = try managedContext.fetch(fetchRequest)
            beers.forEach { element in
                if element.value(forKeyPath: "name") as? String ?? "" == beer.name {
                    element.setValue(beer.name, forKey: "name")
                    element.setValue(beer.country, forKey: "country")
                    element.setValue(beer.cost, forKey: "cost")
                    element.setValue(beer.volume, forKey: "volume")
                }
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func initBeerDatabase() {
        saveBeer(beer: Beer(name: "Ferdinand", country: "Czech", cost: 10, volume: 10))
        saveBeer(beer: Beer(name: "Paulaner", country: "Germany", cost: 5, volume: 20))
        saveBeer(beer: Beer(name: "Blanche De Bruxelles", country: "Belgium", cost: 3, volume: 15))
        saveTotal()
    }
    
    private func round(_ num: Double) -> Double {
        var result = num * 100
        result += 0.5
        return Double(Int(result)) / 100
    }
}
