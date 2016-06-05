//
//  ArticalCell.swift
//  HIJU
//
//  Created by 武淅 段 on 16/6/4.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

class ArticalCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    var item : Item!
    var db : SQLiteDB!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        db = SQLiteDB.sharedInstance()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapFav(sender: UIButton) {
        
        
        let userID = ConstantManager.shareInstance.userID
        if !item.selected{
            dispatch_async(dispatch_get_main_queue(), {
                self.db.execute("insert into collection(uid, artistid) values('\(userID!)','\(self.item.id)')")
                CustomToast.showHudToastWithString("收藏成功!")
            });
            
        }
        else{
            dispatch_async(dispatch_get_main_queue(), {
                self.db.execute("delete from collection where artistid =  '\(self.item.id)'")
                CustomToast.showHudToastWithString("已取消收藏!")
            });
           

        }
        sender.selected = !sender.selected
        item.selected = !item.selected
    }
    
    
}
