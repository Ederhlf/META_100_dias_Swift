//
//  FlagListCell.swift
//  Porject_3
//
//  Created by franklin gaspar on 14/04/23.
//

import Foundation
import UIKit

class FlagListCell: UITableViewCell {
    // MARK: Views
    var flagImage = UIImageView()
    let label = UILabel()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.systemGray
        configureImageLayout()
        configureLabelLayout()
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()

          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flagsCell(images: [UIImage]) -> [UIImageView] {
        var imagesView: [UIImageView] = []
        
        for image in images {
            flagImage.image = image
            imagesView.append(flagImage)
        }
        return imagesView
    }
}

// MARK: - Flag Image
extension FlagListCell {
    func configureImageLayout() {
        addSubview(flagImage)
        flagImage.contentMode = .right
        flagImage.contentMode = .scaleAspectFill
        flagImage.layer.masksToBounds = true
        flagImage.clipsToBounds = true
       
        
        let margins = UIEdgeInsets(top: 5, left: 170, bottom: -10, right: -90)
        flagImage.frame = contentView.frame.inset(by: margins)
        flagImage.layer.cornerRadius = 10
    }
}

// MARK: - Label text
extension FlagListCell {
    func configureLabelLayout() {
        contentView.addSubview(label)
        label.text = "Click \n para mais detalhes."
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .monospacedDigitSystemFont(ofSize: 14, weight: .black)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            label.rightAnchor.constraint(equalTo: label.leftAnchor, constant: 150),
        ])
    }
}
