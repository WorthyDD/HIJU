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

    
    var db = SQLiteDB.sharedInstance()
    
    var fist = false
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
        
        let contentVC  = self.storyboard?.instantiateViewControllerWithIdentifier("collectionVC") as! CollectionViewController
        self.presentViewController(contentVC, animated: true, completion: nil)
    }
    
    func checkLogin() {
        if NSUserDefaults.standardUserDefaults().objectForKey(kUserIDStore) != nil{
            print("已登录")
            
            if !fist{
                let data = db.query("select * from collection where uid = \(ConstantManager.shareInstance.userID!)")
                for var collection in data{
                    
                    let uid = collection["uid"]!
                    let artistid = collection["artistid"] as! String
                    print("\(uid),\(artistid)")
                    for i in 0..<ConstantManager.shareInstance.articalList.count{
                        let item = ConstantManager.shareInstance.articalList[i] as! Item
                        if item.id == artistid{
                            ConstantManager.shareInstance.collectionArr.addObject(item)
                            ConstantManager.shareInstance.collectionKeys.addObject(artistid)
                        }
                    }
                }
                
                fist = true
                
            }

        }
        else{
            
            let vc = (self.storyboard?.instantiateViewControllerWithIdentifier("loginVC"))! as! LoginViewController
            self .presentViewController(vc, animated: true, completion: nil)
        }
    }
}

