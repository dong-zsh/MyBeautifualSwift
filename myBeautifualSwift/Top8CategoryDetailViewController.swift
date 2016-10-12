//
//  Top8CategoryDetailViewController.swift
//  myBeautifualSwift
//
//  Created by 张东东 on 2016/10/12.
//  Copyright © 2016年 zhangdongdong. All rights reserved.
//

import UIKit

enum Top8CategoryType:Int {
    case product = 0
    case Hot = 1
    case price = 6
}

class Top8CategoryDetailViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    let CELL_INTERVAL:CGFloat = 5.0
    let count:Int = 20
    var cursor:Int = 0
    var dataSourceArray:NSMutableArray?
    
    var keyword:String?
    var method:String?
    var taobao_cid:String?
    var type:Top8CategoryType = .product
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        dataSourceArray = NSMutableArray()
        self.downLoadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataSourceArray?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryDetailCell", for: indexPath) as! CategoryDetailCollectionViewCell
        if (dataSourceArray?.count)! > indexPath.item {
            let model = dataSourceArray?[indexPath.item] as! ProductModel
            cell.imageView.sd_setImage(with: URL(string: model.taobao_pic_url!), placeholderImage: UIImage(named: "assets_placeholder_picture"))
        }
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let arr = [0, 5, 6]
        let idx = indexPath.item % 9
        if arr.contains(idx) {
            return CGSize(width:ScreenWidtn - CELL_INTERVAL * 2, height:ScreenWidtn - CELL_INTERVAL * 2);
        } else {
            return CGSize(width:(ScreenWidtn - CELL_INTERVAL * 4) / 2, height:(ScreenWidtn - CELL_INTERVAL * 4) / 2);
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(CELL_INTERVAL / 2, CELL_INTERVAL, CELL_INTERVAL / 2, CELL_INTERVAL);
    }
    //MARK: - 下载数据
    func downLoadData() {
        var parameters:[String:AnyObject] = [:]
        if keyword != nil {
            parameters["keyword"] = keyword as AnyObject? 
        }
        if method != nil {
            parameters["method"] = method as AnyObject?
        }
        if taobao_cid != nil {
            parameters["taobao_cid"] = taobao_cid as AnyObject?
        }
        switch type {
        case .product:
            parameters["sort"] = "0" as AnyObject?
        case .Hot:
            parameters["sort"] = "1" as AnyObject?
        case .price:
            parameters["sort"] = "6" as AnyObject?
        }
        parameters["count"] = count as AnyObject?
        parameters["cursor"] = cursor as AnyObject?
        
        DownLoadData.getCategoryDetail(parameters) { (array) in
            self.dataSourceArray?.addObjects(from: array as! Array<ProductModel>)
            self.categoryCollectionView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "projectDetailSegerId" {
            let index = categoryCollectionView.indexPath(for: sender as!CategoryDetailCollectionViewCell)
            if (dataSourceArray?.count)! > (index?.item)! {
                let model = dataSourceArray?[(index?.item)!] as! ProductModel
                let destinationViewController = segue.destination as! ProductDetailViewController
                destinationViewController.urlString = model.taobao_url
            }
            
        }
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
