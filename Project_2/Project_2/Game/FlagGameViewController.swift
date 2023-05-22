
import UIKit

class FlagGameViewController: UIViewController {
   private var myView: FlagGameView?
   private var myModel: FlagGameViewModel?
   private var currentTag: Int?
   private var user: String?
    
    
    override func loadView() {
        super.loadView()
        myView = FlagGameView()
        myView?.delegate = self
        
        view = myView
        myModel = FlagGameViewModel()
    }
    
    convenience init(userName: String) {
        self.init()
        self.user = userName
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        myModel?.refreshist()
        
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

// MARK: DELEGATE
extension FlagGameViewController: ViewDelegate {
    func nextChallenge() {
        if myModel?.numberOfAttempts == 10 {
            myModel?.alertChallengeFinished(vc: self) { title in
                self.navigationItem.leftBarButtonItem?.title = "\(self.myModel!.score)/10"
                self.navigationItem.rightBarButtonItem?.title = "Score: \(self.myModel!.score)"
                    self.myModel?.saveChallengers(user: self.user!)

                if title == "Ver Pontos" {
                    let vc = UINavigationController(rootViewController: ScoreListViewController()) 
                    vc.modalPresentationStyle = .popover
                    self.present(vc, animated: true, completion: nil)
                }
                self.myModel?.erros = 0
                self.myModel?.acertos = 0
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
                let notSelecteBtn = myView?.flagsBtns[number]
                
                myModel?.selectedFlagReaction(btn: notSelecteBtn!, selected: false)
            }
        }
        
        myModel?.checkButtonTag(tag: btnTag, random: currentTag!) { bool in
            if bool {
                myModel?.alertries(vc: self, message: "Parabéns \(user!), voce acertou: +1") {
                self.navigationItem.leftBarButtonItem?.title = "\(self.myModel?.sum(sequence: +1) ?? Int())/10"
                self.navigationItem.rightBarButtonItem?.title = "Score: \(self.myModel!.score)"
                }
           
            } else  {
                myModel?.alertries(vc: self, message: "Bandeira errada, \(user): -1") {
                self.navigationItem.leftBarButtonItem?.title = "\(self.myModel?.sum(sequence: +1) ?? Int())/10"
                self.navigationItem.rightBarButtonItem?.title = "Score: \(self.myModel!.score)"
                }
            }
        }
    }
}

