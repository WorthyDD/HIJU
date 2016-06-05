//
//  ContentViewController.swift
//  HIJU
//
//  Created by 武淅 段 on 16/5/26.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

enum ContentType{
    case Eat
    case Sing
    case Table
    case Play
    case Collection
}



class ContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

   var type  = ContentType.Eat
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var rootArr : NSArray! = ConstantManager.shareInstance.rootArr
    var activity : Activity!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        switch type {
        case .Eat:
            activity = rootArr[0] as! Activity
            titleButton.setTitle(activity.name, forState: UIControlState.Normal)
            break
        case .Sing:
            activity = rootArr[1] as! Activity
            titleButton.setTitle(activity.name, forState: UIControlState.Normal)
            break
        case .Table:
           activity = rootArr[2] as! Activity
           titleButton.setTitle(activity.name, forState: UIControlState.Normal)
            break
        case .Play:
            activity = rootArr[3] as! Activity
            titleButton.setTitle(activity.name, forState: UIControlState.Normal)
            break
        case .Collection:
            titleButton.setTitle("我的收藏", forState: UIControlState.Normal)
            break
        }
        
        let cellNib = UINib(nibName: "ArticalCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: "Cell")
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: "Header")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.reloadData()
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        return activity.items.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let category = activity.items[section] as! Category
        return category.selected ? category.items.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cate = activity.items[indexPath.section] as! Category
        let item = cate.items[indexPath.row] as! Item
        let name = item.name
//        let title = item.title
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArticalCell
        cell.item = item
        cell.contentLabel!.text = "\(name!)"
        if ConstantManager.shareInstance.collectionKeys.containsObject(item.id){
            cell.favButton.selected = true
            item.selected = true
        }
        else{
            cell.favButton.selected = false
            item.selected = false
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cate = activity.items[indexPath.section] as! Category
        let item = cate.items[indexPath.row] as! Item
        if(item.url != nil){
            let url = item.url!
            let webVC = self.storyboard?.instantiateViewControllerWithIdentifier("WebViewController") as! WebViewController
            webVC.urlStr = url
            webVC.titleStr = item.name
            self.presentViewController(webVC, animated: true, completion: nil)
        }
        else if(item.title != nil){
            let detaiVC = self.storyboard?.instantiateViewControllerWithIdentifier("ArticalViewController") as! ArticalViewController
            detaiVC.titleStr = item.name
            detaiVC.imageStr = item.image
            detaiVC.textStr = item.title
            self.presentViewController(detaiVC, animated: true, completion: nil)
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier("Header") as! HeaderView
        let cate = activity.items[section] as! Category
        if(cate.selected){
            view.titleButton.setTitle("  ▼\(cate.name)", forState: UIControlState.Normal)
        }
        else{
            view.titleButton.setTitle("  ▶︎\(cate.name)", forState: UIControlState.Normal)
        }
        view.tapAction = {
            (view : HeaderView) -> () in
                cate.selected = !cate.selected
                print("tap section:\(section)")
                self.tableView.reloadData()
        }
        return view
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    @IBAction func tapBack(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
}
