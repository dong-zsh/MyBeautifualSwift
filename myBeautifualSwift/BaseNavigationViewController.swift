//
//  BaseNavigationViewController.swift
//  myBeautifualSwift
//
//  Created by 张东东 on 16/9/20.
//  Copyright © 2016年 zhangdongdong. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor.white
        let dic = [NSForegroundColorAttributeName:color]
        self.navigationBar.titleTextAttributes = dic
        // Do any additional setup after loading the view.
    }
    //重写该属性的getter方法
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        //重写返回按钮
        self.setUpLeftBarButtonItem(viewController)
    }
    //私有方法
    fileprivate func setUpLeftBarButtonItem(_ viewController:UIViewController) ->Void{
        let img = UIImage(named:"slideBackButton")
        let btn = UIButton(type :UIButtonType.custom)
        btn.frame = CGRect(x : 0,y : 0, width: (img?.size.width)!,height: (img?.size.height)!)
        btn.setImage(img, for: UIControlState.normal)
        btn.setImage(img, for: UIControlState.highlighted)
        btn.addTarget(self, action: #selector(BaseNavigationViewController.customPopViewController), for: UIControlEvents.touchUpInside)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView :btn)
    }
    
    func customPopViewController() -> Void {
        self.popViewController(animated: true)
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
