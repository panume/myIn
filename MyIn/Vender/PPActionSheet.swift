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
    var otherTitles : NSArray
    
    
    
    
    var delegate = PPActionSheetDelegate.self
    
    override init(frame: CGRect) {
        self.tableView = UITableView.init(frame: frame, style: UITableViewStyle.Plain)
        self.otherTitles = NSArray.init(array: [])
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initWithParams(title: NSString, cancelButtonTitle:NSString, otherButtonTitles:NSArray) {
        
        self.title = title
        self.cancelTitle = cancelButtonTitle
        self.otherTitles = NSArray.init(array: otherButtonTitles as [AnyObject], copyItems: true)
        
        self.tableView.frame = CGRectMake(0, screenSize.height, screenSize.width, self.getTableHeight())
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.addSubview(self.tableView)
        
        
    }
    
    func getTableHeight() -> CGFloat {
        return self.title.length > 0 ? 30.0 : 0 + (CGFloat)(self.otherTitles.count * 40) + 10.0
    }
    
    func show() {
        let window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(self)
        
        UIView.animateWithDuration(0.5) { 
            self.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            self.tableView.frame = CGRectMake(0, screenSize.height - self.tableView.frame.size.height, screenSize.width, self.tableView.frame.size.height)
        }
    }
    
    func hide() {
        UIView.animateWithDuration(0.5, animations: { 
            self.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            self.tableView.frame = CGRectMake(0, screenSize.height - self.tableView.frame.size.height, screenSize.width, self.tableView.frame.size.height)
            }, completion: {(finished: Bool) -> Void in
                self.removeFromSuperview()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.otherTitles.count : 1
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
            
            titleCell?.textLabel?.textAlignment = NSTextAlignment.Center
            
            titleCell?.textLabel?.text = self.otherTitles[indexPath.row] as? String
            
        }
        else {
            
            titleCell?.textLabel?.text = self.cancelTitle as String
            
        }
        
        return titleCell!
    }

  
}
