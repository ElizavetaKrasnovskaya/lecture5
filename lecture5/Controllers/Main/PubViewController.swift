import UIKit
import Combine

class PubViewController: UIViewController {

    private let CELL_IDENTIFIER = "BEER_CELL"
    private var selectedBeerName: String = ""
    private var viewModel = PubViewModel.shared
    private var bindings = Set<AnyCancellable>()
    
    private var beers = [Beer]() {
        didSet {
            beerTableView.reloadData()
        }
    }
    private var totalSelled = 0.0 {
        didSet {
            labelSoldBeer.text = "Earnings per day: \(totalSelled) ₽"
        }
    }
    private var earnings = 0.0 {
        didSet {
            labelEarningsPerDay.text = "Sold beer: \(earnings) ltr"
        }
    }
    
    @IBOutlet weak var labelEarningsPerDay: UILabel!
    @IBOutlet weak var labelSoldBeer: UILabel!
    @IBOutlet weak var beerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        initView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getBeers()
        viewModel.getInfo()
    }
    
    func bindViewModel() {
        viewModel.$beers
            .assign(to: \.beers, on: self)
            .store(in: &bindings)
        viewModel.$totalSelled
            .assign(to: \.totalSelled, on: self)
            .store(in: &bindings)
        viewModel.$earnings
            .assign(to: \.earnings, on: self)
            .store(in: &bindings)
    }
    
    @IBAction func onNewDayClick(_ sender: UIButton) {
        viewModel.updateForNewDay()
    }
    
    // TODO add file with strings
    private func initView(){
        title = "THE BEST PUB"
    }
    
    private func setupTable() {
        beerTableView.delegate = self
        beerTableView.dataSource = self
        let cellNib = UINib(nibName: "BeerCell", bundle: nil)
        beerTableView.register(cellNib, forCellReuseIdentifier: CELL_IDENTIFIER)
    }
}

extension PubViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as? BeerCell
        else { return UITableViewCell() }
        cell.setup(with: beers[index])
        return cell
    }
    
    //TODO navigation on click button
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToInfo(with: index)
    }
    
    private func navigateToInfo(with index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let infoViewController = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController
        else { return }
        infoViewController.index = index
        navigationController?.pushViewController(infoViewController, animated: true)
    }
}
