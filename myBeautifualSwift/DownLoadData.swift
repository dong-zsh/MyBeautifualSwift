//
//  DownLoadData.swift
//  BeautifulSwift
//
//  Created by 尹中正(外包) on 16/5/10.
//  Copyright © 2016年 Aaron. All rights reserved.
//

import UIKit
import Alamofire

class DownLoadData: NSObject {
    //首页-精选-广告模块
    static func getAdvertising(_ complication:@escaping (_ array: NSArray) -> Void) -> Void {
        
        Alamofire.request(HOMEPAGE_ADVERTIS).validate().responseJSON(){
            response in
            if response.result.isSuccess{
                let json = response.result.value as! NSDictionary
                print(json)
                let array = AdvertisingModel.mj_objectArray(withKeyValuesArray: json["data"])
                complication(array!)
            }else{
                print(response.result.error)
            }
            
        }
    }
    
    //本周人气top8
    static func getCategories(_ complication:@escaping (_ array: NSArray) -> Void) {
        Alamofire.request(HOMEPAGE_TOP).validate().responseJSON(){
            response in
            switch response.result {
              case .success:
                 let json = response.result.value as! NSDictionary
                 print(json)
                 let dic:NSDictionary = json .value(forKey: "data") as! NSDictionary
                 let array = CategoryModel.mj_objectArray(withKeyValuesArray: dic["categories"])
                 complication(array!)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    //HOMEPAGE_CHIOCE
    static func getProducts(_ parameters: [String : AnyObject]?, complication:@escaping (_ array: NSArray) -> Void) {
        Alamofire.request(HOMEPAGE_CHIOCE,parameters:parameters).validate().responseJSON() { response in
            switch response.result {
            case .success:
                let json = response.result.value as! NSDictionary
                let data = json .value(forKey: "data") as! NSDictionary
                let array = ProductModel.mj_objectArray(withKeyValuesArray: data["products"])
                complication(array!)
                break
            case .failure(let error):
                print(error)
                break
            }
            
        }
//        Alamofire.request(HOMEPAGE_CHIOCE).validate().
//        Alamofire.request(.GET, HOMEPAGE_CHIOCE, parameters: parameters).responseJSON { response in
//            let array = ProductModel.mj_objectArrayWithKeyValuesArray((response.result.value!["data"]!)!["products"])
//            complication(array: array)
//        }
    }
    
    //HOMEPAGE_TOP_CATEGORIES
    static func getCategoryDetail(_ parameters: [String : AnyObject]?, complication:@escaping (_ array: NSArray) -> Void) {
        Alamofire.request(HOMEPAGE_TOP_CATEGORIES,parameters:parameters).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                let json = response.result.value as! NSDictionary
                let data = json.value(forKey: "data") as! NSDictionary
                let array = ProductModel.mj_objectArray(withKeyValuesArray: data["products"])
                complication(array!)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
