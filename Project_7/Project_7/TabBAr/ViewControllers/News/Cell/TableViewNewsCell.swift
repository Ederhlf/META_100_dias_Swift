//
//  NewsCell.swift
//  Project_7
//
//  Created by franklin gaspar on 21/04/23.
//

import Foundation
import UIKit

class TableViewNewsCell: UITableViewCell {
    var author = UILabel()
    var imageLink = UIImageView()
    var content = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        addSubview(author)
        author.text = "Author"
        author.textColor = .orange
        author.font = .boldSystemFont(ofSize: 16)
        author.translatesAutoresizingMaskIntoConstraints = false
        author.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        author.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        author.topAnchor.constraint(equalTo: topAnchor).isActive = true
        author.bottomAnchor.constraint(equalTo: author.topAnchor, constant: 20).isActive = true

        contentView.addSubview(imageLink)
        imageLink.image = UIImage(named: "testImage")
        imageLink.contentMode = .scaleAspectFit
        imageLink.clipsToBounds = true
        imageLink.layer.masksToBounds = true
        imageLink.translatesAutoresizingMaskIntoConstraints = false
        
        imageLink.contentMode = .scaleToFill
      //  imageLink.clipsToBounds = true
        imageLink.translatesAutoresizingMaskIntoConstraints = false
        imageLink.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        imageLink.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        imageLink.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        imageLink.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        
//        addSubview(content)
//        content.text = "Content"
//        content.numberOfLines = 0
//        content.font = .boldSystemFont(ofSize: 10)
//        content.lineBreakMode = .byWordWrapping
//        content.translatesAutoresizingMaskIntoConstraints = false
//        content.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
//        content.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
//        content.topAnchor.constraint(equalTo: content.bottomAnchor, constant: -30).isActive = true
//        content.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

