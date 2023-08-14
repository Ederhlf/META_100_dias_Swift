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
    var firstTarget =  SKSpriteNode()
    var targetsIMages: [SKSpriteNode] = []

    override func didMove(to view: SKView) {
        backgroundColor = .orange

        var third = creatingTarget(positionY: 450)
        var second = creatingTarget(positionY: 250)
        var first = creatingTarget(positionY: 650)

        targetsIMages.append(first)
        targetsIMages.append(second)
        targetsIMages.append(third)
        linearvelocity(spriteNode: first)
        linearvelocity(spriteNode: second)
        linearvelocity(spriteNode:third)

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.text = "Score:"
        addChild(scoreLabel)

        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard !targetsIMages.isEmpty else {return}
        for targeyImage in targetsIMages {
            if targeyImage.position.x >= size.width - targeyImage.size.width / 2 {
                targeyImage.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
            } else if targeyImage.position.x <= targeyImage.size.width / 2 {
                targeyImage.physicsBody?.velocity = CGVector(dx: 500, dy: 0)
            }
        }
       
    }
    
    func creatingTarget(positionY: CGFloat) -> SKSpriteNode {
        
        var target = SKSpriteNode(imageNamed: "img_target")
        target.position = CGPoint(x: UIScreen.main.bounds.width / 1.5, y: positionY)
        addChild(target)
        target.size = CGSize(width: 100, height: 100)

        return target
    }
    
    func linearvelocity(spriteNode: SKSpriteNode) {
        spriteNode.physicsBody = SKPhysicsBody(texture: spriteNode.texture!, size: spriteNode.size)
        spriteNode.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        spriteNode.physicsBody?.contactTestBitMask = 1

        spriteNode.physicsBody?.angularVelocity = 5
        spriteNode.physicsBody?.linearDamping = 0
        spriteNode.physicsBody?.angularDamping = 0
    }
}
