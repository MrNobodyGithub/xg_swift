//
//  AppDelegate.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/23.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var tabbar :UITabBarController?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        tabbar = RootViewController.init()
        
        kaddChildVc(vc: HomeViewController(), title: "首页", imageName: "tab_home", imageSelect: "tab_home_sel");
        kaddChildVc(vc: CourseViewController(), title: "课程", imageName: "tab_course", imageSelect: "tab_course_sel");
        kaddChildVc(vc: QAViewController(), title: "问答", imageName: "tab_qa", imageSelect: "tab_qa_sel");
        kaddChildVc(vc: MeViewController(), title: "我的", imageName: "tab_me", imageSelect: "tab_me_sel");
        
        
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        //temp
//        tabbar?.selectedIndex = 1
        
        let needShow = self.kVerifyVersionShowWelcome()
        if needShow  {
            window?.rootViewController = WelcomeViewController()
        }else{
            window?.rootViewController = tabbar
        }
        
        window?.makeKeyAndVisible()
        
        UMSocial()
        return true
    }
    
    func kVerifyVersionShowWelcome() -> Bool{
        
        
        let infoDictionary = Bundle.main.infoDictionary
//        let appDisplayName:AnyObject? = infoDictionary!["CFBundleDisplayName"] as AnyObject? //程序名称
        let majorVersion :String = infoDictionary!["CFBundleShortVersionString"] as! String//主程序版本号
//        let minorVersion :AnyObject? = infoDictionary!["CFBundleVersion"] as AnyObject?//版本号（内部标示）
        
        let strVersion:String = "strVersionForUserDef"
        if  UserDefaults.standard.object(forKey: strVersion) != nil {
            let version:String = UserDefaults.standard.object(forKey: strVersion) as! String
            if version  ==  majorVersion {
                return false;
            }else{
                UserDefaults.standard.set(majorVersion, forKey: strVersion)
                return true;
            }
        }else{
            UserDefaults.standard.set(majorVersion, forKey: strVersion)
            return true;
        }
        
        
        return false;
    }
    
    
    func UMSocial(){
        
        
        UMSocialManager.default()?.umSocialAppkey = "5ba98f93f1f556d99a00000c"
        let config = UMAnalyticsConfig.sharedInstance()
        config?.appKey = "5ba98f93f1f556d99a00000c"
        config?.channelId = "App Store" //enterprise   App Store
        MobClick.start(withConfigure: config)
        
        // U-Share 平台设置
        //    AppID：wx440c43cd82116781
        //    AppSecret：a9cda5b08dd7116961bcdb73e29f8545
        /* 设置微信的appKey和appSecret */
         UMSocialManager.default()?.setPlaform(.wechatSession, appKey: "wx440c43cd82116781", appSecret: "a9cda5b08dd7116961bcdb73e29f8545", redirectURL: "http://mobile.umeng.com/social")
        /*
         * 移除相应平台的分享，如微信收藏
         */
        UMSocialManager.default()?.removePlatformProvider(with: .wechatFavorite)

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
  
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
 
        let res :Bool = (UMSocialManager.default()?.handleOpen(url, options: options))!
    //        if (!res) {
    //            // 其他如支付等SDK的回调
    //        }
        return res
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

