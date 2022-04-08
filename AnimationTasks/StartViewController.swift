//
//  StartViewController.swift
//  AnimationTasks
//
//  Created by Danil Gerasimov on 08.04.2022.
//

import UIKit

final class StartViewController: UIViewController {
    
    @IBOutlet weak var transitionView: UIView!
    @IBOutlet weak var transitionViewLabel: UILabel!
    
    var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(transitionViewTapped))
        
        transitionView.addGestureRecognizer(tapGesture)
    }
    
    @objc func transitionViewTapped() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
    }
}

extension StartViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let startViewController = presenting as? StartViewController,
              let viewController = presented as? ViewController else {
                  return nil
              }
        
        return AnimatedTransitioning(startViewController: startViewController, viewController: viewController)
    }
}

final class AnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    private let startViewController: UIViewController
    private let viewController: UIViewController
    
    init(startViewController: UIViewController, viewController: UIViewController) {
        
        self.startViewController = startViewController
        self.viewController = viewController
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard let colorView = viewController.view else {
            transitionContext.completeTransition(false)
            return
        }
        
        guard let startViewController = startViewController as? StartViewController else {
                  transitionContext.completeTransition(false)
                  return
              }
        
        colorView.alpha = 0
        containerView.addSubview(colorView)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeCubic) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0) {
                startViewController.transitionViewLabel.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 2) {
                startViewController.transitionView.transform = CGAffineTransform(scaleX: startViewController.view.center.x, y: startViewController.view.center.y)
                colorView.alpha = 1
            }
            
        } completion: { _ in
            transitionContext.completeTransition(true)
            startViewController.transitionView.transform = .identity
            startViewController.transitionViewLabel.alpha = 1
            
            return
        }
    }
}
