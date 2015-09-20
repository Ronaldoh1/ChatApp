//
//  LoginVC.swift
//  ChatApp
//
//  Created by Ronald Hernandez on 9/20/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

import Parse
import UIKit


class LoginVC: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        //we need to get the width and the height of screen.
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height

        self.usernameTextField.frame = CGRectMake(16, 200, theWidth-32, 30)
        self.passwordTextField.frame = CGRectMake(16, 240, theWidth-32, 30)
        self.loginButton.center = CGPointMake(theWidth/2, 330)
        self.signUpButton.center = CGPointMake(theWidth/2, theHeight-30)

    }

    @IBAction func onLogInButtonTapped(sender: UIButton) {



    }
    
    @IBAction func onSignUpButtonTapped(sender: UIButton) {



    }
}
