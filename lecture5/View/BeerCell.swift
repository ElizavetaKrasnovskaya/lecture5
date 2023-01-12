import UIKit

class BeerCell: UITableViewCell {

    @IBOutlet weak var beerName: UILabel!
    
    public func setup(with beer: Beer) {
        beerName.text = beer.name
    }
}
