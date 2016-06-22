//
//  PPActionSheet.swift
//  MyIn
//
//  Created by binglong on 16/6/14.
//  Copyright © 2016年 binglong. All rights reserved.
//

import UIKit


protocol PPActionSheetDelegate {
    func PPActionSheetSelect(ppActionSheet:PPActionSheet, index:NSInteger)
    
    
}

let screenSize : CGRect = UIScreen.mainScreen().bounds


class PPActionSheet: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    var title : NSString = ""
    var tableView : UITableView
    var cancelTitle : NSString = ""
    var otherTitles : NSArray?
    
    
    
    
    
    var delegate : PPActionSheetDelegate?
    
//    override convenience init(frame: CGRect) {
////        self.tableView = UITableView.init(frame: frame, style: UITableViewStyle.Plain)
////        self.otherTitles = NSArray.init(array: [])
//        self.init(frame: frame)
//        
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(title: String, cancelButtonTitle cancelTitle:String, otherButtonTitles otherTitles:NSArray) {
        
//        
        
        self.title = title
        self.cancelTitle = cancelTitle
        self.otherTitles = NSArray.init(array: otherTitles as [AnyObject], copyItems: true)
        self.tableView = UITableView.init(frame: CGRectMake(0, 0, screenSize.width, screenSize.height), style: UITableViewStyle.Plain)
        
        
        super.init(frame:CGRectMake(0, 0, screenSize.width, screenSize.height))

        self.tableView.frame = CGRectMake(0, screenSize.height, screenSize.width, self.getTableHeight())
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.scrollEnabled = false
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.addSubview(self.tableView)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(PPActionSheet.backgroundTapped(_:)))
        self.addGestureRecognizer(tapGesture)
        
    }
    
    func backgroundTapped(sender : UITapGestureRecognizer) {
        self.hide()
    }
    
    func getTableHeight() -> CGFloat {
        return self.title.length > 0 ? 30.0 : 0 + (CGFloat)(self.otherTitles!.count * 40) + 10.0 + 40.0
    }
    
    func show() {
        let window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(self)
        
        UIView.animateWithDuration(0.3) {
            self.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            self.tableView.frame = CGRectMake(0, screenSize.height - self.tableView.frame.size.height, screenSize.width, self.tableView.frame.size.height)
        }
    }
    
    func hide() {
        UIView.animateWithDuration(0.3, animations: {
            self.backgroundColor = UIColor.init(white: 0, alpha: 0)
            self.tableView.frame = CGRectMake(0, screenSize.height, screenSize.width, self.tableView.frame.size.height)
            }, completion: {(finished: Bool) -> Void in
                self.removeFromSuperview()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.otherTitles!.count : 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TitleCell"
        var titleCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        
        if  indexPath.section == 0 {
            if titleCell == nil {
                titleCell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
            }
            
            
            titleCell?.textLabel?.text = self.otherTitles![indexPath.row] as? String
            
        }
        else {
            
                if titleCell == nil {
                    titleCell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
                }
            titleCell?.textLabel?.text = self.cancelTitle as String
            
        }
        titleCell?.textLabel?.textAlignment = NSTextAlignment.Center

            titleCell?.separatorInset = UIEdgeInsetsMake(0, 0.01, 0, 0)
        titleCell?.layoutMargins = UIEdgeInsetsZero
        return titleCell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 1 {
            if (self.delegate != nil) {
                self.delegate?.PPActionSheetSelect(self, index: -1)
            }
        }
        else {
            if (self.delegate != nil) {
                self.delegate?.PPActionSheetSelect(self, index: indexPath.row)
            }
        }
        
        self.hide()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 10
    }
  
}
