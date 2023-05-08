
import UIKit

class ViewController: UIViewController {
    // MARK: View
    var myView: View?
    var myModel: ViewModel?
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        myView = View()
        view = myView
        myView?.delegate = self
        
        myModel = ViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Tentavivas: \(myView!.errorScore)/7",
            style: .plain, target: nil,
            action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(randomCharacters))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    // ACtion
    func setUpAlert(title: String, messaga: String ) {
        let alertVc = UIAlertController(
            title: title,
            message: messaga,
            preferredStyle: .alert
        )
        
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: { [weak self] _ in
            self?.navigationItem.rightBarButtonItem?.title =  "Tentavivas: \(self!.myView!.errorScore)/7"
            self?.myView?.letterTextField.text?.removeAll()
            
            if (self?.myModel?.containCharactersFull(labels: self?.myView!.labels ?? []))! {
                self?.randomCharacters()
            }
        })
        
        alertVc.addAction(alertAction)
        present(alertVc, animated: true, completion: nil)
    }
    
    @objc func randomCharacters() {
        for squareView in myView!.squareAmount as [UIView] {
            squareView.removeFromSuperview()
        }
        
        myView?.squareAmount.removeAll()
        myView?.labels.removeAll()
        myView?.letters = myView?.words.randomElement()
        myView?.configureSquaresView()
    }
}

// MARK: Delgate Instanced
extension ViewController: ViewDelegate {
    func alertError(_ error: Bool) {
        if error && myView?.errorScore == 7 {
           setUpAlert(title: "Game Over", messaga: "Tente novamente.")
            myView?.words.randomElement()
            myView?.errorScore = 0
            
        } else if myView?.letterTextField.text?.isEmpty == true {
            setUpAlert(
                title: "Campo nao preenchido.",
                messaga: "Lance seu palpite e descubra qual é a palavra."
            )
            myView?.errorScore -= 1
            
        } else if (myModel?.containCharactersFull(labels: myView!.labels))! {
            setUpAlert(
                title: "Parabens!!.",
                messaga: "Voce coseguiu concluir o desafio."
            )
                        
        }  else if error {
            setUpAlert(
                title: "Nao contem a letra: \(myView?.letterTextField.text ?? String()).",
                messaga: "Voce tem mais \(7 - myView!.errorScore ) tentativas. "
            )
        }
    }    
}
