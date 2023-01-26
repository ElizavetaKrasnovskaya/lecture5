import UIKit
import Combine

class InfoViewController: UIViewController {
    
    //TODO replace with id
    var beer: Beer = Beer(name: "", country: "", cost: 0, volume: 0.0)
    
    private var viewModel = InfoViewModel.shared
    private var bindings = Set<AnyCancellable>()
    private var volume = 0.0 {
        didSet {
            lblVolume.text = String("\(beer.volume) ltr")
        }
    }
    
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblVolume: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bindViewModel()
    }
    
    private func initView() {
        title = beer.name
        lblCountry.text = beer.country
        lblVolume.text = String("\(beer.volume) ltr")
        lblCost.text = String("\(beer.cost)₽")
    }
    
    private func bindViewModel() {
        viewModel.$volume
            .assign(to: \.volume, on: self)
            .store(in: &bindings)
    }
    
    @IBAction func onBuyBtnClick(_ sender: UIButton) {
        let volume: Double
        
        switch sender.tag {
        case 0: volume = 0.33
        case 1: volume = 0.5
        case 2: volume = 1.0
        default: volume = 0.0
        }
        
        beer.volume -= volume
        let price = viewModel.buyBeer(with: beer, value: volume)
        
        showAlert(withPrice: price)
    }
    
    // TODO add ext for alert
    private func showAlert(withPrice price: Double) {
        let currentRemain = beer.volume
        if price == -1 {
            showAlert(withTitle: "Something went wrong...", message: "Not enough beer. Total volume: \(currentRemain) ltr")
        } else {
            showAlert(withTitle: "Succes!", message: "Cost of beer: \(price)₽. Total volume: \(currentRemain) ltr")
        }
    }
    
    private func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
}
