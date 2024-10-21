//
//  DistributionPointViewController.swift
//  Primal Spark Saga
//
//  Created by TestName on 30.07.24.
//

import UIKit
import SafariServices

//MARK: - Final class DistributionPointViewController
final class DistributionPointViewController: UIViewController {
    
//MARK: - Properties
    private let playSagaButton = UIButton()
    private let atomImageView = UIImageView()
    private let modernScreenImageView = UIImageView()
    private let sagaConfidanceButton = UIButton()
    private let nameSagaImageView = UIImageView()

    
//MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addPuserScreensSubviews()
        setConstraintsMaskValue()
        addPusherScreensConstraintes()
        addPusherScreensInterface()
        screenButtonsTargets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    //MARK: - Subwiews setting
    private func addPuserScreensSubviews() {
        view.addSubview(modernScreenImageView)
        view.addSubview(sagaConfidanceButton)
        view.addSubview(playSagaButton)
        view.addSubview(nameSagaImageView)
        view.addSubview(atomImageView)
    }
    
    private func setConstraintsMaskValue() {
        modernScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        sagaConfidanceButton.translatesAutoresizingMaskIntoConstraints = false
        playSagaButton.translatesAutoresizingMaskIntoConstraints = false
        nameSagaImageView.translatesAutoresizingMaskIntoConstraints = false
        atomImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Setup subviews
    private func addPusherScreensConstraintes() {
        sagaConfidanceButton.topAnchor.constraint(equalTo: playSagaButton.bottomAnchor, constant: 8).isActive = true
        sagaConfidanceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sagaConfidanceButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.51).isActive = true
        sagaConfidanceButton.heightAnchor.constraint(equalTo: sagaConfidanceButton.widthAnchor, multiplier: 0.4).isActive = true
        
        atomImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (view.frame.height * 0.29)).isActive = true
        atomImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        atomImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        atomImageView.heightAnchor.constraint(equalTo: atomImageView.widthAnchor).isActive = true
        
        playSagaButton.topAnchor.constraint(equalTo: atomImageView.bottomAnchor, constant: 3).isActive = true
        playSagaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playSagaButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.63).isActive = true
        playSagaButton.heightAnchor.constraint(equalTo: playSagaButton.widthAnchor, multiplier: 0.4).isActive = true
        
        modernScreenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        modernScreenImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        modernScreenImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        modernScreenImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        nameSagaImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameSagaImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (view.frame.height * 0.1)).isActive = true
        nameSagaImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        nameSagaImageView.heightAnchor.constraint(equalTo: nameSagaImageView.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    private func buttonsMediaHandler() {
        SagaMediaHandler.once.simpleButtonTaping(song: "dry")
    }
    
    private func addPusherScreensInterface() {
        sagaConfidanceButton.setBackgroundImage(UIImage(resource: .sagaConfidanceButton), for: .normal)
        sagaConfidanceButton.contentMode = .scaleAspectFit
        
        atomImageView.image = UIImage(resource: .atom)
        atomImageView.contentMode = .scaleAspectFit
        
        modernScreenImageView.image = UIImage(resource: .modernScreen)
        modernScreenImageView.contentMode = .scaleAspectFill
        
        playSagaButton.setBackgroundImage(UIImage(resource: .playSagaButton), for: .normal)
        playSagaButton.contentMode = .scaleAspectFit
        
        nameSagaImageView.image = UIImage(resource: .sagaName)
        nameSagaImageView.contentMode = .scaleAspectFit
    }
    
    private func screenButtonsTargets() {
        playSagaButton.addTarget(self, action: #selector(startSagaGame), for: .touchUpInside)
        sagaConfidanceButton.addTarget(self, action: #selector(sagaConfidanceRouning), for: .touchUpInside)
    }
    
    
    //MARK: - Buttons API
    @objc private func startSagaGame() {
        buttonsMediaHandler()
        let sagaSparkGame = SagaSparkGameController()
        navigationController?.pushViewController(sagaSparkGame, animated: true)
    }
    
    @objc private func sagaConfidanceRouning() {
        buttonsMediaHandler()
        guard let https  = URL(string: "https://www.youtube.com") else { return }
        let sagaConfidancePage = SFSafariViewController(url: https)
        self.present(sagaConfidancePage, animated: true)
    }
}
