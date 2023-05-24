
import Foundation
import UIKit

class PhotoDetailViewController: UIViewController {
    // MARK: Properties
    var imageName: String?
    var imageView = UIImageView()
    var views: Int?
    
    // MARK: Init
    convenience init(imageName: String, views: Int) {
        self.init()
        self.imageName = imageName
        self.views = views
    }
    
    // MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Visualizado: \(views ?? Int())"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareTaped)
        )
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
    
    @objc func shareTaped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {return}
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
    }
}

extension PhotoDetailViewController {
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
