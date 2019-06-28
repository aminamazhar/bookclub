//
//  ViewController.swift
//  Bookclub
//
//  Created by Amina Mazhar on 6/5/19.
//  Copyright © 2019 Amina Mazhar. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController {

    @IBOutlet weak var bookclub: UILabel!
    @IBOutlet weak var subview: UIView!
    
    @IBAction func login(_ sender: UIButton) {
        let authUI = FUIAuth.defaultAuthUI()
        guard authUI != nil else {return}
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        let authVC = authUI!.authViewController()
        present(authVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "main", sender: self)
            } 
        }
        
        super.viewDidLoad()
        let customFont = UIFont(name: "HARRYP", size: 40)
        bookclub.font = customFont
        //bookclub.font = bookclub.font.withSize(40)
        let gradient = CAGradientLayer(start: .topCenter, end: .bottomCenter, colors: [UIColor.cyan.cgColor, UIColor.white.cgColor], type: .axial)
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        subview.backgroundColor = UIColor.clear
        view.bringSubviewToFront(subview)
    }

}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            return
        }
        performSegue(withIdentifier: "main", sender: self)
    }
}

extension CAGradientLayer {
    
    enum Point {
        case topLeft
        case centerLeft
        case bottomLeft
        case topCenter
        case center
        case bottomCenter
        case topRight
        case centerRight
        case bottomRight
        
        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .centerLeft:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeft:
                return CGPoint(x: 0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottomCenter:
                return CGPoint(x: 0.5, y: 1.0)
            case .topRight:
                return CGPoint(x: 1.0, y: 0.0)
            case .centerRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    
    convenience init(start: Point, end: Point, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}
