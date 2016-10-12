//
//  ZZADScrollView.swift
//  BeautifulSwift
//
//  Created by 尹中正(外包) on 16/5/12.
//  Copyright © 2016年 Aaron. All rights reserved.
//

import UIKit
import SDWebImage

class ZZADScrollView: UIView, UIScrollViewDelegate {
    
    let pageCount:Int
    var currentPageIndex = 0
    let currentTimeInterval:TimeInterval = 2.0
    var timer:Timer?
    var scrollView:UIScrollView?
    var pageControl:UIPageControl?
    
    init(frame: CGRect, imageArray:Array<String>) {
        pageCount = imageArray.count
        super.init(frame: frame)
        scrollView = UIScrollView(frame: frame)
        scrollView!.backgroundColor = UIColor.init(red: 244 / 255, green: 244 / 255, blue: 236 / 255, alpha: 1.0)
        scrollView!.bounces = true;
        scrollView!.showsHorizontalScrollIndicator = false;
        scrollView!.showsVerticalScrollIndicator = false;
        scrollView!.isPagingEnabled = true;
        scrollView!.contentSize = CGSize(width:frame.size.width * CGFloat(imageArray.count), height:frame.size.height);
        scrollView!.contentOffset = CGPoint.zero
        scrollView!.delegate = self
        self.addSubview(scrollView!)
        
        for (i, imageURLString) in imageArray.enumerated() {
            let button = UIButton(type: UIButtonType.custom)
            button.frame = CGRect(x:CGFloat(i) * frame.size.width, y:0, width:frame.size.width, height:frame.size.height)
            button.sd_setBackgroundImage(with: URL(string: imageURLString), for: UIControlState.normal, placeholderImage: UIImage(named: "assets_placeholder_picture"))
            button.sd_setBackgroundImage(with: URL(string: imageURLString), for: UIControlState.highlighted, placeholderImage: UIImage(named: "assets_placeholder_picture"))
            scrollView!.addSubview(button)
        }
        
        pageControl = UIPageControl()
        let size = pageControl!.size(forNumberOfPages: imageArray.count)
        pageControl!.frame = CGRect(x:0, y:0, width:size.width, height:size.height)
        pageControl!.center = CGPoint(x:frame.size.width / 2, y:frame.size.height - size.height / 2 );
        pageControl!.pageIndicatorTintColor = UIColor.white
        pageControl!.currentPageIndicatorTintColor = UIColor.init(red: 1.0, green: 121.0 / 255, blue: 168.0 / 255, alpha: 1.0)
        pageControl!.numberOfPages = imageArray.count
        pageControl!.currentPage = 0
        self.addSubview(pageControl!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        pageCount = 0
        super.init(coder: aDecoder)
    }
    
    //UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index:Int = Int(scrollView.contentOffset.x / self.frame.size.width)
        pageControl?.currentPage = index
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
