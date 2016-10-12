//
//  ProductDetailViewController.swift
//  myBeautifualSwift
//
//  Created by 张东东 on 2016/10/11.
//  Copyright © 2016年 zhangdongdong. All rights reserved.
//

import UIKit

class ProductDetailViewController: BaseWebViewController {

    var urlString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "宝贝详情"
        if urlString != nil {
            self.LoadWebPage(urlString: urlString!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.url?.absoluteString == "http://www.yuike.com/beautymall/3g/page/index.php?_nvsd=KJp5&_nvdp=1" {
            //点击主页按钮
            self.navigationController?.popToRootViewController(animated: true)
            return false
        }
        return true
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
