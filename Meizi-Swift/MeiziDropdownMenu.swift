//
//  MeiziDropdownMenu.swift
//  Meizi-Swift
//
//  Created by Sunnyyoung on 16/5/3.
//  Copyright © 2016年 Sunnyyoung. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class MeiziDropdownMenu: BTNavigationDropdownMenu {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(navigationController: UINavigationController?, title: String, items: [AnyObject]) {
        super.init(navigationController: navigationController, title: title, items: items)
        self.cellBackgroundColor = UIColor.whiteColor()
        self.cellSeparatorColor = UIColor.lightGrayColor()
        self.cellTextLabelFont = UIFont.systemFontOfSize(14.0)
        self.cellTextLabelAlignment = .Center
    }
    
}
