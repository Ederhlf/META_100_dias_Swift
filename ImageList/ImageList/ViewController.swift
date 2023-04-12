//
//  ViewController.swift
//  ImageList
//
//  Created by franklin gaspar on 12/04/23.
//

import UIKit

class ViewController: UIViewController {

    var myView: View?
    var myModel: ViewModel?
    
    override func loadView() {
        super.loadView()
        myView = View()
        view = myView
        
        myModel = ViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myView?.imageList = myModel?.imageList()
    }

}

