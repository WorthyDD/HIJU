//
//  Item.swift
//  HIJU
//
//  Created by 武淅 段 on 16/6/4.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

class Item: NSObject {

    var name : String!
    var title : String!
    var image : String?
    var id : String!
    var url : String?
    var selected = false
    
    override init() {
        
    }
    init(id : String!, name:String!, title:String!, image:String?, url:String?){
    
        super.init()
        self.id = id
        self.name = name
        self.title = title
        self.image = image
        self.url = url
    }
}
