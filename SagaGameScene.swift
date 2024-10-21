//
//  SagaGameScene.swift
//  Primal Spark Saga
//
//  Created by TestName on 29.07.24.
//

import SpriteKit
import GameplayKit


//MARK: - Final class SagaGameScene
final class SagaGameScene: SKScene {
    
    //MARK: - Properties declaration of scene
    internal var sagaGameLevel = 1
    private var stageOfLevel = 1 {
        didSet {
            checkLevelStage()
        }
    }
    
    weak var arcaneGameController: SagaSparkGameController?

    private var superGunSprite: SuperGun!
    internal var slotTargetSprite: Slots!
    private var baseBallSprite: BaseBall!
    internal var mobileConstruction: MobileConstruction!
    internal var staticConstruction: StaticConstruction!
    private var gameBackground: BackPictureSagaScene!
    private var touchedNode: MobileConstruction?
    
    internal var isFireAvailiable: Bool = false
    internal var isConscructionsMoving = true
    
    private var initialTouchPosition: CGPoint?
    private var initialNodePosition: CGPoint?
    private var previousTouchLocation: CGPoint?
    private var savedContactTime: TimeInterval = 0

    
    // MARK: - Setup of didMove override method
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.collisionBitMask = 0
        physicsBody?.categoryBitMask = ChildSpriteContactMask.sceneFrame
        physicsBody?.contactTestBitMask = ChildSpriteContactMask.baseBall
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        
        sagaGameWorldCreation()
    }
    
    public func newSagaGameSetup() {
        self.removeAllChildren()
        self.removeAllActions()
        sagaGameLevel = 1
        sagaGameLevel = 1
        savedContactTime = 0
        isFireAvailiable = false
        isConscructionsMoving = true
        sagaGameWorldCreation()
        
        scene?.isPaused = false
    }
    
    private func sagaGameWorldCreation() {
        gameBackground = BackPictureSagaScene(sagaScene: self.frame.width, self.frame.height)
        gameBackground.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        addChild(gameBackground)
        setupSuperGunSpriteChild()
        newLevelCreating()
    }
}
    
    
//MARK: - Game flow control
extension SagaGameScene {
    
    //MARK: - Game flow control
    public func stopSagaAction() {
        scene?.isPaused = true
    }
    
    public func playSagaAction() {
        scene?.isPaused = false
    }
}
    
    
//MARK: - Childs creating
extension SagaGameScene {
    
    private func setupSuperGunSpriteChild() {
        superGunSprite = SuperGun()
        let positionY = self.frame.height * 0.91
        let positionX = self.frame.midX
        superGunSprite.position = CGPoint(x: positionX, y: positionY)
        superGunSprite.anchorPoint = CGPoint(x: 0.5, y: 1)
        addChild(superGunSprite)
    }
    
    private func setupBaseBallSpriteChild() {
        baseBallSprite = BaseBall()
        let positionY = self.frame.height * 0.91
        let positionX = self.frame.midX
        baseBallSprite.position = CGPoint(x: positionX, y: positionY)
        addChild(baseBallSprite)
    }
    
    
    //MARK: - Child views actions
    private func superGunRotation() {
        let initialAngelPosition = SKAction.rotate(toAngle: 0, duration: 0.5)
        let waiting = SKAction.wait(forDuration: 0.3)
        let firstRotate = SKAction.rotate(toAngle: -.pi / 4, duration: 2.0)
        
        let rotateLeft = SKAction.rotate(toAngle: -.pi / 4, duration: 4.0)
        let rotateRight = SKAction.rotate(toAngle: .pi / 4, duration: 4.0)
        let rotationSequence = SKAction.sequence([rotateRight, rotateLeft])
        let rotateForever = SKAction.repeatForever(rotationSequence)
        
        let rotateSequence = SKAction.sequence([initialAngelPosition, waiting, firstRotate, rotateForever])
        
        superGunSprite.run(rotateSequence)
    }
    
    private func staticConstructionsAppearance() {
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        enumerateChildNodes(withName: "staticConstruction") { node, _ in
            node.run(fadeIn)
        }
    }
}
    
 
//MARK: - Game flow actions
extension SagaGameScene {
    private func shootBaseBall() {
        let angle = superGunSprite.zRotation + .pi / 2
        let velocityX = -cos(angle) * 450
        let velocityY = -sin(angle) * 450
        let waiting = SKAction.wait(forDuration: 0.2)
        baseBallSprite.physicsBody?.velocity = CGVector(dx: velocityX, dy: velocityY)
        baseBallSprite.run(waiting) {
            self.baseBallSprite.physicsBody?.affectedByGravity = true
        }
    }
    
