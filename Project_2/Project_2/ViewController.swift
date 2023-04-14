
import UIKit

class ViewController: UIViewController {
    var myView: View?
    var myModel: ViewModel?
    var currentTag: Int?
    
    override func loadView() {
        super.loadView()
        myView = View()
        myView?.delegate = self
        
        view = myView
        myModel = ViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "0/10", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: 0", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .black
        myView?.flagNames = myModel!.countriesNames
        randomTitle()
    }
    
    func randomTitle() {
        let number = Int.random(in: 0...2)
        title = myView?.flagNames[number].uppercased()
        currentTag = number
    }
}

extension ViewController: ViewDelegate {
    func nextChallenge() {
        if myModel?.numberOfAttempts == 10 {
            myModel?.alertChallengeFinished(vc: self) {
                self.navigationItem.leftBarButtonItem?.title = "\(self.myModel!.score)/10"
                self.navigationItem.rightBarButtonItem?.title = "Score: \(self.myModel!.score)"
            }
        } else {
            myModel?.clearborderColor(btn: myView!.firstFlagBtn)
            myModel?.clearborderColor(btn: myView!.secondFlagBtn)
            myModel?.clearborderColor(btn: myView!.thirdFlagBtn)
            myView?.isEnableBtn(isEnable: true)
            
            myView?.flagNames.shuffle()
            randomTitle()
        }
    }
    
    func tapOnFlag(btnTag: Int) {
        let total: Int = (myView?.flagsBtns.count)!
        myView?.isEnableBtn(isEnable: false)
        
        for number in 0..<total {
            if  btnTag == number && btnTag == currentTag || number == currentTag {
                let selecteBtn = myView?.flagsBtns[number]
                
                myModel?.selectedFlagReaction(btn: selecteBtn!, selected: true)
                
            } else if btnTag != currentTag {
                let selecteBtn = myView?.flagsBtns[number]
                
                myModel?.selectedFlagReaction(btn: selecteBtn!, selected: false)
            }
        }
        
        myModel?.checkButtonTag(tag: btnTag, random: currentTag!) { bool in
            if bool {
                myModel?.alertries(vc: self, message: "Parabéns, voce acertou: +1") {
                self.navigationItem.leftBarButtonItem?.title = "\(self.myModel?.sum(sequence: +1) ?? Int())/10"
                self.navigationItem.rightBarButtonItem?.title = "Score: \(self.myModel!.score)"
                }
           
            } else  {
                myModel?.alertries(vc: self, message: "Bandeira errada: -1") {
                self.navigationItem.leftBarButtonItem?.title = "\(self.myModel?.sum(sequence: +1) ?? Int())/10"
                self.navigationItem.rightBarButtonItem?.title = "Score: \(self.myModel!.score)"
                }
            }
        }
    }
}

