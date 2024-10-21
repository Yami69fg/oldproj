//
//  UpgradeSagaGame.swift
//  Primal Spark Saga
//
//  Created by TestName on 31.07.24.
//

import SpriteKit

//MARK: - Game level control
extension SagaGameScene {
    private func setupMobileConstructionSpriteChild(with position: CGPoint, _ rotation: CGFloat, _ type: MobileConstruction.ConstructionType) {
        mobileConstruction = MobileConstruction(type: type)
        mobileConstruction.position = position
        mobileConstruction.zRotation = rotation
        addChild(mobileConstruction)
    }
    
    private func setupStaticConstructionSpriteChild(with position: CGPoint, _ rotation: CGFloat, _ actionType: StaticConstruction.TypeOfAction) {
        staticConstruction = StaticConstruction(actionType: actionType)
        staticConstruction.position = position
        staticConstruction.zRotation = rotation
        staticConstruction.alpha = 0
        addChild(staticConstruction)
    }
    
    private func setupSlotSpriteChild(with position: CGPoint) {
        slotTargetSprite = Slots()
        slotTargetSprite.position = position
        slotTargetSprite.anchorPoint = CGPoint(x: 0.5, y: 0)
        addChild(slotTargetSprite)
    }
    
    private func clearingConstructions() {
        enumerateChildNodes(withName: "mobileConstruction") { node, _ in
            node.removeFromParent()
        }
        enumerateChildNodes(withName: "slot") { node, _ in
            node.removeFromParent()
        }
        enumerateChildNodes(withName: "staticConstruction") { node, _ in
            node.removeFromParent()
        }
    }
    
    internal func newLevelCreating() {
        levelPreparation()
        switch self.sagaGameLevel {
        case 1:
            self.levelOne()
        case 2:
            self.levelTwo()
        case 3:
            self.levelThree()
        case 4:
            self.levelFour()
        case 5:
            self.levelFive()
        case 6:
            self.levelSix()
        case 7:
            self.levelSeven()
        default:
            break
        }
    }
    
    private func levelOne() {
        clearingConstructions()
        let width = self.frame.width
        let height = self.frame.height
        let constructionLeftPosition = CGPoint(x: width * 0.3, y: height * 0.6)
        let constructionRightPosition = CGPoint(x: width * 0.7, y: height * 0.4)
        let slotPosition = CGPoint(x: self.frame.midX - 30, y: self.frame.height * 0.05)
        self.setupMobileConstructionSpriteChild(with: constructionLeftPosition, -0.06, .left)
        self.setupMobileConstructionSpriteChild(with: constructionRightPosition, 0.2, .right)
        self.setupSlotSpriteChild(with: slotPosition)
    }
    
    private func levelTwo() {
        clearingConstructions()
        let width = self.frame.width
        let height = self.frame.height
        let constructionLeftPosition = CGPoint(x: width * 0.33, y: height * 0.7)
        let constructionRightPosition = CGPoint(x: width * 0.66, y: height * 0.55)
        let staticConstructionPosition = CGPoint(x: width / 3, y: height * 0.3)
        let slotPosition = CGPoint(x: width * 0.8, y: self.frame.height * 0.05)
        self.setupMobileConstructionSpriteChild(with: constructionLeftPosition, -0.06, .left)
        self.setupMobileConstructionSpriteChild(with: constructionRightPosition, 0.2, .right)
        self.setupStaticConstructionSpriteChild(with: staticConstructionPosition, -0.2, .noWay)
        self.setupSlotSpriteChild(with: slotPosition)
    }
    
    private func levelThree() {
        clearingConstructions()
        let width = self.frame.width
        let height = self.frame.height
        let actionConstructionPosition = CGPoint(x: width * 0.45, y: height * 0.55)
        let staticConstructionPosition = CGPoint(x: width * 0.85, y: height * 0.35)
        let slotPosition = CGPoint(x: width * 0.4, y: self.frame.height * 0.13)
        self.setupMobileConstructionSpriteChild(with: actionConstructionPosition, -2.4, .corner)
        self.setupStaticConstructionSpriteChild(with: staticConstructionPosition, 0.15, .noWay)
        self.setupSlotSpriteChild(with: slotPosition)
    }
    
