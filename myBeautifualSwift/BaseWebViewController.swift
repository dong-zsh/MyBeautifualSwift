//
//  BaseWebViewController.swift
//  myBeautifualSwift
//
//  Created by 张东东 on 2016/10/11.
//  Copyright © 2016年 zhangdongdong. All rights reserved.
//

import UIKit

class BaseWebViewController: BaseViewController,UIWebViewDelegate {
    
    var webview:UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetUpSubView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func SetUpSubView() {
        webview = UIWebView(frame:CGRect(x:0,y:0,width:ScreenWidtn,height:ScreenHeight))
        webview?.scalesPageToFit = true//缩放到屏幕合适大小
        webview?.delegate = self
        webview?.translatesAutoresizingMaskIntoConstraints = false
        self.view .addSubview(webview!)
        //用来禁止AutoresizingMask转换成AutoLayout,简单来说,Autoresizing和AutoLayout用的不是一套东西,但是默认情况下是相互转换的,这里我们要指定使用AutoLayout系统,所以要禁止自动转换
        //手写代码自动布局
//        let topLayoutConstraint = NSLayoutConstraint(item: webview, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0)
//        let bottomLayoutContraint = NSLayoutConstraint(item: webview, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
//        let leftLayoutConstraint = NSLayoutConstraint(item: webview, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0.0)
//        let rightLayoutContraint = NSLayoutConstraint(item: webview, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0)
//        self.view.addConstraints([topLayoutConstraint, bottomLayoutContraint, leftLayoutConstraint, rightLayoutContraint])
        
    }
    // MARK: - 公共方法
    func LoadWebPage(urlString:String) {
        let url = URL(string:urlString)
        let request = URLRequest(url:url!)
        webview?.loadRequest(request)
    }
    func loadWebPageRequest(request:URLRequest) {
        webview?.loadRequest(request)
    }
    func loadLocalFile(filePath:String) {
        let url = URL(string:filePath)
        let request = URLRequest(url:url!)
        webview?.loadRequest(request)
    }
    // MARK: - WebviewDelegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("\(request.url?.absoluteString)")
        return true
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("webViewDidStartLoad")
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("webViewDidFinishLoad")
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print(error)
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
