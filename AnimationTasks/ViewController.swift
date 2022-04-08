//
//  ViewController.swift
//  AnimationTasks
//
//  Created by Danil Gerasimov on 08.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    
    var animator: UIViewPropertyAnimator!

    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        animator = UIViewPropertyAnimator(duration: 1.5, curve: .linear, animations: {
            self.colorView.layer.backgroundColor = UIColor.systemBrown.cgColor
            self.view.layer.backgroundColor = UIColor.systemMint.cgColor
            self.colorView.transform = .init(scaleX: 2.5, y: 2.5)
            self.colorView.layer.cornerRadius = 32
        })
    }
    
    @IBAction func sliderDidChange(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        animator.stopAnimation(true)
        dismiss(animated: true)
    }
    
}