    private func levelFour() {
        clearingConstructions()
        let width = self.frame.width
        let height = self.frame.height
        let constructionLeftPosition = CGPoint(x: width * 0.2, y: height * 0.42)
        let constructionRightPosition = CGPoint(x: width * 0.6, y: height * 0.55)
        let staticConstructionPosition = CGPoint(x: width * 0.4, y: height * 0.5)
        let slotPosition = CGPoint(x: width * 0.6, y: self.frame.height * 0.05)
        self.setupMobileConstructionSpriteChild(with: constructionLeftPosition, -0.3, .corner)
        self.setupMobileConstructionSpriteChild(with: constructionRightPosition, 3.3, .corner)
        self.setupStaticConstructionSpriteChild(with: staticConstructionPosition, -1, .lightRotate)
        self.setupSlotSpriteChild(with: slotPosition)
    }
    
    private func levelFive() {
        clearingConstructions()
        let width = self.frame.width
        let height = self.frame.height
        let constructionLeftPosition = CGPoint(x: width * 0.7, y: height * 0.6)
        let constructionRightPosition = CGPoint(x: width * 0.2, y: height * 0.4)
        let staticTopConstructionPosition = CGPoint(x: width * 0.5, y: height * 0.5)
        let staticBotConstructionPosition = CGPoint(x: width * 0.5, y: height * 0.3)
        let slotPosition = CGPoint(x: width * 0.3, y: self.frame.height * 0.05)
        self.setupMobileConstructionSpriteChild(with: constructionLeftPosition, 4, .corner)
        self.setupMobileConstructionSpriteChild(with: constructionRightPosition, 3.7, .corner)
        self.setupStaticConstructionSpriteChild(with: staticTopConstructionPosition, -0.3, .moveLeft)
        self.setupStaticConstructionSpriteChild(with: staticBotConstructionPosition, 0.3, .moveRight)
        self.setupSlotSpriteChild(with: slotPosition)
    }
    
    private func levelSix() {
        clearingConstructions()
        let width = self.frame.width
        let height = self.frame.height
        let constructionRightPosition = CGPoint(x: width * 0.45, y: height * 0.5)
        let staticTopLeftConstructionPosition = CGPoint(x: width * 0.3, y: height * 0.65)
        let staticTopRightConstructionPosition = CGPoint(x: width * 0.7, y: height * 0.65)
        let staticBotLeftConstructionPosition = CGPoint(x: width * 0.3, y: height * 0.3)
        let staticBotRightConstructionPosition = CGPoint(x: width * 0.7, y: height * 0.3)
        let slotPosition = CGPoint(x: width * 0.45, y: self.frame.height * 0.05)
        self.setupMobileConstructionSpriteChild(with: constructionRightPosition, 4, .corner)
        self.setupStaticConstructionSpriteChild(with: staticTopLeftConstructionPosition, 0, .fullLeft)
        self.setupStaticConstructionSpriteChild(with: staticTopRightConstructionPosition, 0, .fullRight)
        self.setupStaticConstructionSpriteChild(with: staticBotLeftConstructionPosition, -0.4, .noWay)
        self.setupStaticConstructionSpriteChild(with: staticBotRightConstructionPosition, 0.4, .noWay)
        self.setupSlotSpriteChild(with: slotPosition)
    }
    
    private func levelSeven() {
        clearingConstructions()
        let width = self.frame.width
        let height = self.frame.height
        let constructionRightPosition = CGPoint(x: width * 0.5, y: height * 0.2)
        let staticConstructionMiddlePosition = CGPoint(x: width * 0.5, y: height * 0.5)
        let staticTopLeftConstructionPosition = CGPoint(x: width * 0.3, y: height * 0.6)
        let staticTopRightConstructionPosition = CGPoint(x: width * 0.7, y: height * 0.6)
        let staticBotLeftConstructionPosition = CGPoint(x: width * 0.3, y: height * 0.35)
        let staticBotRightConstructionPosition = CGPoint(x: width * 0.7, y: height * 0.35)
        let slotPosition = CGPoint(x: width * 0.4, y: self.frame.height * 0.05)
        self.setupMobileConstructionSpriteChild(with: constructionRightPosition, 3.8, .corner)
        self.setupStaticConstructionSpriteChild(with: staticConstructionMiddlePosition, 0, .fullLeft)
        self.setupStaticConstructionSpriteChild(with: staticTopLeftConstructionPosition, 0.5, .noWay)
        self.setupStaticConstructionSpriteChild(with: staticTopRightConstructionPosition, -0.5, .noWay)
        self.setupStaticConstructionSpriteChild(with: staticBotLeftConstructionPosition, -0.4, .noWay)
        self.setupStaticConstructionSpriteChild(with: staticBotRightConstructionPosition, 0.4, .noWay)
        self.setupSlotSpriteChild(with: slotPosition)
    }
}
