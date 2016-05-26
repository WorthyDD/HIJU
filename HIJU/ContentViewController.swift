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
}



class ContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

   var type  = ContentType.Eat
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch type {
        case .Eat:
            titleButton.setTitle("EAT吃什么", forState: UIControlState.Normal)
            break
        case .Sing:
            titleButton.setTitle("Sing唱什么", forState: UIControlState.Normal)
            break
        case .Table:
            titleButton.setTitle("Table", forState: UIControlState.Normal)
            break
        case .Play:
            titleButton.setTitle("Play", forState: UIControlState.Normal)
            break
        }
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        return cell
    }

    @IBAction func tapBack(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
}
