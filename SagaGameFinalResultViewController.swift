//
//  SagaGameFinalResultViewController.swift
//  Primal Spark Saga
//
//  Created by TestName on 30.07.24.
//

import UIKit


//MARK: - Final class SagaGameFinalResultViewController
final class SagaGameFinalResultViewController: UIViewController {
    
    //MARK: - Properties
    private let sagaGameResetButton = UIButton()
    private let toDistributionButton = UIButton()
    
    private let combinationGroupImageView = UIImageView()
    private let ellipsoideImageView = UIImageView()
    
    public var finalSagaGameScore = 0
    var restart: (() -> Void)?
    var distributionPointScreenRouting: (() -> Void)?
    
    private let recordNamingLabel = UILabel()
    private let recordValueLabel = UILabel()
    private let scoreNamingLabel = UILabel()
    private let scoreValueLabel = UILabel()
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addFinalScreensSubviews()
        setConstraintsMaskValue()
        addFinalScreensConstraintes()
        addFinalScreensInterface()
        screenButtonsTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateRecordIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SagaMediaHandler.once.simpleButtonTaping(song: "takeProfit")
    }
    
    
    //MARK: - Subwiews setting
    private func addFinalScreensSubviews() {
        view.addSubview(ellipsoideImageView)
        view.addSubview(combinationGroupImageView)
        view.addSubview(toDistributionButton)
        view.addSubview(sagaGameResetButton)
        view.addSubview(recordNamingLabel)
        view.addSubview(scoreValueLabel)
        view.addSubview(scoreNamingLabel)
        view.addSubview(recordValueLabel)
    }
    
    private func setConstraintsMaskValue() {
        ellipsoideImageView.translatesAutoresizingMaskIntoConstraints = false
        combinationGroupImageView.translatesAutoresizingMaskIntoConstraints = false
        toDistributionButton.translatesAutoresizingMaskIntoConstraints = false
        sagaGameResetButton.translatesAutoresizingMaskIntoConstraints = false
        recordNamingLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreValueLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreNamingLabel.translatesAutoresizingMaskIntoConstraints = false
        recordValueLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Score record's control
    private func updateRecordIfNeeded() {
        let previousRecord = UserDefaults.standard.integer(forKey: "record")
        let isNewRecord = finalSagaGameScore > previousRecord
        
        if isNewRecord {
            saveNewRecord(finalSagaGameScore)
            displayNewRecordImageAndText(finalSagaGameScore)
        } else {
            displayExistingRecordImageAndText(previousRecord)
        }
    }

    private func saveNewRecord(_ score: Int) {
        UserDefaults.standard.set(score, forKey: "record")
    }

    private func displayNewRecordImageAndText(_ score: Int) {
        combinationGroupImageView.image = UIImage(named: "winCombinationGroup")
        recordValueLabel.text = "\(score)"
    }

    private func displayExistingRecordImageAndText(_ score: Int) {
        combinationGroupImageView.image = UIImage(named: "tryCombinationGroup")
        recordValueLabel.text = "\(score)"
    }
    
    
    //MARK: - Constraintes
    private func addFinalScreensConstraintes() {
        ellipsoideImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ellipsoideImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        ellipsoideImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        ellipsoideImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        combinationGroupImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        combinationGroupImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -44).isActive = true
        combinationGroupImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        combinationGroupImageView.heightAnchor.constraint(equalTo: combinationGroupImageView.widthAnchor, multiplier: 1.4).isActive = true
        
        sagaGameResetButton.centerYAnchor.constraint(equalTo: combinationGroupImageView.bottomAnchor, constant: -18).isActive = true
        sagaGameResetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sagaGameResetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48).isActive = true
        sagaGameResetButton.heightAnchor.constraint(equalTo: sagaGameResetButton.widthAnchor, multiplier: 0.37).isActive = true
        
        toDistributionButton.topAnchor.constraint(equalTo: sagaGameResetButton.bottomAnchor, constant: 3).isActive = true
        toDistributionButton.centerXAnchor.constraint(equalTo: sagaGameResetButton.centerXAnchor).isActive = true
        toDistributionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48).isActive = true
        toDistributionButton.heightAnchor.constraint(equalTo: toDistributionButton.widthAnchor, multiplier: 0.37).isActive = true
        
        scoreNamingLabel.topAnchor.constraint(equalTo: combinationGroupImageView.topAnchor, constant: 15).isActive = true
        scoreNamingLabel.centerXAnchor.constraint(equalTo: combinationGroupImageView.centerXAnchor).isActive = true
        
        scoreValueLabel.topAnchor.constraint(equalTo: scoreNamingLabel.bottomAnchor, constant: -5).isActive = true
        scoreValueLabel.centerXAnchor.constraint(equalTo: scoreNamingLabel.centerXAnchor).isActive = true
        
        recordNamingLabel.topAnchor.constraint(equalTo: scoreValueLabel.bottomAnchor, constant: 5).isActive = true
        recordNamingLabel.centerXAnchor.constraint(equalTo: scoreValueLabel.centerXAnchor).isActive = true
        
        recordValueLabel.topAnchor.constraint(equalTo: recordNamingLabel.bottomAnchor, constant: -5).isActive = true
        recordValueLabel.centerXAnchor.constraint(equalTo: recordNamingLabel.centerXAnchor).isActive = true
    }
    
    private func buttonsMediaHandler() {
        SagaMediaHandler.once.simpleButtonTaping(song: "dry")
    }
    
    //MARK: - UI
    private func addFinalScreensInterface() {
        ellipsoideImageView.image = UIImage(resource: .ellipsoide)
        ellipsoideImageView.contentMode = .scaleAspectFill
        
        combinationGroupImageView.image = UIImage(resource: .winCombinationGroup)
        combinationGroupImageView.contentMode = .scaleAspectFill
        
        scoreNamingLabel.textAlignment = .center
        scoreNamingLabel.textColor = UIColor.blueColorSet
        scoreNamingLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        scoreNamingLabel.text = "YOUR SCОRE "
        
        recordNamingLabel.textAlignment = .center
        recordNamingLabel.textColor = UIColor.blueColorSet
        recordNamingLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        recordNamingLabel.text = "BEST SCОRE "
        
        scoreValueLabel.textAlignment = .center
        scoreValueLabel.textColor = UIColor.pinkColorSet
        scoreValueLabel.font = UIFont.systemFont(ofSize: 68, weight: .black)
        scoreValueLabel.text = "\(finalSagaGameScore)"
        
        recordValueLabel.textAlignment = .center
        recordValueLabel.textColor = UIColor.pinkColorSet
        recordValueLabel.font = UIFont.systemFont(ofSize: 54, weight: .black)
        
        toDistributionButton.setBackgroundImage(UIImage(resource: .toDistributionButton), for: .normal)
        toDistributionButton.contentMode = .scaleAspectFit

        sagaGameResetButton.setBackgroundImage(UIImage(resource: .sagaGameReset), for: .normal)
        sagaGameResetButton.contentMode = .scaleAspectFit
    }
    
    private func screenButtonsTargets() {
        sagaGameResetButton.addTarget(self, action: #selector(resetSagaGame), for: .touchUpInside)
        toDistributionButton.addTarget(self, action: #selector(openDistributionPointScreen), for: .touchUpInside)
    }
    
    //MARK: - Buttons API
    @objc private func resetSagaGame() {
        buttonsMediaHandler()
        restart?()
        dismiss(animated: true)
    }
    
    @objc private func openDistributionPointScreen() {
        buttonsMediaHandler()
        distributionPointScreenRouting?()
        dismiss(animated: true)
    }
}
