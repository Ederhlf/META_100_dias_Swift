
import Foundation
import UIKit

class ScoreListViewController: UITableViewController {
    var list = [Challengers]()
    var myModel: SocreListViewModel?
    
    override func loadView() {
        super.loadView()
        myModel = SocreListViewModel()
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Melhores pontuacoes"
        view.backgroundColor = .systemGreen
        tableView.register(ScoreListCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        list.removeAll()
        let sortedList = myModel?.getChallengersList().sorted(by: { $0.gain > $1.gain})
        list = sortedList ?? []
        
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScoreListCell
        let scoreChallengers = list[indexPath.row]
        cell.name.text = "\(indexPath.row + 1)º  \(scoreChallengers.name)"
        cell.gain.text = " Acertos: \(scoreChallengers.gain)"
        cell.fail.text = " Erros: \(scoreChallengers.fail)" 
        cell.backgroundColor = .clear
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }   
}
