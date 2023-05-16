//
//  PersonCell.swift
//  Project_10
//
//  Created by franklin gaspar on 08/05/23.
//

import Foundation
import UIKit

class PersonCell: UICollectionViewCell {
    let imageView = UIImageView()
    let nameLabel = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureImageView()
        configureNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PersonCell {
    private  func configureImageView() {
        addSubview(imageView)
        
        configureImageViewSpecs()
        configureImageViewConstraints()
    }
    
    private  func configureImageViewSpecs() {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

extension PersonCell {
    private  func configureNameLabel() {
        addSubview(nameLabel)
        
        configureNameLabelSpecs()
        configureNameLabelConstraints()
    }
    
    private  func configureNameLabelSpecs() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 14)
        nameLabel.sizeToFit()
//        nameLabel.backgroundColor = .clear
    }
    
    private func configureNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
        ])
    }
}
