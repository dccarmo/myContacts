//
//  LogInViewController.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    let viewModel = LogInViewModel()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func logInButtonAction(sender: AnyObject) {
        
        // Simulation of a log in flow
        
        _ = self.viewModel.logInWithEmail(self.emailTextField.text!, password: self.passwordTextField.text!).subscribeNext {
            [weak self] (loggedIn) -> Void in
            if loggedIn {
                self!.performSegueWithIdentifier("unwindSegue", sender: self)
            }
        }
    }

}
