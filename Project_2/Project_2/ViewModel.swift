//
//  ViewModel.swift
//  Project_2
//
//  Created by franklin gaspar on 13/04/23.
//

import Foundation
import UIKit


class ViewModel {
    var amountTap: Int = 0
    var points = Int()
    var countriesNames: [String] = [
        "france", "germany", "ireland", "italy",
        "monaco", "russia", "spain", "uk", "us"
    ]
    
    func selectedFlagReaction(btn: UIButton, selected: Bool) {
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 10
        if selected {
            btn.layer.borderColor = UIColor.green.cgColor

        } else {
            btn.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func clearborderColor(btn: UIButton) {
        btn.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    func alertViewController(vc: UIViewController, completion: @escaping() -> Void) {
        let alert = UIAlertController(
            title: "Test",
            message: "Gain: \(points)",
            preferredStyle: .alert
        )
        
        let actionAlert = UIAlertAction(
            title: "ok",
            style: .cancel,
            handler: {_ in 
                completion()
            }
        )
        
        alert.addAction(actionAlert)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func checkButtonTag(tag: Int, random: Int, handler: () -> Void) {
        if tag == random {
            points += 1
        } else {
            points -= 1
        }
        handler()
    }
    
    func amountTap(item: Int) -> Int {
        amountTap += item
        return amountTap
    }
}
