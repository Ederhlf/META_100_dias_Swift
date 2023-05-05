//
//  DetailViewController.swift
//  Porject_3
//
//  Created by franklin gaspar on 14/04/23.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    // MARK: View
    var imageView = UIImageView()
    
    // MARK: Properties
    var imageName: String?
   
    // MARK: Init
    convenience init(imageName: String) {
        self.init()
        self.imageName = imageName
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = imageName
        navigationController?.navigationItem.largeTitleDisplayMode
        view.backgroundColor = .lightGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareTaped)
        )
        
        configureImageViewLayout()
    }
    
    // Action compartilhamento
    @objc func shareTaped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {return}
        let vc = UIActivityViewController(activityItems: [imageName!, image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
      
        present(vc, animated: true, completion: nil)
    }
}

// MARK: FLag Image
extension DetailViewController {
    func configureImageViewLayout() {
        view.addSubview(imageView)
        
        imageView.image = UIImage(named: imageName!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
        ])
  }
}
