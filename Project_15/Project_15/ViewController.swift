//
//  ViewController.swift
//  Project_15
//
//  Created by franklin gaspar on 13/06/23.
//

import UIKit

class ViewController: UIViewController {
    var imageView: UIImageView!
    var currentAnimation = 0
    var tapButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 600, y: 384)
        view.addSubview(imageView)
        tapButton.setTitle("Tap", for: .normal)
        tapButton.backgroundColor = .orange
        tapButton.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        tapButton.frame = CGRect(
            x: view.center.x - 50,
            y: view.frame.height - 100,
            width: 100, height: 50
        )

        view.addSubview(tapButton)
        
    }


    @objc func tapped(_ sender: UIButton) {
        sender.isHidden = true

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            switch self.currentAnimation {
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)

            case 1:
                self.imageView.transform = .identity
           
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)

            case 3:
                self.imageView.transform = .identity
                
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            case 5:
                self.imageView.transform = .identity
                
            case 6:
                self.imageView.alpha = 0.1
                self.imageView.backgroundColor = UIColor.green

            case 7:
                self.imageView.alpha = 1
                self.imageView.backgroundColor = UIColor.clear
            default:
                break
            }
        }) { finished in
            sender.isHidden = false
        }

        currentAnimation += 1

        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
}

