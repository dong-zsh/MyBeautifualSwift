//
//  mySwift.swift
//  myBeautifualSwift
//
//  Created by 张东东 on 16/9/21.
//  Copyright © 2016年 zhangdongdong. All rights reserved.
//

import Foundation
import UIKit

let ScreenWidtn = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height
let StatusBarHeight:CGFloat = 20.0
let navigationBarHeight:CGFloat = 44.0
let TabBarHeight:CGFloat = 49.0

/// 主页广告
let HOMEPAGE_ADVERTIS = "http://api.yuike.com/beautymall/api/1.0/client/banner_list.php?sid=a41470ba1720835d84fc1423f7b2272a&yk_pid=3&yk_appid=1&yk_cc=m360&yk_cvc=231"
/// 主页Top8
let HOMEPAGE_TOP = "http://api.yuike.com/beautymall/api/1.0/category/ranking_list.php?sid=a41470ba1720835d84fc1423f7b2272a&yk_pid=3&yk_appid=1&yk_cc=m360&yk_cvc=231"
/// 主页Top8跳转链接
//let HOMEPAGE_TOP_CATEGORIES = "http://api.yuike.com/beautymall/api/1.0/search/search.php?count=40&cursor=0&keyword=%@&method=%@&sid=8cdcd15c09472cf67a5147c045f4d380&sort=%ld&taobao_cid=%@&type=product&yk_appid=1&yk_cbv=2.8.8.1&yk_pid=1&yk_user_id=1950622"
let HOMEPAGE_TOP_CATEGORIES = "http://api.yuike.com/beautymall/api/1.0/search/search.php?count=40&cursor=0&sid=8cdcd15c09472cf67a5147c045f4d380&type=product&yk_appid=1&yk_cbv=2.8.8.1&yk_pid=1&yk_user_id=1950622"
/// 主页产品列表
let HOMEPAGE_CHIOCE = "http://api.yuike.com/beautymall/api/1.0/product/quality.php?type=choice&sid=a41470ba1720835d84fc1423f7b2272a&yk_pid=3&yk_appid=1&yk_cc=m360&yk_cvc=231"





		
