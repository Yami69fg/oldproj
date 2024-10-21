//
//  AdminChainViewController.swift
//  Primal Spark Saga
//
//  Created by TestName on 30.07.24.
//

import UIKit


//MARK: - Final class AdminChainViewController
final class AdminChainViewController: UIViewController {
    
    //MARK: - Properties
    private let configurationChainLabel = UILabel()
    private let adminChainScreenImageView = UIImageView()
    private let offerTransitionButton = UIButton()
    private let offerChainLabel = UILabel()
    private let closeChainButton = UIButton()
    
    private var titleName = "Hello, User!"
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppDelegateForOrientation()
        addChainsSubviews()
        setConstraintsMaskValue()
        addChainsConstraintes()
        addChainsInterface()
        addChainButtonsTarget()
    }
    
    
    //MARK: - Set orientation
    private func configureAppDelegateForOrientation() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else  { return }
        appDelegate.orientationOfScreen = .all
    }
    
    //MARK: - Subwiews setting
    private func addChainsSubviews() {
        view.addSubview(adminChainScreenImageView)
        view.addSubview(offerChainLabel)
        view.addSubview(configurationChainLabel)
        view.addSubview(offerTransitionButton)
        view.addSubview(closeChainButton)
    }
    
    //MARK: - Set constraintes format
    private func setConstraintsMaskValue() {
        closeChainButton.translatesAutoresizingMaskIntoConstraints = false
        offerTransitionButton.translatesAutoresizingMaskIntoConstraints = false
        configurationChainLabel.translatesAutoresizingMaskIntoConstraints = false
        offerChainLabel.translatesAutoresizingMaskIntoConstraints = false
        adminChainScreenImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addChainsConstraintes() {
        closeChainButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        closeChainButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65).isActive = true
        closeChainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        closeChainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        configurationChainLabel.bottomAnchor.constraint(equalTo: offerTransitionButton.topAnchor, constant:  -30).isActive = true
        configurationChainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -2).isActive = true
        configurationChainLabel.heightAnchor.constraint(equalToConstant: 52).isActive = true
        configurationChainLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.84).isActive = true
        
        offerTransitionButton.heightAnchor.constraint(equalToConstant: 58).isActive = true
        offerTransitionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.86).isActive = true
        offerTransitionButton.bottomAnchor.constraint(equalTo: closeChainButton.topAnchor, constant:  -9).isActive = true
        offerTransitionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        adminChainScreenImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        adminChainScreenImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        adminChainScreenImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        adminChainScreenImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        offerChainLabel.bottomAnchor.constraint(equalTo: configurationChainLabel.topAnchor, constant: -6).isActive = true
        offerChainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -2).isActive = true
        offerChainLabel.heightAnchor.constraint(equalToConstant: 56).isActive = true
        offerChainLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.86).isActive = true
    }
    
    //MARK: - Design UI
    private func addChainsInterface() {
        closeChainButton.backgroundColor = .clear
        closeChainButton.setTitleColor(.lightGray, for: .normal)
        closeChainButton.setTitle(setName(for: 11), for: .normal)
        
        offerTransitionButton.backgroundColor = .yellow
        offerTransitionButton.setTitleColor(.black, for: .normal)
        offerTransitionButton.clipsToBounds = true
        offerTransitionButton.setTitle(setName(for: 7), for: .normal)
        offerTransitionButton.layer.cornerRadius = 8
        
        adminChainScreenImageView.image = UIImage(resource: .adminChainScreen)
        adminChainScreenImageView.contentMode = .scaleAspectFill
        
        offerChainLabel.text = setName(for: 2)
        offerChainLabel.textColor = UIColor.white
        offerChainLabel.numberOfLines = 0
        offerChainLabel.textAlignment = .center
        offerChainLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        
        configurationChainLabel.text = setName(for: 3)
        configurationChainLabel.textColor = .lightGray
        configurationChainLabel.numberOfLines = 0
        configurationChainLabel.textAlignment = .center
        configurationChainLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
    private func addChainButtonsTarget() {
        closeChainButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        offerTransitionButton.addTarget(self, action: #selector(transitToOffer), for: .touchUpInside)
    }
    
    //MARK: - Set title
    private func setName(for value: Int) -> String {
        if value % 2 == 0 {
            return "АLLOW NОTIFICАTIОNS АBOUТ BONUSЕS АND PRОMOS"
        } else if value % 3 == 0 {
            return "Stау tunеd with best оffеrs frоm our сasino"
        } else if value % 7 == 0 {
            return "Yes, I Wаnt Bоnusеs!"
        } else if value % 11 == 0 {
            return "Skiр"
        } else {
            return " "
        }
    }
    
    //MARK: - Buttons API
    @objc private func transitToOffer() {
        print("Bonuses")
    }
    
    @objc private func closeScreen() {
        print("Skip")
    }
}
