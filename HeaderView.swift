//
//  HeaderView.swift
//  HIJU
//
//  Created by 武淅 段 on 16/6/4.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    
    @IBOutlet weak var titleButton: UIButton!
    typealias tapBlock = (view : HeaderView) -> Void
    var tapAction : tapBlock?
    @IBAction func tap(sender: UIButton) {
        if tapAction != nil{
            tapAction!(view: self)
        }
    }

}
