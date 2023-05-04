//
//  View.swift
//  Challenge_41_Days
//
//  Created by franklin gaspar on 03/05/23.
//

import Foundation
import UIKit

class View: UIView {
    
    let squareView = UIView()
    let words = [
        "o u t o n o",
        "s ó l i d o",
        "a m i z a d e",
        "c a r n a v a l",
        "a m o r",
        "s a l",
    ]
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        
        configureSquareView()
        configureSeparatorView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension View {
    func configureSquareView() {
        addSubview(squareView)
        
        configureSquareViewSpecs()
        configureSquareViewConstraints()
    }
    
    func configureSquareViewSpecs() {
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.backgroundColor = .red
    }
    
    func configureSquareViewConstraints() {
        NSLayoutConstraint.activate([
            squareView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant:  100),
            squareView.centerXAnchor.constraint(equalTo: centerXAnchor),
            squareView.heightAnchor.constraint(equalToConstant: 120),
            squareView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension View {
    func configureSView(addSubView: UIView) {
        let separatorView = UIView()

        addSubView.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .systemGray3
    
        NSLayoutConstraint.activate([
            separatorView.bottomAnchor.constraint(equalTo: addSubView.bottomAnchor),
            separatorView.leftAnchor.constraint(equalTo: addSubView.leftAnchor, constant: 3),
            separatorView.rightAnchor.constraint(equalTo: addSubView.rightAnchor, constant: -3),
            separatorView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}

extension View {
    func configureCharacterLabel(addSubView: UIView, characterString: String) {
        let characterLabel = UILabel()

        addSubView.addSubview(characterLabel)
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        characterLabel.font = .systemFont(ofSize: 20)
        characterLabel.sizeToFit()
        characterLabel.text = characterString
        NSLayoutConstraint.activate([
            characterLabel.centerXAnchor.constraint(equalTo: addSubView.centerXAnchor),
            characterLabel.centerYAnchor.constraint(equalTo: addSubView.centerYAnchor),
        ])
    }
}

extension View {
    func configureSeparatorView() {
       
        let heigth = 59
        let width = 59
        var frame: CGRect?
        var status = 2
        var letter: String = words.randomElement()!
        var number = 0
        var arrayString = letter.components(separatedBy: .whitespaces)
        
        for row in 0...1 {
            for col in 0...4 {
                
                if col == 0 {
                    frame = CGRect(x: 2, y: status, width: width, height: heigth)
                    status = 61
                    
                } else {
                    frame = CGRect(x: col  * width, y: row  * heigth + 2, width: width, height: heigth)
                    
                }
                
                guard number < arrayString.count else { return }
                let squareV = UIView()
                squareV.backgroundColor = .white
                squareV.frame = frame!
                
                squareView.addSubview(squareV)
                configureSView(addSubView: squareV)
                configureCharacterLabel(addSubView: squareV, characterString: "?")
                number += 1
                
            }
        }
    }
}
