//
//  ViewModel.swift
//  Project_5
//
//  Created by franklin gaspar on 20/04/23.
//

import Foundation
import UIKit

class ViewModel {
    var useWords = [String]()

    func submit(_ answer: String, tableView: UITableView, handler: @escaping(String, String) -> Void) {
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    useWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                    
                } else {
                   handler("Word not recognised",
                           "You can't just make them up, you know!")
                }
                
            } else {
                handler("Word used already",
                        "Be more original!")
            }
            
        } else {
            guard let title = DataManager.shared.title else { return }
            handler( "Word not possible",
                     "You can't spell that word from \(title)")
        }
    }
    
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = DataManager.shared.title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return  !useWords.contains(word)
        
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )

        if  range.length <= 3 {
            return false
      
        } else {
            return misspelledRange.location == NSNotFound
        }
    }
}
