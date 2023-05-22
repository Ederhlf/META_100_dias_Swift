
import Foundation
import UIKit


class FlagGameViewModel {
    var numberOfAttempts: Int = 0
    var score: Int = 0
    var acertos: Int = 0
    var erros: Int = 0
    let userDafault = UserDefaults.standard
    var challengers = [Challengers]()
    var countriesNames: [String] = [
        "france", "germany", "ireland", "italy",
        "monaco", "russia", "spain", "uk", "us"
    ]
    
    
    
    func refreshist() {
        challengers.removeAll()
        challengers = getChallengersList()
    }
    
    func selectedFlagReaction(btn: UIButton, selected: Bool) {
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 10
        if selected {
            btn.layer.borderColor = UIColor.green.cgColor

        } else {
            btn.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func clearborderColor(btn: UIButton) {
        btn.layer.borderColor = UIColor.clear.cgColor
    }
    
    func alertries(vc: UIViewController, message: String, completion: @escaping() -> Void) {
        let alert = UIAlertController(
            title: "Test",
            message: message,
            preferredStyle: .alert
        )
        
        let actionAlert = UIAlertAction(
            title: "ok",
            style: .cancel,
            handler: {_ in 
                completion()
            }
        )
        
        alert.addAction(actionAlert)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func alertChallengeFinished(vc: UIViewController, completion: @escaping(String) -> Void) {
        let alert = UIAlertController(
            title: "Desafio terminado",
            message: "Tentar novamente? \n Acertos: \(acertos)  Erros: \(erros)",
            preferredStyle: .alert
        )
        
        let actionOk = UIAlertAction(
            title: "ok",
            style: .default,
            handler: {_ in
                self.score = 0
                self.numberOfAttempts = 0
                completion("ok")
            }
        )
        
        let actionSocore = UIAlertAction(
            title: "Ver Pontos",
            style: .default,
            handler: {_ in
                self.score = 0
                self.numberOfAttempts = 0
                completion("Ver Pontos")
            }
        )
        
        let actionCancel = UIAlertAction(
            title: "cancel",
            style: .destructive,
            handler: {_ in
            }
        )
        
        alert.addAction(actionCancel)
        alert.addAction(actionOk)
        alert.addAction(actionSocore)

        vc.present(alert, animated: true, completion: nil)
    }
    
    func checkButtonTag(tag: Int, random: Int, handler: (Bool) -> Void) {
        if tag == random {
            score += 1
            acertos += 1
            handler(true)

        } else {
            score -= 1
            erros += 1
            handler(false)
        }
    }
    
    func sum(sequence number: Int) -> Int {
        numberOfAttempts += number
        return numberOfAttempts
    }
    
    func saveChallengers(user: String) {
        let jSon = JSONEncoder()
        let newUser = Challengers(name: user, fail: erros, gain: acertos)
        challengers.append(newUser)
            do {
                let save = try jSon.encode(challengers) as? Data
                userDafault.set(save, forKey: "challengersList")
            } catch  {
             print("error")
        }
    }
    
    func getChallengersList() -> [Challengers] {
       challengers.removeAll()
       let jSonDecoder = JSONDecoder()
        
        if let saved = userDafault.object(forKey: "challengersList")  as? Data {

            do {
                challengers = (try? jSonDecoder.decode([Challengers].self, from: saved)) ?? []
                return challengers

            } catch  {
                print("error")
                return []
            }
        }
        return []
    }
}

