//
//  DataManager.swift
//  Project_5
//
//  Created by franklin gaspar on 20/04/23.
//

import Foundation

class DataManager {
   static var shared = DataManager()
   var title: String?
   var allWords = [String]()
    
    func getAllWords() {
        if  let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        checkIsEmpty()
    }
    
    func checkIsEmpty() {
        
        if allWords.isEmpty {
            allWords = ["silkworn"]
        }
    }
}
