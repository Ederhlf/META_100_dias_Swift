
import Foundation
import UIKit

class Challengers: NSObject, Codable {
    var name: String
    var fail: Int
    var gain: Int
    
     init(name: String, fail: Int, gain: Int) {
        self.name = name
        self.fail = fail
        self.gain = gain
    }
    
   
    

}
