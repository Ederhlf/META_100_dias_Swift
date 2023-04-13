//
//  ViewModel.swift
//  Project_2
//
//  Created by franklin gaspar on 13/04/23.
//

import Foundation
import UIKit


class ViewModel {
    
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
    
}
