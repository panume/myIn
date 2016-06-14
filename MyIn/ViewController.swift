//
//  ViewController.swift
//  MyIn
//
//  Created by binglong on 16/6/6.
//  Copyright © 2016年 binglong. All rights reserved.
//

import UIKit
//import LoginViewController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.setNavigationBarHidden(true, animated:false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toLoginPressed(sender: AnyObject) {
        print("call")
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVCId") as! LoginViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
        
        
    }
    


}

