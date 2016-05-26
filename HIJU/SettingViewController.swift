//
//  SettingViewController.swift
//  HIJU
//
//  Created by 武淅 段 on 16/5/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

let kUserStatusChangeNotification = "user_status_did_change"
class SettingViewController: UIViewController {

    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    var isLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshLoginState()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(SettingViewController.didReciveUserChangeNotification(_:)), name: kUserStatusChangeNotification, object: nil)
    }

    
    func refreshLoginState(){
        let userID = NSUserDefaults.standardUserDefaults().objectForKey(kUserIDStore) as? String
        isLogin = userID != nil
        if(isLogin){
            userIDLabel.text = "\(userID!) (已登录)"
            loginButton.setTitle("退出", forState: UIControlState.Normal)
        }
        else{
            userIDLabel.text = "您还未登录, 请登录或者注册"
            loginButton.setTitle("登录", forState: UIControlState.Normal)
        }

    }

    
    @IBAction func didTapBack(sender: UIButton) {
        self .dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didTapLoginButton(sender: UIButton) {
        
        if(!isLogin){
            let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("loginVC") as! LoginViewController
            self .presentViewController(loginVC, animated: true, completion: nil)
        }
        else{
            NSUserDefaults.standardUserDefaults().removeObjectForKey(kUserIDStore)
            CustomToast.showHudToastWithString("已退出")
            self.refreshLoginState()
        }
    }
   
    func didReciveUserChangeNotification(notification : NSNotification){
        self.refreshLoginState()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
