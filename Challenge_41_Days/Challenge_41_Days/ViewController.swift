
import UIKit

class ViewController: UIViewController {
    // MARK: View
    var myView: View?
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        myView = View()
        view = myView
        myView?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Tentavivas: \(myView!.errorScore)/7",
            style: .plain, target: nil,
            action: nil
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func setUpAlert(title: String, messaga: String ) {
        let alertVc = UIAlertController(
            title: title,
            message: messaga,
            preferredStyle: .alert
        )
        
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: { [weak self] _ in
            self?.navigationItem.rightBarButtonItem?.title =  "Tentavivas: \(self!.myView!.errorScore)/7"
            self?.myView?.letterTextField.text?.removeAll()
        })
        alertVc.addAction(alertAction)
        present(alertVc, animated: true, completion: nil)
    }
}

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
            
        } else if error {
            setUpAlert(
                title: "Nao contem a letra: \(myView?.letterTextField.text ?? String()).",
                messaga: "Voce tem mais \(7 - myView!.errorScore ) tentativas. "
            )
        }
    }    
}
