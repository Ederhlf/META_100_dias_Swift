
import Foundation
import UIKit
class ListNameViewModel {
    
    func getImageNameList() -> [String] {
        var listName: [String] = []
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("Quisviker") {
                listName.append(item)
            }
        }
        let sorted = listName.sorted{$0 < $1}
        return sorted
    }
}
