
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel: SKLabelNode!
    var editLabel: SKLabelNode!
    var boxImages = [SKSpriteNode]()
    var ballsAmount = 1
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }

    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
<<<<<<< Updated upstream
        background.blendMode = .replace
=======
        // Blend - mesclagem Modo
        background.blendMode = .replace
        // posicao da image = posicionamento de nós
>>>>>>> Stashed changes
        background.zPosition = -1
        addChild(background)

        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self

        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y:0), isGood: false)

        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)

        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            var location = touch.location(in: self)
            let objects = nodes(at: location)

            if objects.contains(editLabel) {
                editingMode = !editingMode
            } else {
                if editingMode {
                    let box = boxAutodemention(location: location)
                    boxImages.append(box)
                   addChild(box)
                    
                } else {

                    if location.y >= 540 && ballsAmount <= 5 {
                        print("test")
                        let ball = SKSpriteNode(imageNamed: ballsName().randomElement() ?? String())
                        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
                        ball.physicsBody?.restitution = 0.4
                        ball.position = location
                        ball.name = "ball"
                        addChild(ball)
                        ballsAmount += 1
                    } else {
                        print("ballAmount f")
                        for image in boxImages {
                            image.removeFromParent()
                        }
                        ballsAmount = 1
                        self.view?.layoutIfNeeded()
                    }
                }
            }
        }
    }

    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }

    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode

        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }

        slotBase.position = position
        slotGlow.position = position

        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false

        addChild(slotBase)
        addChild(slotGlow)

        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }

    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
        }
    }

    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }

        ball.removeFromParent()
    }

    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
    
    func ballsName() -> [String] {
        var ballsName = [String]()
        let fileMAnager = FileManager.default
        let path = Bundle.main.resourcePath!
        
        let balls = try! fileMAnager.contentsOfDirectory(atPath: path)
        
        for ball in balls {
            if ball.hasPrefix("ball") && ball.hasSuffix("png") {
                ballsName.append(ball)
            }
        }
        
        return ballsName

    }
    
    
    func boxAutodemention(location: CGPoint) -> SKSpriteNode {
        let size = CGSize(width: Int.random(in: 16...128), height: 16)
<<<<<<< Updated upstream
        let box = SKSpriteNode(color: UIColor(
                                red: CGFloat.random(in: 0...1),
                                green: CGFloat.random(in: 0...1),
                                blue: CGFloat.random(in: 0...1),
                                alpha: 1
                             ), size: size)
        box.zRotation = CGFloat.random(in: 0...3)
        box.position = location
// body Down
=======
        let box = SKSpriteNode(
              color: UIColor(
                  red: CGFloat.random(in: 0...1),
                  green: CGFloat.random(in: 0...1),
                  blue: CGFloat.random(in: 0...1),
                  alpha: 1
               ), size: size)
        
        box.zRotation = CGFloat.random(in: 0...3)
        box.position = location

        // body Down
>>>>>>> Stashed changes
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = false
        
        return box
    }
}
