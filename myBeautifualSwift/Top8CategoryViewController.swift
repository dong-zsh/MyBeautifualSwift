//
//  Top8CategoryViewController.swift
//  myBeautifualSwift
//
//  Created by 张东东 on 2016/10/11.
//  Copyright © 2016年 zhangdongdong. All rights reserved.
//

import UIKit

class Top8CategoryViewController: BasePageViewController {

    @IBOutlet weak var segmentControl: ZZSegmentControl!
    
    var keyWord:String?
    var method:String?
    var tabbao_cid:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSubViews()
    }
    
    func setUpSubViews() {
        self.title = keyWord
        segmentControl.setupSubviews(items: ["新品","热销","价格"], itemsImageName: ["yuike_itemgroup_arrow_gray", "yuike_itemgroup_arrow2_gray", "yuike_itemgroup_arrow2_gray"], itemsSelectedImageName: ["yuike_itemgroup_arrow_black", "yuike_itemgroup_arrow2_blackdown", "yuike_itemgroup_arrow2_blackup"]) { (index) in
            self.scrollToViewcontroler(index: index, anmation: true)
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newProductViewController = storyBoard.instantiateViewController(withIdentifier: "CategoryDetailId") as! Top8CategoryDetailViewController
        newProductViewController.keyword = keyWord
        newProductViewController.method = method
        newProductViewController.type = .product
        newProductViewController.taobao_cid = tabbao_cid
        let HotViewController = storyBoard.instantiateViewController(withIdentifier: "CategoryDetailId") as! Top8CategoryDetailViewController
        HotViewController.keyword = keyWord
        HotViewController.method = method
        HotViewController.type = .Hot
        HotViewController.taobao_cid = tabbao_cid
        let priceViewController = storyBoard.instantiateViewController(withIdentifier: "CategoryDetailId") as! Top8CategoryDetailViewController
        priceViewController.keyword = keyWord
        priceViewController.method = method
        priceViewController.type = .price
        priceViewController.taobao_cid = tabbao_cid
        self.SetUpPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.scroll, frame: CGRect.zero, array: [newProductViewController,HotViewController,priceViewController], willBeginDragging: {
            //开始拖拽视图
            self.segmentControl.isUserInteractionEnabled = false
            }, endDecelerating: { 
            //减速停止
                self.segmentControl.isUserInteractionEnabled = true
            }) { (index) in
                self.segmentControl.swiftSetSelectedIndex(index:index)
        }
        //自动布局
        let pageViewControllerView = self.pageViewController?.view
        pageViewControllerView?.translatesAutoresizingMaskIntoConstraints = false
        let topLayoutConstraint = NSLayoutConstraint(item: pageViewControllerView!, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.segmentControl, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
        let bottomLayoutContraint = NSLayoutConstraint(item: pageViewControllerView!, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
        let leftLayoutConstraint = NSLayoutConstraint(item: pageViewControllerView!, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0.0)
        let rightLayoutContraint = NSLayoutConstraint(item: pageViewControllerView!, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([topLayoutConstraint, bottomLayoutContraint, leftLayoutConstraint, rightLayoutContraint])
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
