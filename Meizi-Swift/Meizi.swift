//
//  Meizi.swift
//  Meizi-Swift
//
//  Created by Sunnyyoung on 16/4/26.
//  Copyright © 2016年 Sunnyyoung. All rights reserved.
//

import UIKit

class Meizi: NSObject {
    var title: String?
    var src: String?
    var largeSrc: String? {
        get {
            if ((src?.containsString("bmiddle")) != nil) {
                return src?.stringByReplacingOccurrencesOfString("bmiddle", withString: "large")
            } else {
                return src
            }
        }
    }
    
}
