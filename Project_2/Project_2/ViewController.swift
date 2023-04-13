//
//  ViewController.swift
//  Project_2
//
//  Created by franklin gaspar on 12/04/23.
//

import UIKit

class ViewController: UIViewController {
    var myView: View?
    
    override func loadView() {
        super.loadView()
        myView = View()
        view = myView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link
    }


}

