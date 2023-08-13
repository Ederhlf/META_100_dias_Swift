//
//  GameScene.swift
//  Challenge_DAY_66
//
//  Created by franklin gaspar on 13/08/23.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
    var targets: SKSpriteNode!
    var scoreLabel: SKLabelNode!

    override func didMove(to view: SKView) {
        backgroundColor = .orange
        targets = SKSpriteNode(imageNamed: "img_target")
        targets.position = CGPoint(x: UIScreen.main.bounds.width / 1.5, y: 500)
        targets.physicsBody = SKPhysicsBody(texture: targets.texture!, size: targets.size)
        targets.physicsBody?.affectedByGravity = false // Impedir que o objeto caia
        targets.physicsBody?.contactTestBitMask = 1
        addChild(targets)
        
        targets.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        targets.physicsBody?.angularVelocity = 5
        targets.physicsBody?.linearDamping = 0
        targets.physicsBody?.angularDamping = 0
        targets.size = CGSize(width: 150, height: 150)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.text = "Score:"
        addChild(scoreLabel)

       
    }
    
    override func update(_ currentTime: TimeInterval) {
        if targets.position.x >= size.width - targets.size.width / 2 {
            targets.physicsBody?.velocity = CGVector(dx: -500, dy: 0) // Inverter direção para esquerda
        } else if targets.position.x <= targets.size.width / 2 {
            targets.physicsBody?.velocity = CGVector(dx: 500, dy: 0) // Inverter direção para direita
        }
    }
}
