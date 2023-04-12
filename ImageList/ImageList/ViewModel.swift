//
//  ViewModel.swift
//  ImageList
//
//  Created by franklin gaspar on 12/04/23.
//

import Foundation

class ViewModel {
    
    
    func imageList() -> [String] {
        var list1: [String] = []
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("Quisviker") {
                list1.append(item)
            }
        }
        return list1
    }
}
