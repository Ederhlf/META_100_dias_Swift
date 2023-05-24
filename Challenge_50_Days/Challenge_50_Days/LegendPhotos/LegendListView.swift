
import Foundation
import UIKit

protocol LegendListViewDelegate: AnyObject {
    func selectedView(imageName: String)
}

class LegendListView: UIView {
    // MArK: Views
    let tableView = UITableView()
    
    // MARK: Properties
    var delegate: LegendListViewDelegate?
    var names: [String]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        confiureTableView()
        configureTableViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confiureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func configureTableViewLayout() {
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

// MARK:-DeLegate
extension LegendListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sslImage = names?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sslImage
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nameSelected = names?[indexPath.row]

        delegate?.selectedView(imageName: nameSelected!)
    }
}
