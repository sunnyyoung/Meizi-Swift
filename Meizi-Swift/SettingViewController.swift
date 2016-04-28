//
//  SettingViewController.swift
//  Meizi-Swift
//
//  Created by GeekBean on 16/4/28.
//  Copyright © 2016年 Sunnyyoung. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD

class SettingViewController: UITableViewController {
    @IBOutlet weak var cacheSizeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshCacheSizeLabel()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cache = KingfisherManager.sharedManager.cache
        cache.clearDiskCacheWithCompletionHandler { 
            self.refreshCacheSizeLabel()
            HUD.flash(.Success, delay: 1.2)
        }
    }
    
    func refreshCacheSizeLabel() -> Void {
        let cache = KingfisherManager.sharedManager.cache
        cache.calculateDiskCacheSizeWithCompletionHandler { (size) -> () in
            self.cacheSizeLabel.text = String(format: "%.2f MB", Float(size)/1024.0/1024.0)
        }
    }

}
