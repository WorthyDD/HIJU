//
//  ArticalViewController.swift
//  HIJU
//
//  Created by 武淅 段 on 16/6/5.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

class ArticalViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageVC: UIImageView!

    @IBOutlet weak var textLabel: UILabel!
    
    // 图片的高度约束 如果没有图片高度为0  隐藏
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    var titleStr : String!      //标题
    var imageStr : String?      //图片
    var textStr : String!   //内容
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(imageStr == nil){
            imageHeight.constant = 0
            imageVC.hidden = true
        }
        else{
            imageVC.image = UIImage(named: imageStr!)
        }
        titleLabel.text = titleStr
        textLabel.text = textStr
    }

   
    @IBAction func tapBack(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
