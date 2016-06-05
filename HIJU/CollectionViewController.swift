//
//  CollectionViewController.swift
//  HIJU
//
//  Created by 武淅 段 on 16/6/4.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var tableView: UITableView!
    var artistList = NSMutableArray()
    var db = SQLiteDB.sharedInstance()
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: "ArticalCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: "Cell")
        
        let data = db.query("select * from collection where uid = \(ConstantManager.shareInstance.userID!)")
        
        ConstantManager.shareInstance.collectionArr.removeAllObjects()
        ConstantManager.shareInstance.collectionKeys.removeAllObjects()
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
        
        artistList = ConstantManager.shareInstance.collectionArr
        
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return artistList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArticalCell
        let item = artistList[indexPath.row] as! Item
        cell.contentLabel.text = "\(item.name) \(item.title)"
        cell.favButton.hidden = true
        return cell
    }

    
    
    
    @IBAction func tapBack(sender: UIButton) {

        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
