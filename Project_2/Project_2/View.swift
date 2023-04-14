
import Foundation
import UIKit

protocol ViewDelegate: AnyObject {
  func tapOnFlag(btnTag: Int)
  func nextChallenge()
}

class View: UIView {
    // MARK: Views
    var firstFlagBtn = UIButton().specsDefault()
    var secondFlagBtn = UIButton().specsDefault()
    var thirdFlagBtn = UIButton().specsDefault()
    var nextBtn = UIButton()
    
    // MARK: Properties
    var delegate: ViewDelegate?
    var flagsBtns: [UIButton] = [UIButton]()
    
    var flagNames: [String] = [] {
        didSet {
            configureFirstFlagBtnLayout()
            configureSecondFlagBtnLayout()
            configureThirdFlagBtnLayout()
        }
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureNextBtnLayout()
        flagsBtns += [firstFlagBtn, secondFlagBtn, thirdFlagBtn]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nextBtn.layer.cornerRadius = 0.5 * (nextBtn.frame.size.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapOnFlag(_ sender: UIButton) {
        delegate?.tapOnFlag(btnTag: sender.tag)
    }
    
    @objc func nextChallenge() {
        delegate?.nextChallenge()
    }
    
    func isEnableBtn(isEnable: Bool) {
        firstFlagBtn.isEnabled = isEnable
        secondFlagBtn.isEnabled = isEnable
        thirdFlagBtn.isEnabled = isEnable
    }
    
    
}

// MARK: - First BTN
extension View {
    func configureFirstFlagBtnLayout() {
        addSubview(firstFlagBtn)
        
        configureFirstFlagBtnSpecs()
        configureFirstFlagBtnConstraints()
    }
    
    func configureFirstFlagBtnSpecs() {
        firstFlagBtn.tag = 0
        firstFlagBtn.setImage(UIImage(named: flagNames[0]), for: .normal)
        firstFlagBtn.translatesAutoresizingMaskIntoConstraints = false
        firstFlagBtn.addTarget(self, action: #selector(tapOnFlag), for: .touchUpInside)
    }
    
    func configureFirstFlagBtnConstraints() {
        NSLayoutConstraint.activate([
            firstFlagBtn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            firstFlagBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 100),
            firstFlagBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -100)
        ])
    }
}

// MARK: - Second BTN
extension View {
    func configureSecondFlagBtnLayout() {
        addSubview(secondFlagBtn)
        
        configureSecondFlagBtnSpecs()
        configureSecondFlagBtnConstraints()
    }
    
    func configureSecondFlagBtnSpecs() {
        secondFlagBtn.tag = 1
        secondFlagBtn.setImage(UIImage(named: flagNames[1]), for: .normal)
        secondFlagBtn.translatesAutoresizingMaskIntoConstraints = false
        secondFlagBtn.addTarget(self, action: #selector(tapOnFlag), for: .touchUpInside)
    }
    
    func configureSecondFlagBtnConstraints() {
        NSLayoutConstraint.activate([
            secondFlagBtn.topAnchor.constraint(equalTo: firstFlagBtn.bottomAnchor, constant: 20),
            secondFlagBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 100),
            secondFlagBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -100)
        ])
    }
}

// MARK: - Third BTN
extension View {
    func configureThirdFlagBtnLayout() {
        addSubview(thirdFlagBtn)

        configureThirdFlagBtnSpecs()
        configureThirdFlagBtnConstraints()
    }

    func configureThirdFlagBtnSpecs() {
        thirdFlagBtn.tag = 2
        thirdFlagBtn.setImage(UIImage(named: flagNames[2]), for: .normal)
        thirdFlagBtn.translatesAutoresizingMaskIntoConstraints = false
        thirdFlagBtn.addTarget(self, action: #selector(tapOnFlag), for: .touchUpInside)
        
    }

    func configureThirdFlagBtnConstraints() {
        NSLayoutConstraint.activate([
            thirdFlagBtn.topAnchor.constraint(equalTo: secondFlagBtn.bottomAnchor, constant: 20),
            thirdFlagBtn.leftAnchor.constraint(equalTo: leftAnchor, constant: 100),
            thirdFlagBtn.rightAnchor.constraint(equalTo: rightAnchor, constant: -100)
        ])
    }
}

// MARK: - Next BTN
extension View {
    func configureNextBtnLayout() {
        addSubview(nextBtn)

        configureNextBtnSpecs()
        configureNextBtnConstraints()
    }

    func configureNextBtnSpecs() {
        nextBtn.tag = 3
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.setTitle("Próximo", for: .normal)
        nextBtn.backgroundColor = .black
        nextBtn.center = self.center
        nextBtn.contentMode = .scaleAspectFit

        nextBtn.addTarget(self, action: #selector(nextChallenge), for: .touchUpInside)
    }

    func configureNextBtnConstraints() {
        NSLayoutConstraint.activate([
            nextBtn.topAnchor.constraint(equalTo: nextBtn.bottomAnchor, constant: -140),
            nextBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            nextBtn.leftAnchor.constraint(equalTo: centerXAnchor, constant: -70),
            nextBtn.rightAnchor.constraint(equalTo: centerXAnchor, constant: 70)
        ])
    }
}
