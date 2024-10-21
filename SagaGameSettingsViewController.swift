//
//  SagaGameSettingsViewController.swift
//  Primal Spark Saga
//
//  Created by TestName on 30.07.24.
//

import UIKit


//MARK: - Final class SagaGameSettingsViewController
final class SagaGameSettingsViewController: UIViewController {
    
    //MARK: - Properties
    private var isSoundAccess = Bool() {
        didSet {
            refreshSoundButtonState()
        }
    }
    private var isVibroAccess = Bool() {
        didSet {
            refreshVibrationButtonState()
        }
    }
    
    var distributionPointScreenRouting: ((String) -> Void)?
    var continueSagaGame: ((String) -> Void)?
    
    private let distributionPointButton = UIButton()
    private let soundToggleButton = UIButton()
    private let backSagaGameButton = UIButton()
    private let trimmerToggleButton = UIButton()
    private let sagaSettingsGroupImageView = UIImageView()
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addSettingsScreensSubviews()
        setConstraintsMaskValue()
        addSettingsScreensConstraintes()
        addSettingsScreensInterface()
        screenButtonsTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor?.withAlphaComponent(0.33)
        initializeEffectStates()
    }
    
    
    //MARK: - Subwiews setting
    private func addSettingsScreensSubviews() {
        view.addSubview(sagaSettingsGroupImageView)
        view.addSubview(backSagaGameButton)
        view.addSubview(distributionPointButton)
        view.addSubview(soundToggleButton)
        view.addSubview(trimmerToggleButton)
    }
    
    private func setConstraintsMaskValue() {
        backSagaGameButton.translatesAutoresizingMaskIntoConstraints = false
        sagaSettingsGroupImageView.translatesAutoresizingMaskIntoConstraints = false
        distributionPointButton.translatesAutoresizingMaskIntoConstraints = false
        soundToggleButton.translatesAutoresizingMaskIntoConstraints = false
        trimmerToggleButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Constraintes
    private func addSettingsScreensConstraintes() {
        sagaSettingsGroupImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sagaSettingsGroupImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        sagaSettingsGroupImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        sagaSettingsGroupImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.85).isActive = true
        
        trimmerToggleButton.topAnchor.constraint(equalTo: soundToggleButton.bottomAnchor, constant: 45).isActive = true
        trimmerToggleButton.centerXAnchor.constraint(equalTo: soundToggleButton.centerXAnchor).isActive = true
        trimmerToggleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.13).isActive = true
        trimmerToggleButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08).isActive = true
        
        soundToggleButton.bottomAnchor.constraint(equalTo: sagaSettingsGroupImageView.centerYAnchor, constant: -70).isActive = true
        soundToggleButton.leadingAnchor.constraint(equalTo: sagaSettingsGroupImageView.centerXAnchor, constant: 40).isActive = true
        soundToggleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.13).isActive = true
        soundToggleButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08).isActive = true
        
        backSagaGameButton.topAnchor.constraint(equalTo: distributionPointButton.bottomAnchor, constant: 13).isActive = true
        backSagaGameButton.centerXAnchor.constraint(equalTo: distributionPointButton.centerXAnchor).isActive = true
        backSagaGameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48).isActive = true
        backSagaGameButton.heightAnchor.constraint(equalTo: backSagaGameButton.widthAnchor, multiplier: 0.37).isActive = true
        
        distributionPointButton.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.frame.height * 0.7)).isActive = true
        distributionPointButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        distributionPointButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.48).isActive = true
        distributionPointButton.heightAnchor.constraint(equalTo: distributionPointButton.widthAnchor, multiplier: 0.37).isActive = true
    }
    
    private func buttonsMediaHandler() {
        SagaMediaHandler.once.simpleButtonTaping(song: "dry")
    }
    
    //MARK: - UI
    private func addSettingsScreensInterface() {
        trimmerToggleButton.backgroundColor = .clear

        soundToggleButton.backgroundColor = .clear
        
        backSagaGameButton.setBackgroundImage(UIImage(resource: .backSagaGame), for: .normal)
        backSagaGameButton.contentMode = .scaleAspectFit
        
        distributionPointButton.setBackgroundImage(UIImage(resource: .toDistributionButton), for: .normal)
        distributionPointButton.contentMode = .scaleAspectFit
        
        sagaSettingsGroupImageView.image = UIImage(resource: .sagaSettingsGroup)
        sagaSettingsGroupImageView.contentMode = .scaleAspectFill
    }
    
    private func screenButtonsTargets() {
        distributionPointButton.addTarget(self, action: #selector(openDistributionPointScreen), for: .touchUpInside)
        trimmerToggleButton.addTarget(self, action: #selector(switchVibrationState), for: .touchUpInside)
        backSagaGameButton.addTarget(self, action: #selector(backSagaGame), for: .touchUpInside)
        soundToggleButton.addTarget(self, action: #selector(switchSoundState), for: .touchUpInside)
    }
    
    //MARK: - Buttons API
    @objc private func openDistributionPointScreen() {
        buttonsMediaHandler()
        distributionPointScreenRouting?("Back menu button tapped")
        dismiss(animated: true)
    }
    
    @objc private func backSagaGame() {
        buttonsMediaHandler()
        continueSagaGame?("Play game button tapped")
        dismiss(animated: true)
    }
    
    @objc private func switchSoundState() {
        isSoundAccess = !isSoundAccess
        buttonsMediaHandler()
    }

    @objc private func switchVibrationState() {
        isVibroAccess = !isVibroAccess
        buttonsMediaHandler()
    }

    //MARK: - Effects state management
    private func initializeEffectStates() {
        isSoundAccess = UserDefaults.standard.bool(forKey: "soundEffect")
        isVibroAccess = UserDefaults.standard.bool(forKey: "trimmerEffect")
    }

    private func refreshSoundButtonState() {
        let imageName = isSoundAccess ? "onHandler" : "offHandler"
        
        soundToggleButton.setImage(UIImage(named: imageName), for: .normal)
        UserDefaults.standard.set(isSoundAccess, forKey: "soundEffect")
    }

    private func refreshVibrationButtonState() {
        let imageName = isVibroAccess ? "onHandler" : "offHandler"
        
        trimmerToggleButton.setImage(UIImage(named: imageName), for: .normal)
        UserDefaults.standard.set(isVibroAccess, forKey: "trimmerEffect")
    }
}
