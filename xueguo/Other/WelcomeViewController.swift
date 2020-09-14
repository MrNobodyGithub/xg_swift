//
//  WelcomeViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/26.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    var tabbar :UITabBarController?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var layoutW: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutW.constant = SCREEN_WIDTH * 4
        scrollView.isPagingEnabled = true

        tabbar = RootViewController.init()
        
        kaddChildVc(vc: HomeViewController(), title: "首页", imageName: "tab_home", imageSelect: "tab_home_sel");
        kaddChildVc(vc: CourseViewController(), title: "课程", imageName: "tab_course", imageSelect: "tab_course_sel");
        kaddChildVc(vc: QAViewController(), title: "问答", imageName: "tab_qa", imageSelect: "tab_qa_sel");
        kaddChildVc(vc: MeViewController(), title: "我的", imageName: "tab_me", imageSelect: "tab_me_sel");
        
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func btnActionNext(_ sender: Any) {
        UIApplication.shared.keyWindow?.rootViewController = tabbar
    }
    

    
    func kaddChildVc(vc: UIViewController, title: String , imageName: String, imageSelect: String)  {
        vc.tabBarItem.title = title
        let att = NSDictionary.init(object: UIColor.colorWithHex(hexStr: "54C67B"), forKey: NSAttributedString.Key.foregroundColor as NSCopying)
        vc.tabBarItem.setTitleTextAttributes(att as! [NSAttributedString.Key : Any], for: .selected)
        
        let selImg = UIImage.init(named: imageSelect)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = selImg
        vc.tabBarItem.image = UIImage.init(named: imageName)
        
        let nav = UINavigationController.init(rootViewController: vc)
        nav.title = title
        nav.hidesBottomBarWhenPushed = true
        tabbar?.addChild(nav)
    }
}
