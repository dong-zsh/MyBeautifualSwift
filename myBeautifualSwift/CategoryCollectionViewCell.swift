//
//  CategoryCollectionViewCell.swift
//  myBeautifualSwift
//
//  Created by 张东东 on 16/9/21.
//  Copyright © 2016年 zhangdongdong. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    let cellId = "cellId"
    var delegate:SelectCategoryDelegate?
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var categotyModelArray:Array<CategoryModel> = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categotyModelArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        if categotyModelArray.count > 0 {
            let model = categotyModelArray[indexPath.row]
            cell.bgImageView .sd_setImage(with: NSURL(string: model.background_pic_url!) as URL!)
            cell.enTitleLabel.text = model.en_taobao_title!
            cell.chTitleLabel.text = model.taobao_title!
        }
        return cell
    }
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:ScreenWidtn / 4,height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.DicSelectCategory(index: indexPath.item)
        }
    }
    func refreshData(array:Array<CategoryModel>) {
        categotyModelArray = array
        categoryCollectionView.reloadData()
    }
    
}

protocol SelectCategoryDelegate {
    func DicSelectCategory(index:Int) -> Void
}







