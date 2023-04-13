//
//  ViewController.swift
//  Project_2
//
//  Created by franklin gaspar on 12/04/23.
//

import UIKit

class ViewController: UIViewController {
    var myView: View?
    var myModel: ViewModel?
    var checkNumber: Int?
    
    override func loadView() {
        super.loadView()
        myView = View()
        myView?.delegate = self

        view = myView
        myModel = ViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link
        myView?.flagNames = myModel!.countriesNames
        randomTitle()
    }
    
    func randomTitle() {
        let number = Int.random(in: 0...2)
        title = myView?.flagNames[number]
        checkNumber = number
    }
}

extension ViewController: ViewDelegate {
    func nextChallenge() {
       
    }
    
    func tapOnFlag(tag: Int) {
        var count: Int = (myView?.flagsBtns.count) ?? Int()
        
        for btn in 0..<count {
            if tag == checkNumber && btn == tag {
                let selecteBtn = myView?.flagsBtns[tag]
                myModel?.selectedFlagReaction(btn: selecteBtn!, selected: true)
            } else if tag == 4 {
                let selecteBtn = myView?.flagsBtns[btn]
                myModel?.clearborderColor(btn: selecteBtn!)

                myView?.flagNames.shuffle()
                randomTitle()

            } else {
                let selecteBtn = myView?.flagsBtns[btn]
                myModel?.selectedFlagReaction(btn: selecteBtn!, selected: false)
            }
        }
    }
}
