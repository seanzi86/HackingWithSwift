//
//  GameScene.swift
//  Project11
//
//  Created by Sean Carrington on 02/03/2019.
//  Copyright © 2019 seanzi86. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var remainingBallsLabel: SKLabelNode!
    var editLabel: SKLabelNode!
    var ballColours = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var remainingBalls = 5 {
        didSet {
            remainingBallsLabel.text = "Balls: \(remainingBalls)"
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
        
        ballColours.append("Grey")
        ballColours.append("Blue")
        ballColours.append("Purple")
        ballColours.append("Red")
        ballColours.append("Yellow")
        ballColours.append("Cyan")
        
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x:512, y:384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x:128, y:0), isGood: true)
        makeSlot(at: CGPoint(x:384, y:0), isGood: false)
        makeSlot(at: CGPoint(x:640, y:0), isGood: true)
        makeSlot(at: CGPoint(x:896, y:0), isGood: false)
        
        makeBouncer(at: CGPoint(x:0, y:0))
        makeBouncer(at: CGPoint(x:256, y:0))
        makeBouncer(at: CGPoint(x:512, y:0))
        makeBouncer(at: CGPoint(x:768, y:0))
        makeBouncer(at: CGPoint(x:1024, y:0))
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        remainingBallsLabel = SKLabelNode(fontNamed: "ChalkDuster")
        remainingBallsLabel.text = "Balls: 5"
        remainingBallsLabel.horizontalAlignmentMode = .right
        remainingBallsLabel.position = CGPoint(x: 750, y: 700)
        addChild(remainingBallsLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let objects = nodes(at: location)
            if objects.contains(editLabel) {
                editingMode = !editingMode
            } else {
                if (editingMode) {
                    let boxes = objects.filter{$0.name == "box"};
                    if (boxes.count > 0) {
                        removeChildren(in: boxes)
                    } else {
                        addBox(at: location)
                    }
                } else {
                    addBall(at: location)
                }
            }
        }
    }
    
    func addBox(at position: CGPoint) {
        let size = CGSize(width: Int.random(in: 16...128), height: 16)
        let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue:CGFloat.random(in: 0...1), alpha:CGFloat.random(in: 0...1)), size: size)
        box.zRotation = CGFloat.random(in: 0...3)
        box.position = position
        box.name = "box"
        
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.isDynamic = false
        addChild(box)
    }
    
    func addBall(at position: CGPoint) {
        let ballColour = ballColours[Int.random(in: 0...5)]
        let ballImage = "ball" + ballColour
        let ball = SKSpriteNode(imageNamed: ballImage)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        ball.physicsBody?.restitution = 0.4
        ball.position = position
        ball.position.y = 768
        ball.name = "ball"
        addChild(ball)
        remainingBalls -= 1
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
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        slotBase.position = position
        slotGlow.position = position
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "box" {
            score += 1
            object.removeFromParent()
        } else if object.name == "good" {
            destroy(ball: ball)
            remainingBalls += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
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
        } else {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
}
