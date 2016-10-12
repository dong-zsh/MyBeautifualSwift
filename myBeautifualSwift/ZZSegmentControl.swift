//
//  ZZSegmentControl.swift
//  BeautifulSwift
//
//  Created by Aaron on 16/5/19.
//  Copyright © 2016年 Aaron. All rights reserved.
//

import UIKit

class ZZSegmentControl: UIView {
    var segmentItems:Array<UIButton> = []
    var didSelectedItemClosure:((_ index:Int) -> Void)?
    var selectedIndex:Int = 0
    
    // MARK: - UI
    func setupSubviews(items:Array<String>, itemsImageName:Array<String>?, itemsSelectedImageName:Array<String>?, didSelectedItem:((_ index:Int) -> Void)?) {
        for (i, string) in items.enumerated() {
            let button = UIButton(type: UIButtonType.custom)
            button.setTitle(string, for: UIControlState.normal)
            button.setTitle(string, for: UIControlState.highlighted)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            button.setTitleColor(UIColor.lightGray, for: UIControlState.highlighted)
            button.setTitleColor(UIColor.purple, for: UIControlState.selected)
            if (itemsImageName?.count)! > 0 && i < (itemsImageName?.count)! {
                let imageName = itemsImageName![i]
                button.setImage(UIImage(named: imageName), for: UIControlState.normal)
            }
            if (itemsSelectedImageName?.count)! > 0 && i < (itemsSelectedImageName?.count)! {
                let highlightedImageName = itemsSelectedImageName![i]
                button.setImage(UIImage(named: highlightedImageName), for: UIControlState.selected)
            }
            button.titleEdgeInsets = UIEdgeInsetsMake(0.0, 8.0, 0.0, 0.0)
            if i == 0 {
                button.isSelected = true
            }
            button.tag = i
            didSelectedItemClosure = didSelectedItem
            button.addTarget(self, action: #selector(ZZSegmentControl.buttonDidTouchUpInside(sender:)), for: UIControlEvents.touchUpInside)
            self.addSubview(button)
            segmentItems.append(button)
        }
        //自动布局
        for (i, button) in segmentItems.enumerated() {
            let topLayoutConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0)
            let bottomLayoutContraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
            self.addConstraint(topLayoutConstraint)
            self.addConstraint(bottomLayoutContraint)
            if i == 0 {
                let leftLayoutConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0.0)
                self.addConstraint(leftLayoutConstraint)
            }
            if i == segmentItems.count - 1 {
                let rightLayoutContraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0)
                self.addConstraint(rightLayoutContraint)
            } else {
                var nButton:UIButton?
                nButton = segmentItems[i + 1]
                let leftLayoutConstraint = NSLayoutConstraint(item: nButton!, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: button, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0)
                let equalWidthLayoutContraint = NSLayoutConstraint(item: nButton!, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: button, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0.0)
                self.addConstraint(leftLayoutConstraint)
                self.addConstraint(equalWidthLayoutContraint)
            }
        }
    }
    
    // MARK: - Actions
    // MARK: button点击事件
    func buttonDidTouchUpInside(sender:UIButton) -> Void {
        if sender.isSelected {
            return
        }
        segmentItems[selectedIndex].isSelected = false
        selectedIndex = sender.tag
        sender.isSelected = true
        didSelectedItemClosure!(selectedIndex)
    }
    
    func swiftSetSelectedIndex(index:Int) -> Void {
        let sender = segmentItems[index]
        self.buttonDidTouchUpInside(sender: sender)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
