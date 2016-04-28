//
//  MeiziCell.swift
//  Meizi-Swift
//
//  Created by Sunnyyoung on 16/4/26.
//  Copyright © 2016年 Sunnyyoung. All rights reserved.
//

import UIKit
import Kingfisher

class MeiziCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var meizi: Meizi? {
        didSet {
            let url = NSURL(string: meizi!.src!)
            imageView.kf_setImageWithURL(url!)
        }
    }
}
