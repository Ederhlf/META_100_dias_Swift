//
//  ViewController.swift
//  Challenge_50_Days
//
//  Created by franklin gaspar on 23/05/23.
//

import UIKit

class LegendListViewController: UIViewController {

    private var myView: LegendListView?
//    private var myModel: ListNameViewModel?
    var data = UserDefaults.standard

    override func loadView() {
        super.loadView()
        myView = LegendListView()
        myView?.delegate = self
        view = myView
        
//        myModel = ListNameViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Project_1"
        
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        myView?.names = myModel?.getImageNameList()
    }
}

extension LegendListViewController: LegendListViewDelegate {
    func selectedView(imageName: String) {
        var views = 1
         views += data.integer(forKey: imageName)
        data.set( views , forKey: imageName)
     
        let vc = PhotoDetailViewController(imageName: imageName, views: views)
        navigationController?.pushViewController(vc, animated: true)
    }

}

