
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
    
    func encode(with coder: NSCoder) throws {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.fail, forKey: "fail")
        coder.encode(self.gain, forKey: "gain")
    }
    
    required init(coder aDecoder: NSCoder) throws {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        fail = aDecoder.decodeObject(forKey: "fail") as? Int ?? 0
        gain = aDecoder.decodeObject(forKey: "gain") as? Int ?? 0

    }
    

}
