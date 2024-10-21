//
//  SagaSparkGameController.swift
//  Primal Spark Saga
//
//  Created by TestName on 29.07.24.
//

import UIKit
import SpriteKit
import GameplayKit


//MARK: - Final class SagaSparkGameController
final class SagaSparkGameController: UIViewController {
    
    //MARK: - Properties declaration of view controller
    private var countdownTimer: Timer?
    private var remainingTime: Int = 5
    private var sagaGameScene: SagaGameScene!
    
    public var gameLevel = 1 {
        didSet {
            countOfattempts = 3
        }
    }
    private var sagaUserScore: Int = 0 {
        didSet {
            sagaUserScoreLabelUpdate()
        }
    }
    public var countOfattempts = 3 {
        didSet {
            attemptsCountLabel.text = "x\(countOfattempts)"
            attemptsStatusControl()
        }
    }
        
    private let distributionPointButton = UIButton()
    private let sagaGameSettingsButton = UIButton()
    private let atomMiniImageView = UIImageView()
    private let frameForUserScore = UIImageView()
    private let attemptsCountLabel = UILabel()
    private let sagaUserScoreLabel = UILabel()
    private let timerLabel = UILabel()
    
    
    //MARK: - Lifecycles description of view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        addScene()
        addGameControllersSubviews()
        setConstraintsMaskValue()
        addGameControllersScreensConstraintes()
        addGameControllersScreensInterface()
        screenButtonsTargets()
    }
    
    private func newGameBuildSettings() {
        self.sagaUserScore = 0
        self.gameLevel = 1
        self.countOfattempts = 3
        self.sagaGameScene.newSagaGameSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK: - Subwiews setting
    private func addGameControllersSubviews() {
        view.addSubview(sagaGameSettingsButton)
        view.addSubview(distributionPointButton)
        view.addSubview(frameForUserScore)
        view.addSubview(sagaUserScoreLabel)
        view.addSubview(atomMiniImageView)
        view.addSubview(attemptsCountLabel)
        view.addSubview(timerLabel)
    }
    
    private func addScene() {
        self.view = SKView(frame: view.frame)
        if let sparkView = self.view as! SKView? {
            let sparkScene = SagaGameScene(size: sparkView.bounds.size)
            sparkScene.scaleMode = .aspectFill
            sparkScene.arcaneGameController = self
            self.sagaGameScene = sparkScene
            sparkView.presentScene(sparkScene)
        }
    }
    
    private func setConstraintsMaskValue() {
        sagaGameSettingsButton.translatesAutoresizingMaskIntoConstraints = false
        distributionPointButton.translatesAutoresizingMaskIntoConstraints = false
        frameForUserScore.translatesAutoresizingMaskIntoConstraints = false
        sagaUserScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        atomMiniImageView.translatesAutoresizingMaskIntoConstraints = false
        attemptsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Constraintes
    private func addGameControllersScreensConstraintes() {
        frameForUserScore.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.height * 0.065)).isActive = true
        frameForUserScore.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        frameForUserScore.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        frameForUserScore.heightAnchor.constraint(equalTo: frameForUserScore.widthAnchor, multiplier: 0.3).isActive = true
        
        distributionPointButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        distributionPointButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        distributionPointButton.heightAnchor.constraint(equalToConstant: 51).isActive = true
        distributionPointButton.widthAnchor.constraint(equalTo: distributionPointButton.heightAnchor).isActive = true
        
        sagaGameSettingsButton.topAnchor.constraint(equalTo: distributionPointButton.bottomAnchor).isActive = true
        sagaGameSettingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        sagaGameSettingsButton.heightAnchor.constraint(equalToConstant: 51).isActive = true
        sagaGameSettingsButton.widthAnchor.constraint(equalTo: sagaGameSettingsButton.heightAnchor).isActive = true
        
        sagaUserScoreLabel.centerYAnchor.constraint(equalTo: frameForUserScore.centerYAnchor, constant: 3).isActive = true
        sagaUserScoreLabel.centerXAnchor.constraint(equalTo: frameForUserScore.centerXAnchor).isActive = true
        
        atomMiniImageView.centerYAnchor.constraint(equalTo: frameForUserScore.centerYAnchor).isActive = true
        atomMiniImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        atomMiniImageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        atomMiniImageView.widthAnchor.constraint(equalTo: atomMiniImageView.heightAnchor).isActive = true
        
        attemptsCountLabel.centerYAnchor.constraint(equalTo: atomMiniImageView.centerYAnchor).isActive = true
        attemptsCountLabel.centerXAnchor.constraint(equalTo: atomMiniImageView.centerXAnchor).isActive = true
        
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    //MARK: - Setup of UI
    private func addGameControllersScreensInterface() {
        frameForUserScore.image = UIImage(resource: .topGameFrame)
        frameForUserScore.contentMode = .scaleAspectFit
        
        sagaUserScoreLabel.textColor = .white
        sagaUserScoreLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        sagaUserScoreLabel.text = "\(sagaUserScore)"
        
        atomMiniImageView.image = UIImage(resource: .atom)
        atomMiniImageView.contentMode = .scaleAspectFit
        
        attemptsCountLabel.textColor = .blue
        attemptsCountLabel.font = UIFont.systemFont(ofSize: 23, weight: .black)
        attemptsCountLabel.text = "x\(countOfattempts)"
        
        sagaGameSettingsButton.setBackgroundImage(UIImage(resource: .adminStopBtn), for: .normal)
        sagaGameSettingsButton.contentMode = .scaleAspectFit
        
        distributionPointButton.setBackgroundImage(UIImage(resource: .adminHomeBtn), for: .normal)
        distributionPointButton.contentMode = .scaleAspectFit
        
        timerLabel.textColor = .blue
        timerLabel.font = UIFont.systemFont(ofSize: 84, weight: .black)
        timerLabel.text = "\(remainingTime)"
        timerLabel.alpha = 0.8
    }
    
    private func screenButtonsTargets() {
        sagaGameSettingsButton.addTarget(self, action: #selector(gameSettingsTransit), for: .touchUpInside)
        distributionPointButton.addTarget(self, action: #selector(distributionPointTransit), for: .touchUpInside)
    }
    
    
    //MARK: - Timer controll
    public func startCountdown() {
        timerLabel.isHidden = false
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(updateTimer),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    @objc private func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            updateTimerLabel()
        } else {
            countdownTimer?.invalidate()
            countdownTimer = nil
            timerDidFinish()
        }
    }
    
    private func updateTimerLabel() {
        timerLabel.text = "\(remainingTime)"
    }
    
    private func timerDidFinish() {
        timerLabel.isHidden = true
        sagaGameScene.endOfLevelPreperation()
        remainingTime = 5
        updateTimerLabel()
    }
    
    
    //MARK: - Game Updatings
    private func sagaUserScoreLabelUpdate() {
        sagaUserScoreLabel.text = "\(sagaUserScore)"
        upgradeUserScorAction()
    }
    
    public func upgradeSagaScore(where levelStage: Int) {
        switch levelStage {
        case 1:
            sagaUserScore += 20
        case 2:
            sagaUserScore += 40
        case 3:
            sagaUserScore += 80
        default:
            break
        }
    }
    
    private func attemptsStatusControl() {
        if countOfattempts <= 0 {
            gameFinalScreenOpen()
        }
    }
    
    
    //MARK: - Buttons API
    @objc private func distributionPointTransit() {
        buttonsMediaHandler()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func gameSettingsTransit() {
        buttonsMediaHandler()
        gameSettingsScreenOpen()
    }
    
    private func bindingsForSettingsScreen(screen: SagaGameSettingsViewController) {
        screen.continueSagaGame = { [weak self] message in
            print(message)
            self?.sagaGameScene.playSagaAction()
        }
        screen.distributionPointScreenRouting = { [weak self] message in
            print(message)
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func bindingsForFinalScreen(screen: SagaGameFinalResultViewController) {
        screen.restart = { [weak self] in
            self?.newGameBuildSettings()
        }
        screen.distributionPointScreenRouting = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    
    //MARK: - Routing
    private func gameSettingsScreenOpen() {
        sagaGameScene.stopSagaAction()
        let settingsBlock = SagaGameSettingsViewController()
        bindingsForSettingsScreen(screen: settingsBlock)
        controllersSetupDisplay(viewController: settingsBlock)
        present(settingsBlock, animated: true)
    }
    
    private func gameFinalScreenOpen() {
        sagaGameScene.stopSagaAction()
        let summaryVisionCenter = SagaGameFinalResultViewController()
        bindingsForFinalScreen(screen: summaryVisionCenter)
        controllersSetupDisplay(viewController: summaryVisionCenter)
        summaryVisionCenter.finalSagaGameScore = sagaUserScore
        present(summaryVisionCenter, animated: true)
    }
    
    private func controllersSetupDisplay(viewController: UIViewController) {
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
    }
    
    
    //MARK: - Effects
    private func upgradeUserScorAction() {
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.sagaUserScoreLabel.alpha = 0.3
            self.sagaUserScoreLabel.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
            
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0.2) {
                self.sagaUserScoreLabel.alpha = 1
                self.sagaUserScoreLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    
    //MARK: - Click effects
    private func buttonsMediaHandler() {
        SagaMediaHandler.once.simpleButtonTaping(song: "dry")
    }
}
