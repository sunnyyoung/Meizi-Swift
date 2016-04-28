//
//  MeiziRefreshHeader.swift
//  Meizi-Swift
//
//  Created by Sunnyyoung on 16/4/26.
//  Copyright © 2016年 Sunnyyoung. All rights reserved.
//

import UIKit
import MJRefresh

class MeiziRefreshHeader: MJRefreshHeader {
    
    var loadingView: UIActivityIndicatorView?
    var arrowImage: UIImageView?
    
    override func prepare() {
        super.prepare()
        self.mj_h = 50
        
        self.loadingView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        self.addSubview(self.loadingView!)
        
        self.arrowImage = UIImageView(image: UIImage(named: "Arrow"))
        self.addSubview(self.arrowImage!)
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        self.loadingView!.center = CGPointMake(self.mj_w/2, self.mj_h/2);
        self.arrowImage!.frame = CGRectMake(0, 0, 24, 24)
        self.arrowImage!.center = self.loadingView!.center
    }
    
    override func scrollViewContentOffsetDidChange(change: [NSObject : AnyObject]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewContentSizeDidChange(change: [NSObject : AnyObject]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewPanStateDidChange(change: [NSObject : AnyObject]!) {
        super.scrollViewPanStateDidChange(change)
    }
    
    override var state: MJRefreshState {
        didSet {
            switch state {
            case .Idle:
                self.loadingView?.hidden = true
                self.arrowImage?.hidden = false
                self.loadingView?.stopAnimating()
            case .Pulling:
                self.loadingView?.hidden = false
                self.arrowImage?.hidden = true
                self.loadingView?.startAnimating()
                
            case .Refreshing:
                self.loadingView?.hidden = false
                self.arrowImage?.hidden = true
                self.loadingView?.startAnimating()
            default:
                break
            }
        }
    }
}
