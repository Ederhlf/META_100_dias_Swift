//
//  ViewController.swift
//  Porject_3
//
//  Created by franklin gaspar on 14/04/23.
//

import UIKit

class FlagListViewController: UITableViewController {
    // MARK: Properties
    var myModel: FlagListViewModel?
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        myModel = FlagListViewModel()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Selecte Flag"
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(FlagListCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = UIColor.clear

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myModel?.getImage()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = myModel?.flags.count else { return 0}
        return count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FlagListCell
        cell.backgroundColor = .clear
        guard let items = myModel?.flags else {return UIView() as! UITableViewCell}
        let count = items.count
    
        for it in 0...count {
            if indexPath.section == it {
               
                let id =   items[it]
                cell.flagImage.image = UIImage(named: id)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = (myModel?.flags[indexPath.section])! as String
    
        let vc = DetailViewController(imageName: image)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 20
        }
    
   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 1
        let headerView = UIView()
        // 2
        headerView.backgroundColor = view.backgroundColor
        // 3
        return headerView
    }
    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        guard let items = myModel?.flags else {return UIView() as! UITableViewCell}
////        let lastItem = items.endIndex
////        if section ==  lastItem {
//            let headerView = UIView()
//            // 2
//            headerView.backgroundColor = view.backgroundColor
//            // 3
//            return headerView
////        }
//
////        return nil
//    }
}
