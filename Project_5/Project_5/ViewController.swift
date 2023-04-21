
import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var useWords = [String]()
    
    
    var myModel: ViewModel?
    
    override func loadView() {
        super.loadView()
        myModel = ViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = UIColor.clear
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(promptForAnswer)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(startgame)
        )
        DataManager.shared.getAllWords()
        startgame()
    }
    
    @objc func startgame() {
        title = DataManager.shared.allWords.randomElement()
        DataManager.shared.title = title
        myModel?.useWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptForAnswer() {
        let alertVC = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alertVC.addTextField()
        
        let submtionAction = UIAlertAction(title: "Submit", style: .default, handler: {
            [weak self, weak alertVC] _ in
            guard let answer = alertVC?.textFields?[0].text else {return}
            self?.submit(answer)
            
        })
        alertVC.addAction(submtionAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func submit(_ answer: String) {
        myModel?.submit(answer, tableView: tableView, handler: {
            [weak self] (title, message) in
            
            self?.showErrorMessage(title: title, message: message)
        })
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    // MARK: - Config TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myModel?.useWords.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = myModel?.useWords[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
