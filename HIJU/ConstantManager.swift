//
//  ConstantManager.swift
//  HIJU
//
//  Created by 武淅 段 on 16/6/4.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

class ConstantManager: NSObject {

    static let shareInstance = ConstantManager()
    
    var rootArr = NSMutableArray()  //保存所有的数据
    var articalList = NSMutableArray()  //所有的文章列表
    var collectionArr = NSMutableArray()    //收藏列表
    var collectionKeys = NSMutableArray()   //收藏列表的id 方便查询
    var userID : String?

    private override init() {
        
        userID = NSUserDefaults.standardUserDefaults().objectForKey(kUserIDStore) as? String
        let path:String! = NSBundle.mainBundle().pathForResource("artical", ofType: "plist")
        let arr = NSArray(contentsOfFile: path)!
        for i in 0 ..< arr.count{
            
            let dic = arr[i]
            let name = dic.objectForKey("name") as! String
            let items = dic.objectForKey("items") as! NSArray
            let itemsArr = NSMutableArray()
            for j in 0..<items.count{
                let subDic = items[j]
                let cateName = subDic.objectForKey("name") as! String
                let cateItems = subDic.objectForKey("items") as! NSArray
                let categoryArr = NSMutableArray()
                for k in 0..<cateItems.count{
                    let itemsDic = cateItems[k]
                    let itemName = itemsDic.objectForKey("name") as! String
                    let title = itemsDic.objectForKey("title") as! String
                    let image = itemsDic.objectForKey("image") as? String
                    let url = itemsDic.objectForKey("url") as? String
                    let id = itemsDic.objectForKey("id") as! String
                    let item = Item(id : id, name: itemName,title: title,image: image, url: url)
                    categoryArr.addObject(item)
                    articalList.addObject(item)
                }
                let category = Category(name: cateName, items: categoryArr)
                
                itemsArr.addObject(category)
            }
            let activity = Activity(name: name, items: itemsArr)
            rootArr.addObject(activity)
        }
        
    }
}
