//
//  PushSagaViewController.swift
//  Primal Spark Saga
//
//  Created by TestName on 30.07.24.
//

import UIKit

//MARK: - Final class PushSagaViewController
final class PushSagaViewController: UIViewController {
    
    //MARK: - Properties
    internal let atomImageView = UIImageView()
    internal let pusherImageView = UIImageView()
    internal let ellipsoideImageView = UIImageView()
    internal let pushSagaScreenImageView = UIImageView()
    
    internal var isActionAccess: Bool = true
    
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addPusherScreensSubviews()
        setConstraintsMaskValue()
        addPusherScreensConstraintes()
        addPusherScreensInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAction(for: 6.0)
    }
    
    
    //MARK: - Subwiews setting
    private func addPusherScreensSubviews() {
        view.addSubview(pushSagaScreenImageView)
        view.addSubview(atomImageView)
        view.addSubview(pusherImageView)
        view.addSubview(ellipsoideImageView)
    }
    
    private func setConstraintsMaskValue() {
        atomImageView.translatesAutoresizingMaskIntoConstraints = false
        ellipsoideImageView.translatesAutoresizingMaskIntoConstraints = false
        pusherImageView.translatesAutoresizingMaskIntoConstraints = false
        pushSagaScreenImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addPusherScreensConstraintes() {
        atomImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (view.frame.height * 0.25)).isActive = true
        atomImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        atomImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        atomImageView.heightAnchor.constraint(equalTo: atomImageView.widthAnchor).isActive = true
        
        ellipsoideImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        ellipsoideImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        ellipsoideImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        ellipsoideImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        pusherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pusherImageView.topAnchor.constraint(equalTo: atomImageView.bottomAnchor, constant: -25).isActive = true
        pusherImageView.heightAnchor.constraint(equalTo: atomImageView.heightAnchor, multiplier: 0.32).isActive = true
        pusherImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.64).isActive = true
        
        pushSagaScreenImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        pushSagaScreenImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pushSagaScreenImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pushSagaScreenImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func addPusherScreensInterface() {
        atomImageView.image = UIImage(resource: .atom)
        atomImageView.contentMode = .scaleAspectFit
        
        ellipsoideImageView.image = UIImage(resource: .ellipsoide)
        ellipsoideImageView.contentMode = .scaleAspectFit
        
        pusherImageView.image = UIImage(resource: .sagaPusher)
        pusherImageView.contentMode = .scaleAspectFit
        
        pushSagaScreenImageView.image = UIImage(resource: .modernScreen)
        pushSagaScreenImageView.contentMode = .scaleAspectFill
    }
    
    private func hideSubviews() {
        atomImageView.alpha = 0
        ellipsoideImageView.alpha = 0
        pusherImageView.alpha = 0
    }
}
