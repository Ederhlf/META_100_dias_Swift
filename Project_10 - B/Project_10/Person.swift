
import Foundation
import UIKit

class Person: NSObject, Codable {
    
    var name: String
    var image: String
    
     init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image =  aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
}
