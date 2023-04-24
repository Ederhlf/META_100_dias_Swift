

import UIKit

class NewsListViewController: UITableViewController {
   // MARK: Variables
    var articles = [Article]()
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tertiarySystemGroupedBackground
        title = "News"
        tableView.register(TableViewNewsCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = UIColor.clear
    }
}

// MARK: - Config TableView
extension NewsListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewNewsCell
       
        let dataAPI = articles[indexPath.row]
        cell?.author.text = " Autor:  \(dataAPI.author!)"
        cell?.content.text = dataAPI.content
    
        guard let url = dataAPI.urlToImage else { return UIView() as! UITableViewCell }
        guard let urls = URL(string: url) else { return UITableViewCell() }
        let data = try? Data(contentsOf: urls)
        cell?.imageLink.image = UIImage(data: data ?? Data())

        return cell ?? TableViewNewsCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        return 300
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(text: articles[indexPath.row].content!)
        navigationController?.pushViewController(vc, animated: true)
    }
}
