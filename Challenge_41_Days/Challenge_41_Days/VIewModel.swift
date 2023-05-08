//
//  VIewModel.swift
//  Challenge_41_Days
//
//  Created by franklin gaspar on 07/05/23.
//

import Foundation
import  UIKit

class ViewModel {
    
    func containCharactersFull(labels: [UILabel]) -> Bool {
        for label in labels {
            if (label.text?.contains("?"))! && label.text != nil {
                return false
            }
        }
        return true
    }
}
