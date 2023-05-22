
import Foundation
import UIKit

class ScoreListCell: UITableViewCell {
    let name = UILabel()
    let fail = UILabel()
    let gain = UILabel()
    let palce = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureNameLabel()
        configureGainLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Name
extension ScoreListCell {
    private  func configureNameLabel() {
        addSubview(name)
        
        configureNameLabelSpecs()
        configureNameLabelConstraints()
        configureFailLabel()
    }
    
    private  func configureNameLabelSpecs() {
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 17)
        name.sizeToFit()
    }
    
    private func configureNameLabelConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            name.centerXAnchor.constraint(equalTo:centerXAnchor),
        ])
    }
}

// MARK: - Gain
extension ScoreListCell {
    private  func configureGainLabel() {
        addSubview(gain)
        
        configureGainLabelSpecs()
        configureGainLabelConstraints()
    }
    
    private  func configureGainLabelSpecs() {
        gain.translatesAutoresizingMaskIntoConstraints = false
        gain.font = .systemFont(ofSize: 12)
        gain.sizeToFit()
    }
    
    private func configureGainLabelConstraints() {
        NSLayoutConstraint.activate([
            gain.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            gain.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant:  30 ),
            gain.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -30 ),
        ])
    }
}

// MARK: - Fial
extension ScoreListCell {
    private  func configureFailLabel() {
        addSubview(fail)
        
        configureFailLabelSpecs()
        configureFailLabelConstraints()
    }
    
    private  func configureFailLabelSpecs() {
        fail.translatesAutoresizingMaskIntoConstraints = false
        fail.font = .systemFont(ofSize: 12)
        fail.sizeToFit()
    }
    
    private func configureFailLabelConstraints() {
        NSLayoutConstraint.activate([
            fail.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            fail.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant:  -30 ),
            fail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -30 ),

        ])
    }
}