    internal func levelPreparation() {
        superGunSprite.removeAllActions()
        let initialAngelPosition = SKAction.rotate(toAngle: 0, duration: 0.5)
        superGunSprite.run(initialAngelPosition)
        
        isFireAvailiable = false
        isConscructionsMoving = true
        arcaneGameController?.countOfattempts = 3
        arcaneGameController?.startCountdown()
    }
    
    public func endOfLevelPreperation() {
        enumerateChildNodes(withName: "mobileConstruction") { node, _ in
            let construction = node as? MobileConstruction
            if let construction {
                construction.removeActions()
            }
        }
        isConscructionsMoving = false
        isFireAvailiable = true
        superGunRotation()
        staticConstructionsAppearance()
    }
    
    private func checkLevelStage() {
        if stageOfLevel > 3 {
            sagaGameLevel += 1
            newLevelCreating()
            stageOfLevel = 1
        } else if stageOfLevel == 2 || stageOfLevel == 3 {
            isFireAvailiable = true
            superGunRotation()
        }
    }
}


//MARK: - Override funcs
extension SagaGameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if isConscructionsMoving {
            let location = touch.location(in: self)
            let nodeAtPoint = atPoint(location)
            
            if nodeAtPoint.name == "mobileConstruction" {
                touchedNode = nodeAtPoint as? MobileConstruction
                initialTouchPosition = location
                initialNodePosition = touchedNode?.position
            }
        }
        
        if isFireAvailiable {
            superGunSprite.stopAndFire()
            setupBaseBallSpriteChild()
            shootBaseBall()
            isFireAvailiable = false
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isConscructionsMoving else { return }
        guard let touch = touches.first, let touchedNode = touchedNode,
              let initialTouchPosition = initialTouchPosition,
              let initialNodePosition = initialNodePosition else { return }
        guard touchedNode.isMovingAvailiable else { return }
        
        let currentTouchPosition = touch.location(in: self)
        var deltaX = currentTouchPosition.x - initialTouchPosition.x
        if deltaX > 50 {
            deltaX = 50
        } else if deltaX < -50 {
            deltaX = -50
        }
        
        let clampedXPosition = initialNodePosition.x + deltaX
        touchedNode.position = CGPoint(x: clampedXPosition, y: initialNodePosition.y)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchedNode?.isMovingAvailiable = false
        touchedNode?.removeActions()
        
        touchedNode = nil
        initialTouchPosition = nil
        initialNodePosition = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
}


//MARK: - Implementation of collision detection function
extension SagaGameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let timeNow = NSDate().timeIntervalSince1970
        
        guard (timeNow - savedContactTime) > 0.3 else { return }
        savedContactTime = timeNow
        
        if contact.bodyA.categoryBitMask == ChildSpriteContactMask.baseBall && contact.bodyB.categoryBitMask == ChildSpriteContactMask.sceneFrame || contact.bodyA.categoryBitMask == ChildSpriteContactMask.sceneFrame && contact.bodyB.categoryBitMask == ChildSpriteContactMask.baseBall {
            
            baseBallSprite.baseBallRemoving()
            isFireAvailiable = true
            superGunRotation()
            
            let missingSound = SKAction.playSoundFileNamed("missing.mp3", waitForCompletion: false)
            self.run(missingSound)
            arcaneGameController?.countOfattempts -= 1
        }
        
        if contact.bodyA.categoryBitMask == ChildSpriteContactMask.baseBall && contact.bodyB.categoryBitMask == ChildSpriteContactMask.slot || contact.bodyA.categoryBitMask == ChildSpriteContactMask.slot && contact.bodyB.categoryBitMask == ChildSpriteContactMask.baseBall {
            
            arcaneGameController?.upgradeSagaScore(where: stageOfLevel)
            let takeProfitSound = SKAction.playSoundFileNamed("yeah.mp3", waitForCompletion: false)
            self.run(takeProfitSound)
            slotTargetSprite.stageUpdate()
            baseBallSprite.baseBallRemoving()
            stageOfLevel += 1
        }
    }
}
