//
//  ViewController.swift
//  Challenge_41_Days
//
//  Created by franklin gaspar on 03/05/23.
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

    }
}

