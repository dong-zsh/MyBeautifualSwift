//
//  BaseTabBarViewController.swift
//  myBeautifualSwift
//
//  Created by 张东东 on 16/9/20.
//  Copyright © 2016年 zhangdongdong. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.SettabBarImage()

        // Do any additional setup after loading the view.
    }
    //设置图片渲染模式和标题属性
    func SettabBarImage() -> Void {
        let subViewControllers = self.viewControllers
        var i:NSInteger = 0
        let nameArray:Array = ["搭配","品牌","主题","我的"]
        while i < (subViewControllers?.count)! {
            let vc:UIViewController = subViewControllers![i]
            
            let image = UIImage(named :"tabbarUnselectedIcon\(i+1)")
            let imageOriginal = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            vc.tabBarItem.image = imageOriginal
            let selectImage = UIImage(named :"tabbarSelectedIcon\(i+1)")
            let selectImageOriginal = selectImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            vc.tabBarItem.selectedImage = selectImageOriginal
            vc.tabBarItem.title = nameArray[i]
            i += 1
        }
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor(red: 1.0, green: 121.0 / 255, blue: 168.0 / 255, alpha: 1.0)], for: UIControlState.selected)
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
