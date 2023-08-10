
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: Views
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
  
    
    // MARK: Components
    var canMovePlayer = true
    var possibleEnemies = ["ball", "hammer", "tv"]
    var gameTimer: Timer?
    var isGameOver = false
    var enemyAmount = Int()
    var numbertimer: Double = 0.50
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func didMove(to view: SKView) {
        backgroundColor = .black

        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1

        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)

        score = 0

        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self

        gameTimer = Timer.scheduledTimer(timeInterval: numbertimer, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    }

    @objc func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        if enemyAmount <= 20 {
            let sprite = SKSpriteNode(imageNamed: enemy)
            sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
            addChild(sprite)

            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.categoryBitMask = 1
            sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
            sprite.physicsBody?.angularVelocity = 5
            sprite.physicsBody?.linearDamping = 0
            sprite.physicsBody?.angularDamping = 0
            enemyAmount += 1
        } else {
            enemyAmount = 0
            gameTimer?.invalidate()
            numbertimer -= 0.01
            gameTimer = Timer.scheduledTimer(timeInterval: numbertimer, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        }
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }

        if !isGameOver {
            score += 1
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard canMovePlayer, let touch = touches.first else { return }
        var location = touch.location(in: self)

        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }

        player.position = location
    }

    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)

        player.removeFromParent()
        gameTimer?.invalidate()
        isGameOver = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        
        if !player.contains(location) {
            canMovePlayer = false
        } else {
            canMovePlayer = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        
        if !player.contains(location) {
            canMovePlayer = false
        } else {
            canMovePlayer = true
        }
    }
}