//
//  LoginViewController.swift
//  HIJU
//
//  Created by 武淅 段 on 16/5/24.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    var db: SQLiteDB!
    override func viewDidLoad() {
        super.viewDidLoad()

        db = SQLiteDB.sharedInstance()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didTapBackButton(sender: UIButton) {
        
        let data = db.query("select * from user")
        for var user in data{
            let userID = user["user_id"]!
            let password = user["password"]!
            print("\(userID),\(password)")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func didTapLogin(sender: UIButton) {
        
        if (userIDTextField.text?.characters.count <= 0 || passwordTextfield.text?.characters.count <= 0) {
            CustomToast.showHudToastWithString("帐号不能为空!")
            return
        }
        let userID = userIDTextField.text!
        let data = db.query("select * from user where user_id ='\(userID)'")
        if(data.count==0){
            CustomToast .showHudToastWithString("没有此用户, 请注册")
            userIDTextField.text = ""
            return
        }
        let row = data[0]
        if row["user_id"] != nil{
            let password = row["password"]!
            if password.isEqual(passwordTextfield.text){
                //登录成功
                print("login success!")
                CustomToast.showHudToastWithString("登录成功!")
                ConstantManager.shareInstance.userID = userID
                NSUserDefaults.standardUserDefaults().setObject(userID, forKey: kUserIDStore)
                NSNotificationCenter.defaultCenter().postNotificationName(kUserStatusChangeNotification, object: nil)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else{
                CustomToast.showHudToastWithString("密码错误")
                userIDTextField.text = ""
                passwordTextfield.text = ""
            }
        }
        
    }
    
    @IBAction func didTapRegister(sender: UIButton) {
        
        let alertVC = UIAlertController(title: "注册", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alertVC.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "请输入帐号(纯数字)"
            textField.keyboardType = .EmailAddress
        }
        alertVC.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "请输入密码"
            textField.secureTextEntry = true
        }
        alertVC.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "请确认密码"
            textField.secureTextEntry = true
        }
        let done = UIAlertAction(title: "注册", style: UIAlertActionStyle.Default) { (done) in
            
            let field1 = alertVC.textFields![0]
            let field2 = alertVC.textFields![1]
            let field3 = alertVC.textFields![2]
            let userID = field1.text!
            let password = field2.text!
            let confirmPassword = field3.text!
            if(userID.characters.count == 0 || password.characters.count == 0 || confirmPassword.characters.count == 0){
                CustomToast.showHudToastWithString("帐号或密码不能为空")
            }
            else if(password != confirmPassword){
                CustomToast.showHudToastWithString("密码不匹配,请重新输入!")
                field1.text = ""
                field2.text = ""
                field3.text = ""
            }
            else{
                self.db.execute("insert into user(user_id, password) values('\(userID)','\(password)')")
                CustomToast.showHudToastWithString("注册成功, 请登录!")
                self.userIDTextField.text = ""
                self.passwordTextfield.text = ""
            }
            
            
        }
        alertVC.addAction(done)
        self.presentViewController(alertVC, animated: true, completion: nil)
    }


}
