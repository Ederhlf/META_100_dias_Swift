
import UIKit

class ListNameViewController: UIViewController {

    var myView: ListNameView?
    var myModel: ListNameViewModel?
    
    override func loadView() {
        super.loadView()
        myView = ListNameView()
        myView?.delegate = self
        view = myView
        
        myModel = ListNameViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myView?.names = myModel?.getImageNameList()
    }

}

extension ListNameViewController: ViewDelegate {
    func selectedView(imageName: String) {
        let vc = PhotoViewController(imageName: imageName)
        navigationController?.pushViewController(vc, animated: true)
    }
}
