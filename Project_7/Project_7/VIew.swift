//
//  VIew.swift
//  Project_7
//
//  Created by franklin gaspar on 24/04/23.
//

import Foundation
import UIKit

class ViewNews: UIView {
    var articles = [Article]()
    var tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.register(TableViewNewsCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = UIColor.clear
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor)
        
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Config TableView
extension ViewNews: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailViewController(text: articles[indexPath.row].content!)
//        navigationController?.pushViewController(vc, animated: true)
    }
}
