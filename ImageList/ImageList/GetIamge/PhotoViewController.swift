
import Foundation
import UIKit

class PhotoViewController: UIViewController {
    // MARK: Properties
    var imageName: String?
    var imageView = UIImageView()
   
    // MARK: Init
    convenience init(imageName: String) {
        self.init()
        self.imageName = imageName
    }
    
    // MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = imageName
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        configureSelectedImageLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}

extension PhotoViewController {
    func configureSelectedImageLayout() {
        view.addSubview(imageView)

        imageView.image = UIImage(named: imageName!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
 }
