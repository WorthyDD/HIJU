//
//  Category.swift
//  HIJU
//
//  Created by 武淅 段 on 16/6/4.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

class Category: NSObject {

    var name : String!
    var items : NSArray!
    var selected = false        //是否被选中
    override init() {
        
    }
    
    init(name : String!, items: NSArray!) {
        self.name = name
        self.items = items
    }
}
