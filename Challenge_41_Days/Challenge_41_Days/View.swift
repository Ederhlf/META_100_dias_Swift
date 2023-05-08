
import Foundation
import UIKit

protocol ViewDelegate: AnyObject {
    func alertError(_ error: Bool)
}

class View: UIView {
    // MARK: Properties
    let checkLetterButton = UIButton()
    let letterTextField = UITextField()
    let squareView = UIView()
    var labels = [UILabel]()
    var squareAmount = [UIView]()

    weak var delegate: ViewDelegate?
    var errorScore = 0
    var letters: String?
    let words = [
        "o u t o n o",
        "s ó l i d o",
        "a m i z a d e",
        "c a r n a v a l",
        "a m o r",
        "s a l",
    ]
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        
        letters = words.randomElement()
        letterTextField.delegate = self
        configureSquareView()
        configureSquaresView()
        configureTextField()
        configurecCheckButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func textLimit(existingText: String?, newText: String, limit: Int) -> Bool {
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        return isAtLimit
    }
    
    // MARK: Action
    @objc func checkLetterAction() {
        guard  let word = letters?.components(separatedBy: .whitespaces) else {return}
        let lowercaseLetter = letterTextField.text?.lowercased()

        if word.contains(lowercaseLetter!) {
            for letter in 0..<word.count {
                if word[letter] == lowercaseLetter {
                    labels[letter].text = letterTextField.text
                }
            }
            delegate?.alertError(false)
            
        } else {
            errorScore += 1
            delegate?.alertError(true)
        }
        letterTextField.text?.removeAll()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}

// MARK: SquareView
extension View {
    private  func configureSquareView() {
        addSubview(squareView)
        
        configureSquareViewSpecs()
        configureSquareViewConstraints()
    }
    
    private  func configureSquareViewSpecs() {
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.backgroundColor = .clear
    }
    
    private func configureSquareViewConstraints() {
        NSLayoutConstraint.activate([
            squareView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant:  100),
            squareView.centerXAnchor.constraint(equalTo: centerXAnchor),
            squareView.heightAnchor.constraint(equalToConstant: 120),
            squareView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}

// MARK: SeparatorView
extension View {
    private func configureSeparatorView(addSubView: UIView) {
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

// MARK: CharacterLabel
extension View {
    private func configureCharacterLabel(addSubView: UIView, characterString: String) -> UILabel{
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
        
        return characterLabel
    }
}

// MARK: LetterTextField
extension View {
    private func configureTextField() {
        addSubview(letterTextField)
        
        configureTextFieldSpecs()
        configureTextFieldConstraints()
    }
    
    private func configureTextFieldSpecs() {
        letterTextField.translatesAutoresizingMaskIntoConstraints = false
        letterTextField.backgroundColor = .white
        letterTextField.layer.borderColor = UIColor.black.cgColor
        letterTextField.layer.borderWidth = 3
        letterTextField.font = .systemFont(ofSize: 30)
        letterTextField.textAlignment = .center
        letterTextField.text?.lowercased()
    }
    
    private func configureTextFieldConstraints() {
        NSLayoutConstraint.activate([
            letterTextField.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant:  10),
            letterTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            letterTextField.heightAnchor.constraint(equalToConstant: 60),
            letterTextField.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}

// MARK: CheckLetterButton
extension View {
    private  func configurecCheckButtonLayout() {
        addSubview(checkLetterButton)
        
        configureCheckButtonSpecs()
        configureCheckButtonConstraints()
    }
    
    private  func configureCheckButtonSpecs() {
        checkLetterButton.translatesAutoresizingMaskIntoConstraints = false
        checkLetterButton.backgroundColor = .red
        checkLetterButton.setTitle("Check Letter", for: .normal)
        checkLetterButton.addTarget(self, action: #selector(checkLetterAction), for: .touchUpInside)
    }
    
    private func configureCheckButtonConstraints() {
        NSLayoutConstraint.activate([
            checkLetterButton.topAnchor.constraint(equalTo: letterTextField.bottomAnchor, constant:  10),
            checkLetterButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkLetterButton.heightAnchor.constraint(equalToConstant: 60),
            checkLetterButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}

// Squares
extension View {
    func configureSquaresView() {
        let heigth = 59
        let width = 59
        var frame: CGRect?
        var status = 2
        var number = 0
        let lettersAmount = letters?.components(separatedBy: .whitespaces)
        for row in 0...1 {
            for col in 0...4 {
                
                if col == 0 {
                    frame = CGRect(x: 2, y: status, width: width, height: heigth)
                    status = 61
                    
                } else {
                    frame = CGRect(x: col  * width, y: row  * heigth + 2, width: width, height: heigth)
                    
                }
                
        guard number < lettersAmount!.count else { return }
            let squareViewLetters = UIView()
            squareViewLetters.backgroundColor = .white
            squareViewLetters.frame = frame!
            let labelView  = configureCharacterLabel(addSubView: squareViewLetters, characterString: "?")

            self.squareView.addSubview(squareViewLetters)
            configureSeparatorView(addSubView: squareViewLetters)
            labels.append(labelView)
            squareAmount.append(squareViewLetters)
            number += 1

            }
            squareView.setNeedsDisplay()
            squareView.layoutIfNeeded()
        }
    }
}

// Delegate TextField
extension View: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        textLimit(existingText: textField.text, newText: string, limit: 1)
    }
}
