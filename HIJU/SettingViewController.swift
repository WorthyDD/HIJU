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
    
    @IBOutlet weak var clearCacheView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var helpView: UIView!
    
    var isLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.didTapClearCacheView))
        clearCacheView.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.didTapAboutView))
        aboutView.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.didTapHelpView))
        aboutView.addGestureRecognizer(tap3)

        
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
    
    
    func didTapClearCacheView(){
        CustomToast.showHudToastWithString("已为您清理缓存~")
    }
    
    func didTapAboutView(){
        
    }
    
    func didTapHelpView(){
        
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
