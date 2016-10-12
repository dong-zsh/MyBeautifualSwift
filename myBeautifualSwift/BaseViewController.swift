//
//  BaseViewController.swift
//  myBeautifualSwift
//
//  Created by 张东东 on 16/9/21.
//  Copyright © 2016年 zhangdongdong. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //隐藏tabBar
    
    func TabBarHidden(_ hidden:Bool) -> Void {
        UIView.beginAnimations(nil, context: nil)
        UIView .setAnimationDuration(0)
        for view in (self.tabBarController?.view.subviews)! {
            if view is UITabBar {
                if hidden {
                    view.frame = CGRect(x:view.frame.origin.x,y:ScreenHeight,width:view.frame.size.width,height:view.frame.size.height)
                }else{
                    view.frame = CGRect(x:view.frame.origin.x,y:ScreenHeight-TabBarHeight,width:view.frame.size.width,height:view.frame.size.height)
                }
            }else{
                if hidden {
                    view.frame = CGRect(x:view.frame.origin.x,y:view.frame.origin.y,width:ScreenWidtn,height:ScreenHeight)
                }else{
                    view.frame = CGRect(x:view.frame.origin.x,y:view.frame.origin.y,width:ScreenWidtn,height:ScreenHeight-TabBarHeight)
                }
            }
        }
        UIView.commitAnimations()
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
