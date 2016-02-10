//
//  MainSplitViewController.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import UIKit

class MainSplitViewController: UISplitViewController {
    
    @IBOutlet var sideMenuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.view.insertSubview(self.sideMenuView, atIndex: 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !SessionManager.sharedInstance.loggedIn {
            self.performSegueWithIdentifier(LogInViewController.leadingSegue, sender: self)
        }
    }
    
    func toggleSideMenu() {
        UIView.animateWithDuration(0.3) {
            () -> Void in
            for viewController in self.viewControllers {
                viewController.view.frame.origin.x += 100
            }
        }
    }
    
    @IBAction func unwindToMainSplitViewController(segue: UIStoryboardSegue) {
        
    }
    
}

extension MainSplitViewController: UISplitViewControllerDelegate {
    
    func splitViewController(splitViewController: UISplitViewController,
        collapseSecondaryViewController secondaryViewController: UIViewController,
        ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}
