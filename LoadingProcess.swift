//
//  LoadingProcess.swift
//  Primal Spark Saga
//
//  Created by TestName on 30.07.24.
//

import UIKit

//MARK: - Setup animations
extension PushSagaViewController {
    
    //MARK: - Move to next view controller
    internal func startAction(for time: CGFloat) {
        ellipseAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.isActionAccess = false
            self.atomImageView.layer.removeAllAnimations()
            self.pusherImageView.layer.removeAllAnimations()
            let ditributionPointScreen = DistributionPointViewController()
            self.navigationController?.pushViewController(ditributionPointScreen, animated: true)
        }
    }
    
    
    //MARK: - Action
    private func ellipseAnimation() {
        ellipsoideImageView.transform = CGAffineTransform(scaleX: 0, y: 1)
        UIView.animate(withDuration: 1.5, delay: 0) {
            self.pushSagaScreenImageView.alpha = 0.5
            self.ellipsoideImageView.alpha = 1
            self.ellipsoideImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        } completion: { _ in
            self.atomAnimation()
            self.pusherAnimation()
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.ellipsoideImageView.alpha = 0
                self.pushSagaScreenImageView.alpha = 1
            }
        }
    }
    
    private func atomAnimation() {
        atomImageView.alpha = 1
        let atomRotation = CABasicAnimation(keyPath: "transform.rotation")
        atomRotation.fromValue = 0
        atomRotation.toValue = Double.pi * 2
        atomRotation.duration = 10
        atomRotation.repeatCount = .infinity
        atomImageView.layer.add(atomRotation, forKey: "atomRotation")
    }
    
    private func pusherAnimation() {
        guard isActionAccess else { return }
        pusherImageView.alpha = 0.2
        UIView.animate(withDuration: 0.2, delay: 0.3) {
            self.pusherImageView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.pusherImageView.alpha = 0.6
        } completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0) {
                self.pusherImageView.alpha = 0.2
            } completion: { _ in
                UIView.animate(withDuration: 0.2, delay: 0) {
                    self.pusherImageView.alpha = 1
                } completion: { _ in
                    UIView.animate(withDuration: 0.7, delay: 0.3) {
                        self.pusherImageView.alpha = 0.2
                        self.pusherImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    } completion: { _ in
                        self.pusherAnimation()
                    }
                }
            }
        }
    }
}
