//
//  ReviewViewController.swift
//  RecetasCompleto
//
//  Created by Jorge MR on 03/07/17.
//  Copyright © 2017 Jorge MR. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    //Variables
    var ratingSelected : String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEfect = UIBlurEffect(style: .regular)
        let blurEfectView = UIVisualEffectView(effect: blurEfect)
        blurEfectView.frame = view.bounds
        backgroundImageView.addSubview(blurEfectView)

    
        ratingStackView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: { 
            self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        */
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { 
            self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calificarReceta(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            ratingSelected = "dislike"
            break
        case 2:
            ratingSelected = "good"
            break
        case 3:
            ratingSelected = "great"
            break
        default:
            break
        }
        
        performSegue(withIdentifier: "exitSegue", sender: sender)
        
    }
    
    
    override var prefersStatusBarHidden: Bool{return true}
}













