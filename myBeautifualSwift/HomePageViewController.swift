//
//  HomePageViewController.swift
//  myBeautifualSwift
//
//  Created by 张东东 on 16/9/21.
//  Copyright © 2016年 zhangdongdong. All rights reserved.
//

import UIKit

class HomePageViewController: BaseViewController ,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,SelectCategoryDelegate{
    
    let CELL_INTERVAL:CGFloat = 12.0
    var cursor:Int = 0
    let count:Int = 20
    var headRefresh:Bool = false
    
    
    let adCellID = "ADcell"
    let categoryCell = "categoryCell"
    let projectDetailCell = "projectDetailCell"
    
    
    @IBOutlet weak var baseCollectionView: UICollectionView!
    var adURLStringArr:Array<String> = []
    var categoryArr:Array<CategoryModel>?
    var productsNSMArray:NSMutableArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.sleep(forTimeInterval: 3.0)//延长启动页的显示时间
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.baseCollectionView.mj_header = MJRefreshNormalHeader(refreshingTarget:self, refreshingAction:#selector(HomePageViewController.refreshData))
        self.baseCollectionView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget:self, refreshingAction:#selector(HomePageViewController.footRefresh))
        
        self.title = "美丽衣橱"
        self.setUpData()
        
    }
    func setUpData() {
        productsNSMArray = NSMutableArray()
        self.baseCollectionView.mj_header.beginRefreshing()
        self.downloadADData()
        self.downloadCategoryData()
        self.downloadProductData()
    }
    func refreshData() {
        cursor = 0
        headRefresh = true
        self.downloadProductData()
    }
    func footRefresh() {
        cursor += 1
        self.downloadProductData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }else {
            return productsNSMArray!.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width:ScreenWidtn,height:ScreenWidtn/1.76)
        }else if indexPath.section == 1{
            return CGSize(width:ScreenWidtn,height:120)
        }else{
            return CGSize(width:(ScreenWidtn - 2*CELL_INTERVAL)/2,height:(ScreenWidtn - 2*CELL_INTERVAL)/2 + 25)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: adCellID, for: indexPath) as! ADCollectionCell
            if cell.adView == nil && adURLStringArr.count>0 {
                cell.adView = ZZADScrollView(frame:CGRect(x:0,y:0,width:ScreenWidtn,height:ScreenWidtn/1.76), imageArray:adURLStringArr)
                cell.addSubview(cell.adView!)
            }
            return cell
        }else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell, for: indexPath) as! CategoryCollectionViewCell
            if categoryArr != nil {
                cell .refreshData(array: categoryArr!)
            }
            cell.delegate = self
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: projectDetailCell, for: indexPath) as! ProjectDetailCollectionViewCell
            if (productsNSMArray?.count)! > indexPath.item {
                let model = productsNSMArray?[indexPath.item] as! ProductModel
                cell.productImageView.sd_setImage(with: URL(string:model.taobao_pic_url!), placeholderImage: UIImage(named:"assets_placeholder_picture"))
                cell.prodectPriceLabel.text = model.money_symbol! + model.taobao_promo_price!
                cell.prodectInterestCountLabel.text = model.likes_count!
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 || section == 1 {
            return UIEdgeInsets(top:0,left:0,bottom:0,right:0)
        }else{
            return UIEdgeInsets(top:CELL_INTERVAL,left:CELL_INTERVAL/1.5,bottom:0,right:CELL_INTERVAL/1.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //调整section间距
        return 0.0
    }
    //MARK: - SelectCategoryDelegate
    func DicSelectCategory(index:Int) ->Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let Top8CategoryViewController = storyboard.instantiateViewController(withIdentifier: "Top8CategoryVCId") as! Top8CategoryViewController
        let model = categoryArr?[index]
        Top8CategoryViewController.keyWord = model?.taobao_title
        Top8CategoryViewController.method = model?.method
        Top8CategoryViewController.tabbao_cid = model?.taobao_cid
        self.navigationController?.pushViewController(Top8CategoryViewController, animated: true)
    }
    
    //MARK: - 下载广告页数据
    private func downloadADData() {
        DownLoadData.getAdvertising { (array) in
            array.enumerateObjects({ (model, idx, finish) in
                let adModel = model as! AdvertisingModel
                self.adURLStringArr.append(adModel.pic_url!)
            })
            self.baseCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)

        }
    }
    
    //MARK: - 下载排行数据
    private func downloadCategoryData() {
        DownLoadData.getCategories({array in
            self.categoryArr = array as? Array<CategoryModel>
            self.baseCollectionView.reloadSections(NSIndexSet(index:1) as IndexSet)
        })
    }
    //MARK: - 下载产品数据
    private func downloadProductData() {
        DownLoadData.getProducts(["cursor":cursor as AnyObject,"count":count as AnyObject]){ array in
            
            if self.headRefresh == true {
                self.productsNSMArray?.removeAllObjects()
                self.productsNSMArray?.addObjects(from: array as! [ProductModel])
                self.headRefresh = false
            }else{
                 self.productsNSMArray?.addObjects(from: array as! [ProductModel])
            }
            self.baseCollectionView.mj_header.endRefreshing()
            self.baseCollectionView.mj_footer.endRefreshing()
            self.baseCollectionView.reloadSections(NSIndexSet(index:2) as IndexSet)
        
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductSegueId" {
            let index = baseCollectionView.indexPath(for: sender as! ProjectDetailCollectionViewCell)
            if (productsNSMArray?.count)! > (index?.item)! {
                let model = productsNSMArray?[(index?.item)!] as! ProductModel
                let ProductDetailViewController = segue.destination as! ProductDetailViewController
                ProductDetailViewController.urlString = model.taobao_url
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
