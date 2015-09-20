//
//  ViewController.swift
//  weLink
//
//  Created by Jason Du on 2015-09-19.
//  Copyright (c) 2015 Jason Du. All rights reserved.
//
var userName:NSString = "no"

import UIKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(p: Bool) {
        super.viewDidAppear(true)
        
        
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            self.performSegueWithIdentifier("showChat",sender:self)
            println("HI")
            transition()

        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
        
    }
    func transition(){
        self.performSegueWithIdentifier("showChat",sender:self)

    }
    
    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            //            if result.grantedPermissions.contains("email")
            //            {
            //                // Do work
            //            }
            self.returnUserData()
            self.performSegueWithIdentifier("showChat",sender:self)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }
    
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                println("fetched user: \(result)")
                let useName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(useName)")
                userName = useName
                //let userEmail : NSString = result.valueForKey("email") as! NSString
                //println("User Email is: \(userEmail)")
                
            }
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
