

import Foundation
import UIKit

class LoginVIewController: UIViewController {
    
    private var userNameTextField = UITextField()
    private var startBtn = UIButton()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(userNameTextField)
        view.addSubview(startBtn)
        
        userNameTextField.placeholder = " User Name"
        userNameTextField.backgroundColor = .white
        userNameTextField.frame = CGRect(
            x: view.center.x - 130,
            y: view.center.y,
            width: 260,
            height: 50
        )
    
        startBtn.backgroundColor = .red
        startBtn.setTitle("Start", for: .normal)
        startBtn.addTarget(self, action: #selector(loginStar), for: .touchUpInside)
        startBtn.frame = CGRect(
            x: view.center.x - 50,
            y: view.center.y + 100,
            width: 100,
            height: 40
        )
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .none
    }
    
    // MARK: Action
    @objc func loginStar() {
        guard let name = userNameTextField.text, !name.isEmpty else { return }
        let vc = FlagGameViewController(userName: name)
        navigationController?.pushViewController(vc, animated: true)
    }
}
