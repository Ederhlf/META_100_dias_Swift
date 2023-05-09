
import UIKit

class ViewController: UIViewController {
    var myView: View?
    
    override func loadView() {
        super.loadView()
        myView = View()
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
}

