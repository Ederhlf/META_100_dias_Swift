
import Foundation
import UIKit

protocol ViewDelegate: AnyObject {
    func tapOnFlag(btnTag: Int)
    func nextChallenge()
}

class FlagGameView: UIView {
    // MARK: Views
    var firstFlagBtn = UIButton().specsDefault()
    var secondFlagBtn = UIButton().specsDefault()
    var thirdFlagBtn = UIButton().specsDefault()
    var nextBtn = UIButton()
        
    // MARK: Properties
    var delegate: ViewDelegate?
    var flagsBtns: [UIButton] = [UIButton]()
    
    var heightFirstFlag = NSLayoutConstraint()
    var widthFirstFlag = NSLayoutConstraint()
    
    var heightSecondFlag = NSLayoutConstraint()
    var widthSecondFlag = NSLayoutConstraint()
    
    var heightThirdFlag = NSLayoutConstraint()
    var widthThirdFlag = NSLayoutConstraint()
    
    var heightNextBtn = NSLayoutConstraint()
    var widthNextBtn = NSLayoutConstraint()
    
    var flagNames: [String] = [] {
        didSet {
            configureFirstFlagBtnLayout()
            configureSecondFlagBtnLayout()
            configureThirdFlagBtnLayout()
            configureNextBtnLayout()
        }
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        flagsBtns += [firstFlagBtn, secondFlagBtn, thirdFlagBtn]
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshConstraints), name: UIDevice.orientationDidChangeNotification, object: nil)
        refreshConstraints()
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
    
    @objc func refreshConstraints() {
        NSLayoutConstraint.deactivate(
            [
               widthFirstFlag,
               heightFirstFlag,
               heightSecondFlag,
               widthSecondFlag,
               heightThirdFlag,
               widthThirdFlag,
                heightNextBtn,
                widthNextBtn
            ]
        )
        
        if frame.width > frame.height {
            widthFirstFlag = firstFlagBtn.widthAnchor.constraint(equalToConstant: 100)
            heightFirstFlag = firstFlagBtn.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 1/5)
            widthSecondFlag = secondFlagBtn.widthAnchor.constraint(equalToConstant: 100)
            heightSecondFlag = secondFlagBtn.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 1/5)
            widthThirdFlag = thirdFlagBtn.widthAnchor.constraint(equalToConstant: 100)
            heightThirdFlag = thirdFlagBtn.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 1/5)
            heightNextBtn = nextBtn.widthAnchor.constraint(equalToConstant: 50)
            widthNextBtn = nextBtn.heightAnchor.constraint(equalToConstant: 50)
            
        }
        else {
            widthFirstFlag = firstFlagBtn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1/2)
            heightFirstFlag = firstFlagBtn.heightAnchor.constraint(equalToConstant: 100)
            widthSecondFlag = secondFlagBtn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1/2)
            heightSecondFlag = secondFlagBtn.heightAnchor.constraint(equalToConstant: 100)
            widthThirdFlag = thirdFlagBtn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1/2)
            heightThirdFlag = thirdFlagBtn.heightAnchor.constraint(equalToConstant: 100)
            heightNextBtn = nextBtn.widthAnchor.constraint(equalToConstant: 100)
            widthNextBtn = nextBtn.heightAnchor.constraint(equalToConstant: 100)
        }
        
        NSLayoutConstraint.activate(
            [
                widthFirstFlag,
                heightFirstFlag,
                heightSecondFlag,
                widthSecondFlag,
                heightThirdFlag,
                widthThirdFlag,
                heightNextBtn,
                widthNextBtn
            ]
        )
    }
}

// MARK: - First BTN
extension FlagGameView {
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
        firstFlagBtn.contentMode = .scaleAspectFit
        firstFlagBtn.layer.masksToBounds = true
        firstFlagBtn.clipsToBounds = true
    }
    
    func configureFirstFlagBtnConstraints() {
        firstFlagBtn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        firstFlagBtn.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        widthFirstFlag.isActive = true
        heightFirstFlag.isActive = true
    }
}

// MARK: - Second BTN
extension FlagGameView {
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
        secondFlagBtn.contentMode = .scaleAspectFit
        secondFlagBtn.layer.masksToBounds = true
        secondFlagBtn.clipsToBounds = true
    }
    
    func configureSecondFlagBtnConstraints() {
        secondFlagBtn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        secondFlagBtn.topAnchor.constraint(greaterThanOrEqualTo: firstFlagBtn.bottomAnchor, constant: 10).isActive = true
        widthSecondFlag.isActive = true
        heightSecondFlag.isActive = true
    }
}

// MARK: - Third BTN
extension FlagGameView {
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
        thirdFlagBtn.contentMode = .scaleAspectFit
        thirdFlagBtn.layer.masksToBounds = true
        thirdFlagBtn.clipsToBounds = true
    }
    
    func configureThirdFlagBtnConstraints() {
        thirdFlagBtn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        thirdFlagBtn.topAnchor.constraint(greaterThanOrEqualTo: secondFlagBtn.bottomAnchor, constant: 10).isActive = true
        widthThirdFlag.isActive = true
        heightThirdFlag.isActive = true
    }
}

// MARK: - Next BTN
extension FlagGameView {
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
        nextBtn.layer.masksToBounds = true
        nextBtn.clipsToBounds = true
        
        nextBtn.addTarget(self, action: #selector(nextChallenge), for: .touchUpInside)
    }
    
    func configureNextBtnConstraints() {

        nextBtn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nextBtn.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        heightNextBtn.isActive = true
        widthNextBtn.isActive = true
    }
}
