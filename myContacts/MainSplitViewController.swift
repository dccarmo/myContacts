//
//  MainSplitViewController.swift
//  myContacts
//
//  Created by Diogo Carmo on 2/9/16.
//  Copyright © 2016 Diogo Carmo. All rights reserved.
//

import UIKit
import RxSwift

class MainSplitViewController: UISplitViewController {
    
    @IBOutlet var sideMenuView: UIView!
    
    private var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.view.insertSubview(self.sideMenuView, atIndex: 0)
        self.sideMenuView.frame = CGRect(x: 0, y: 0, width: 300, height: UIScreen.mainScreen().bounds.size.height)
        
        _ = UIScreen.mainScreen().rx_observe(CGRect.self, "bounds").subscribeNext {
            [weak self] (bounds) -> Void in
            self!.sideMenuView.frame = CGRect(x: 0, y: 0, width: 200, height: bounds!.size.height)
        }
        
        _ = SessionManager.sharedInstance.rx_observe(Bool.self, "loggedIn").skip(1).subscribeNext {
            [weak self] (loggedIn) -> Void in
            if !loggedIn! {
                self!.performSegueWithIdentifier(LogInViewController.leadingSegue, sender: self)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !SessionManager.sharedInstance.loggedIn {
            self.performSegueWithIdentifier(LogInViewController.leadingSegue, sender: self)
        }
    }
    
    func toggleSideMenu() {
        UIView.animateWithDuration(0.3,
            animations: {
                () -> Void in
                for viewController in self.viewControllers {
                    if self.sideMenuOpen {
                        viewController.view.frame.origin.x -= 200
                    } else {
                        viewController.view.frame.origin.x += 200
                    }
                }
                
            }) {
                (finished) -> Void in
                self.sideMenuOpen = !self.sideMenuOpen
        }
    }
    
    @IBAction func logOutButtonAction(sender: AnyObject) {
        self.toggleSideMenu()
        
        if self.viewControllers.count > 1 {
            self.viewControllers.removeLast()
        }
        
        SessionManager.sharedInstance.logOut()
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
