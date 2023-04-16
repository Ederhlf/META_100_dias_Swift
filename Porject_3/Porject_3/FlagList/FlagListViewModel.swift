//
//  FlagListViewModel.swift
//  Porject_3
//
//  Created by franklin gaspar on 14/04/23.
//

import Foundation
import UIKit

class FlagListViewModel {
    var flags: [String] = []
    
    func getImage() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
       let flagString =  item.hasPrefix("flag")
            if flagString {
                flags.append(item)
            }
        }
        print(flags)
    }
    
    func convertImage() -> [UIImage] {
        var images: [UIImage] = []
        for flag in flags {
            let image = UIImage(named: flag)
            images.append(image!)
        }
        print(images)
        return images
    }
}
