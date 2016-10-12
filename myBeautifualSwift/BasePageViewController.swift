//
//  BasePageViewController.swift
//  myBeautifualSwift
//
//  Created by 张东东 on 2016/10/11.
//  Copyright © 2016年 zhangdongdong. All rights reserved.
//

import UIKit

class BasePageViewController: BaseViewController,UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate {

    var dataSourceArray:Array<UIViewController>?//数据源
    var pageViewController:UIPageViewController?
    var completedBlock:((_ index:Int) ->Void)?
    // scrollview代理回调，开始滑动时回调，在这个过程中进行一些设置，防止在滑动过程中调用pageviewcontroller造成崩溃
    var willBeginDraggingBlock:(() ->Void)?
    // scrollview代理回调，滑动结束回调，把之前的设置设置回来
    var endDeceleratingBloc:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - 创建pageViewController
    func SetUpPageViewController(transitionStyle:UIPageViewControllerTransitionStyle,frame:CGRect,array:Array<UIViewController>,willBeginDragging:@escaping (() -> Void),endDecelerating:@escaping (() -> Void),completed:@escaping ((_ index:Int) ->Void)) -> Void {
        self.dataSourceArray = array
        self.CreatepageViewController(transitionStyle: transitionStyle, frame: frame)
        self.willBeginDraggingBlock = willBeginDragging
        self.endDeceleratingBloc = endDecelerating
        self.completedBlock = completed
        
    }
    func CreatepageViewController(transitionStyle:UIPageViewControllerTransitionStyle,frame:CGRect) -> Void {
        let options:NSDictionary = [UIPageViewControllerOptionSpineLocationKey:NSNumber(value:1)]//书脊？
        self.pageViewController = UIPageViewController(transitionStyle:transitionStyle,navigationOrientation:UIPageViewControllerNavigationOrientation.horizontal,options:options as? [String : Any])
        self.pageViewController?.delegate = self
        self.pageViewController?.dataSource = self
        self.pageViewController?.view.frame = frame
        self.pageViewController?.setViewControllers([(dataSourceArray?.first)!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview((self.pageViewController?.view)!)
        //设置scrollview代理
        self.setPageViewControllerScrollViewdelegate()
        
    }
    func scrollToViewcontroler(index:Int,anmation:Bool) -> Void {
        let currentIndex = self.getCurrentViewControllerIndex(viewcontroller: (pageViewController?.viewControllers?.first)!)
        if currentIndex == index {
            return
        }
        let direction:UIPageViewControllerNavigationDirection = currentIndex < index ? UIPageViewControllerNavigationDirection.forward : UIPageViewControllerNavigationDirection.reverse
        self.pageViewController?.setViewControllers([(dataSourceArray?[index])!], direction: direction, animated: anmation, completion: nil)
        
    }
    
    
    //MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.getCurrentViewControllerIndex(viewcontroller: viewController)
        //--------------------????????
        if index > 0 {
            return self.dataSourceArray?[index-1]
        }else{
            return nil
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
         let index = self.getCurrentViewControllerIndex(viewcontroller: viewController)
        if index < 2 {
            return self.dataSourceArray?[index+1]
        }else{
            return nil
        }
    }
    //MARK: - UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let index = self.getCurrentViewControllerIndex(viewcontroller: (pageViewController.viewControllers?.first)!)
        if completedBlock != nil {
            completedBlock!(index)
        }
    }
    //MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {//开始拖拽视图
        if willBeginDraggingBlock != nil {
            willBeginDraggingBlock!()
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {//减速停止时执行，开始触摸时执行
        if endDeceleratingBloc != nil {
            endDeceleratingBloc!()
        }
    }
    
    func getCurrentViewControllerIndex(viewcontroller:UIViewController) -> Int {
        return (self.dataSourceArray?.index(of: viewcontroller))!
    }
    private func setPageViewControllerScrollViewdelegate() {
        for view in (self.pageViewController?.view.subviews)! {
            if view .isKind(of: UIScrollView.self) {
                let v = view as! UIScrollView
                v.delegate = self
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
