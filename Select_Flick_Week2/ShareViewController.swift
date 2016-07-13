//
//  ShareViewController.swift
//  Select_Flick_Week2
//
//  Created by admin on 7/13/16.
//  Copyright © 2016 koyot3. All rights reserved.
//

import UIKit
import Social

class ShareViewController: UIViewController {

    @IBOutlet weak var statusField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let shareBtn = UIBarButtonItem(title: "Share", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(addTapped))
        self.navigationItem.setRightBarButtonItem(shareBtn, animated: true)
    }
    func addTapped(sender:AnyObject){
        if statusField.text != "" {
            let actionSheet = UIAlertController(title: "", message: "Share your Note", preferredStyle: UIAlertControllerStyle.ActionSheet)
            // Configure a new action for sharing the note in Twitter.
            let tweetAction = UIAlertAction(title: "Share on Twitter", style: UIAlertActionStyle.Default) { (action) -> Void in  
                    // Check if sharing to Twitter is possible.
                    if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                        let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                        
                        twitterComposeVC.setInitialText("\(self.statusField.text)")
                        
                        self.presentViewController(twitterComposeVC, animated: true, completion: nil)
                    }
                    else {
                        self.showAlertMessage("You are not logged in to your Twitter account.")
                    }
                
            }
            
            
            // Configure a new action to share on Facebook.
            let facebookPostAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.Default) { (action) -> Void in
                        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                            let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                            
                            facebookComposeVC.setInitialText("\(self.statusField.text)")
                            
                            self.presentViewController(facebookComposeVC, animated: true, completion: nil)
                        }
                        else {
                            self.showAlertMessage("You are not connected to your Facebook account.")
                        }
                }
            
            let dismissAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel) { (action) -> Void in
                
            }
            
            
            actionSheet.addAction(tweetAction)
            actionSheet.addAction(facebookPostAction)
            actionSheet.addAction(dismissAction)
            
            self.presentViewController(actionSheet, animated: true, completion: nil)
        }
    }
    
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: "EasyShare", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
}
