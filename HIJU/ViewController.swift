//
//  ViewController.swift
//  HIJU
//
//  Created by 武淅 段 on 16/5/24.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

let kUserIDStore = "user_id_store"
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        self.checkLogin()
    
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.checkLogin()
    }

    @IBAction func didTapEatButton(sender: UIButton) {
        
        let contentVC  = self.storyboard?.instantiateViewControllerWithIdentifier("contentVC") as! ContentViewController
        contentVC.type = ContentType.Eat
        self.presentViewController(contentVC, animated: true, completion: nil)
    }

    @IBAction func didTapSingButton(sender: UIButton) {
        let contentVC  = self.storyboard?.instantiateViewControllerWithIdentifier("contentVC") as! ContentViewController
        contentVC.type = ContentType.Sing
        self.presentViewController(contentVC, animated: true, completion: nil)
    }
    
    @IBAction func didTapTableButton(sender: UIButton) {
        let contentVC  = self.storyboard?.instantiateViewControllerWithIdentifier("contentVC") as! ContentViewController
        contentVC.type = ContentType.Table
        self.presentViewController(contentVC, animated: true, completion: nil)
    }
    
    @IBAction func didTapPlayButton(sender: UIButton) {
        let contentVC  = self.storyboard?.instantiateViewControllerWithIdentifier("contentVC") as! ContentViewController
        contentVC.type = ContentType.Play
        self.presentViewController(contentVC, animated: true, completion: nil)
    }
    
    @IBAction func didTapMyCollectionButton(sender: UIButton) {
        
        let contentVC  = self.storyboard?.instantiateViewControllerWithIdentifier("contentVC") as! ContentViewController
        contentVC.type = ContentType.Collection
        self.presentViewController(contentVC, animated: true, completion: nil)
    }
    
    func checkLogin() {
        if NSUserDefaults.standardUserDefaults().objectForKey(kUserIDStore) != nil{
            print("已登录")
        }
        else{
            
            let vc = (self.storyboard?.instantiateViewControllerWithIdentifier("loginVC"))! as! LoginViewController
            self .presentViewController(vc, animated: true, completion: nil)
        }
    }
}

