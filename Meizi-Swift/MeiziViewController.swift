//
//  MeiziViewController.swift
//  Meizi-Swift
//
//  Created by Sunnyyoung on 16/4/26.
//  Copyright © 2016年 Sunnyyoung. All rights reserved.
//

import UIKit
import SKPhotoBrowser
import Alamofire
import Ji
import MJRefresh
import MJExtension

enum MeiziType: Int {
    case All     = 0
    case DaXiong = 2
    case QiaoTun = 6
    case HeiSi   = 7
    case MeiTui  = 3
    case QingXin = 4
    case ZaHui   = 5
}

class MeiziViewController: UICollectionViewController {
    var page: Int = 1
    var type: MeiziType = .All
    var meiziArray: Array<Meizi>? = [Meizi]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.mj_header = MeiziRefreshHeader(refreshingBlock: {[weak self] () -> Void in
            self?.reloadMeizi()
            })
        self.collectionView?.mj_footer = MeiziRefreshFooter(refreshingBlock: {[weak self] () -> Void in
            self?.loadMoreMeizi()
            })
        self.collectionView?.mj_header.beginRefreshing()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let array = self.meiziArray {
            return array.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let perLine: Int = UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation) ? 3:5
        let width: Int = Int(CGRectGetWidth(UIScreen.mainScreen().bounds)) / perLine - 1
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let meiziCell = collectionView.dequeueReusableCellWithReuseIdentifier("MeiziCell", forIndexPath: indexPath) as! MeiziCell
        meiziCell.meizi = meiziArray![indexPath.item]
        return meiziCell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meiziCell = collectionView.cellForItemAtIndexPath(indexPath) as! MeiziCell
        var photoArray = [SKPhoto]()
        for meizi in meiziArray! {
            let photo = SKPhoto.photoWithImageURL(meizi.largeSrc!)
            photoArray.append(photo)
        }
        let photoBrowser = SKPhotoBrowser(originImage: meiziCell.imageView.image!, photos: photoArray, animatedFromView: meiziCell)
        photoBrowser.initializePageIndex(indexPath.item)
        presentViewController(photoBrowser, animated: true, completion: nil)
    }
    
    func reloadMeizi() -> Void {
        self.meiziArray?.removeAll()
        Alamofire.request(.GET, String(format: "http://www.dbmeinv.com/dbgroup/show.htm?cid=%@&pager_offset=%@", String(type.rawValue), String(1))).responseString { (response) in
            let jiDocument = Ji(htmlString: response.result.value!)
            
            let liElementArray = jiDocument?.xPath("//*[@id=\"main\"]/div[2]/div[2]/ul/li")
            for liElement in liElementArray! {
                let elementDocument = Ji(htmlString: liElement.rawContent!)
                let imgElement = elementDocument?.xPath("//div/div[1]/a/img")?.first
                let meizi = Meizi.mj_objectWithKeyValues(imgElement?.attributes)
                self.meiziArray!.append(meizi)
            }
            self.page = 1
            self.collectionView?.reloadData()
            self.collectionView?.mj_header.endRefreshing()
        }
    }
    
    func loadMoreMeizi() -> Void {
        Alamofire.request(.GET, String(format: "http://www.dbmeinv.com/dbgroup/show.htm?cid=%@&pager_offset=%@", String(type.rawValue), String(page+1))).responseString { (response) in
            let jiDocument = Ji(htmlString: response.result.value!)
            let liElementArray = jiDocument?.xPath("//*[@id=\"main\"]/div[2]/div[2]/ul/li")
            for liElement in liElementArray! {
                let elementDocument = Ji(htmlString: liElement.rawContent!)
                let imgElement = elementDocument?.xPath("//div/div[1]/a/img")?.first
                let meizi = Meizi.mj_objectWithKeyValues(imgElement?.attributes)
                self.meiziArray!.append(meizi)
            }
            self.page += 1
            self.collectionView?.reloadData()
            self.collectionView?.mj_footer.endRefreshing()
        }
    }
    
    override var navigationItem: UINavigationItem {
        get {
            let navigationItem = super.navigationItem
            if navigationItem.titleView == nil {
                let items = ["全部", "大胸", "翘臀", "黑丝", "美腿", "清新", "杂烩"]
                let menuView = MeiziDropdownMenu(navigationController: self.navigationController, title: items.first!, items: items)
                menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
                    switch indexPath {
                    case 0:
                        self?.type = .All
                        break
                    case 1:
                        self?.type = .DaXiong
                        break
                    case 2:
                        self?.type = .QiaoTun
                        break
                    case 3:
                        self?.type = .HeiSi
                        break
                    case 4:
                        self?.type = .MeiTui
                        break
                    case 5:
                        self?.type = .QingXin
                        break
                    case 6:
                        self?.type = .ZaHui
                        break
                    default:
                        self?.type = .All
                        break
                    }
                    self?.collectionView?.mj_header.beginRefreshing()
                }
                navigationItem.titleView = menuView
            }
            return navigationItem
        }
    }
    
}
