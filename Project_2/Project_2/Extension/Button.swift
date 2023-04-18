//
//  Button.swift
//  Project_2
//
//  Created by franklin gaspar on 13/04/23.
//

import Foundation
import UIKit

extension UIButton {
    
    func specsDefault() -> UIButton {
        contentMode = .scaleAspectFill
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        return self
    }
    
    
}
