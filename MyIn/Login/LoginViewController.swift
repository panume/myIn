//
//  LoginViewController.swift
//  MyIn
//
//  Created by binglong on 16/6/6.
//  Copyright © 2016年 binglong. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, PPActionSheetDelegate {

    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var accountTF: UITextField!
    
    @IBOutlet weak var loginIssueButton: UIButton!
    @IBOutlet weak var spinner: Spinner!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.setGaussBlur(self.backImageView.image!)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(LoginViewController.backTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.backImageView.addGestureRecognizer(tapGesture)
        self.backImageView.userInteractionEnabled = true
        
        if self.accountTF.respondsToSelector(Selector("attributedPlaceholder")) {
            self.accountTF.attributedPlaceholder = NSAttributedString(string: self.accountTF.placeholder!, attributes:[NSForegroundColorAttributeName : UIColor.init(white: 1, alpha: 0.5)])
            self.passwordTF.attributedPlaceholder = NSAttributedString(string: self.passwordTF.placeholder!, attributes:[NSForegroundColorAttributeName : UIColor.init(white: 1, alpha: 0.5)])
//        self.accountTF.tintColor = UIColor.whiteColor()
//        self.passwordTF.tintColor = UIColor.whiteColor()
        }
        
        self.passwordTF.secureTextEntry = true
        
        let showButton = UIButton.init(type: UIButtonType.Custom)
        let image = UIImage.init(named: "show")
        showButton.frame = CGRectMake(0, 0, (image?.size.width)!, (image?.size.height)!)
        showButton.addTarget(self, action: #selector(LoginViewController.showOrHidePassword(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        showButton.setImage(UIImage.init(named: "hide"), forState: UIControlState.Normal)
        showButton.setImage(UIImage.init(named: "show"), forState: UIControlState.Selected)
        self.passwordTF.rightView = showButton
        self.passwordTF.rightViewMode = UITextFieldViewMode.Always
        
        let attributedTitle = NSMutableAttributedString.init(string: "登录遇到问题？")
        attributedTitle.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(0, attributedTitle.length))
        attributedTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSMakeRange(0, attributedTitle.length))
        self.loginIssueButton.setAttributedTitle(attributedTitle, forState: UIControlState.Normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated:animated)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        NSLog("123")
    }
    
    
    
    func setGaussBlur(image: UIImage) {
//        var imageToBlur = CIImage(image: image)
//        var blurfilter = CIFilter(name: "CIGaussianBlur")
//        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
//        var resultImage = blurfilter!.valueForKey("outputImage") as! CIImage
//        var blurredImage = UIImage(CIImage: resultImage)
//        self.backImageView.image = blurredImage
        
        let effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect : effect)
//        image.blur
        blurView.frame = self.view.frame
        self.backImageView.addSubview(blurView)
        
    }
    @IBAction func registerButtonPressed(sender: AnyObject) {
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("registerControllerId")
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
    @IBAction func loginIssueButtonPressed(sender: AnyObject) {
        let actionSheet = PPActionSheet.init(title: "", cancelButtonTitle:"取消", otherButtonTitles:["用手机号重置密码", "帮助与反馈"])
        actionSheet.delegate = self
        actionSheet.show()
    }
    
    func PPActionSheetSelect(ppActionSheet: PPActionSheet, index: NSInteger) {
        
        
    }
    
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        self.spinner.tintColor = UIColor.redColor()
        self.spinner.startAnimating()
    }
    func backTapped(gesture:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    func showOrHidePassword(sender:UIButton) {
        if sender.selected {
            sender.selected = false
            
            sender.setImage(UIImage.init(named: "hide"), forState: sender.state)
        }
        else {
            sender.selected = true
            sender.setImage(UIImage.init(named: "show"), forState: sender.state)
        }
        self.passwordTF.secureTextEntry = !sender.selected
    }

}
