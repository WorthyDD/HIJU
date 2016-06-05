//
//  Activity.swift
//  HIJU
//
//  Created by 武淅 段 on 16/6/4.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

class Activity: NSObject {

    var name : String!
    var items : NSArray!
    
    override init() {
        
    }
    init(name:String, items:NSArray){
        super.init()
        self.name = name
        self.items = items
    }
}
