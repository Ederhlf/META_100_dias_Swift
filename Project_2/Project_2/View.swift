//
//  View.swift
//  Project_2
//
//  Created by franklin gaspar on 13/04/23.
//

import Foundation
import UIKit

class View: UIView {
    let germanyFlagBtn = UIButton()
    let franceFlagBtn = UIButton()
    let russiaFlagBtn = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGermanyFlagBtnLayout()
        configureFranceFlagBtnLayout()
        configureRussiaFlagBtnLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getImage(name: String) -> UIImage {
        return UIImage(named: name)!
    }
}

extension View {
    func configureGermanyFlagBtnLayout() {
        addSubview(germanyFlagBtn)
        
        configureGermanyFlagBtnSpecs()
        configureGermanyFlagBtnConstraints()
    }
    
    func configureGermanyFlagBtnSpecs() {
        germanyFlagBtn.translatesAutoresizingMaskIntoConstraints = false
        germanyFlagBtn.setImage(getImage(name: "germany"), for: .normal)
        germanyFlagBtn.contentMode = .scaleAspectFill
        germanyFlagBtn.contentHorizontalAlignment = .fill
        germanyFlagBtn.contentVerticalAlignment = .fill
        germanyFlagBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 20)

    }
    
    func configureGermanyFlagBtnConstraints() {
        NSLayoutConstraint.activate([
            germanyFlagBtn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            germanyFlagBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 100),
            germanyFlagBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -100)
        ])
    }
}

// MARK France BTN
extension View {
    func configureFranceFlagBtnLayout() {
        addSubview(franceFlagBtn)
        
        configureFranceFlagBtnSpecs()
        configureFranceFlagBtnConstraints()
    }
    
    func configureFranceFlagBtnSpecs() {
        franceFlagBtn.translatesAutoresizingMaskIntoConstraints = false
        franceFlagBtn.setImage(getImage(name: "france"), for: .normal)
        franceFlagBtn.layer.cornerRadius = 10
        franceFlagBtn.layer.borderWidth = 10
        franceFlagBtn.layer.borderColor = UIColor.white.cgColor
        franceFlagBtn.contentMode = .scaleAspectFill
        franceFlagBtn.contentHorizontalAlignment = .fill
        franceFlagBtn.contentVerticalAlignment = .fill
        franceFlagBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)

    }
    
    func configureFranceFlagBtnConstraints() {
        NSLayoutConstraint.activate([
            franceFlagBtn.topAnchor.constraint(equalTo: germanyFlagBtn.bottomAnchor, constant: 20),
            franceFlagBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 100),
            franceFlagBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -100)
        ])
    }
}

extension View {
    func configureRussiaFlagBtnLayout() {
        addSubview(russiaFlagBtn)

        configureRussiaFlagBtnSpecs()
        configureRussiaFlagBtnConstraints()
    }

    func configureRussiaFlagBtnSpecs() {
        russiaFlagBtn.translatesAutoresizingMaskIntoConstraints = false
        russiaFlagBtn.setImage(getImage(name: "russia"), for: .normal)
        russiaFlagBtn.contentMode = .scaleAspectFill
        russiaFlagBtn.contentHorizontalAlignment = .fill
        russiaFlagBtn.contentVerticalAlignment = .fill
        russiaFlagBtn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 20)

    }

    func configureRussiaFlagBtnConstraints() {
        NSLayoutConstraint.activate([
            russiaFlagBtn.topAnchor.constraint(equalTo: franceFlagBtn.bottomAnchor, constant: 20),
            russiaFlagBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 100),
            russiaFlagBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -100)
        ])
    }
}
