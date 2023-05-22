
import UIKit
import Foundation

class ListNameViewController: UIViewController {

    private var myView: ListNameView?
    private var myModel: ListNameViewModel?
    var data = UserDefaults.standard

    override func loadView() {
        super.loadView()
        myView = ListNameView()
        myView?.delegate = self
        view = myView
        
        myModel = ListNameViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Project_1"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myView?.names = myModel?.getImageNameList()
    }    
}

extension ListNameViewController: ViewDelegate {
    func selectedView(imageName: String) {
        DataUser.shared
        var views = 1
         views += data.integer(forKey: imageName)
        data.set( views , forKey: imageName)
     
        let vc = PhotoViewController(imageName: imageName, views: views)
        navigationController?.pushViewController(vc, animated: true)
    }
}
