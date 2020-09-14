//
//  GlobalMacro.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/23.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit
//ys.h_全局变量 
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let NAV_HEIGHT = UINavigationController.init(rootViewController: UIViewController.init()).navigationBar.frame.size.height
let STATUS_HEIGHT = UIApplication.shared.statusBarFrame.size.height

let NAV_HEIGHT_FUll = NAV_HEIGHT + STATUS_HEIGHT
//let TABBAR_HEIGHT = UITabBarController().tabBar.frame.size.height // 只显示 49
let TABBAR_HEIGHT:CGFloat = (STATUS_HEIGHT > 20.0 ? 83.0:49.0)

  

// mbprogresshud  提示文案
let MESSAGE_NETWORK_FAIL = "网络不佳"

let Key_AFNetworkStatus = "AFNetworkReachabilityStatus"


//def key

let DefKeySearchKey = "DefKeySearchKey_UserDefaults"


// 是否有刘海
func isX() -> Bool {
//    if STATUS_HEIGHT == 44 {
//        print("is x")
//    }else{
//        print("not x")
//    }
    return STATUS_HEIGHT == 44
}

func iphone5() -> Bool{
    return verifyIphone(w: 320.0, h: 568.0)
}
func iphone6() -> Bool{
    return verifyIphone(w: 375.0, h: 667.0)
}
func iphone6p() -> Bool{
    return verifyIphone(w: 414.0, h: 736.0)
}
func iphoneX() -> Bool{
    return verifyIphone(w: 375.0, h: 812.0)
}
func verifyIphone(w: CGFloat,h :CGFloat) -> Bool{
    if SCREEN_WIDTH == w && SCREEN_HEIGHT == h || SCREEN_HEIGHT == w && SCREEN_WIDTH == h {
        return true
    }else{
        return false
    }
}



func RGB_arc_Color() -> UIColor{
    //    [0,100)包括0，不包括100
    //    let tempa = Int(arc4random()%100)
    //    let temp = Int(arc4random_uniform(100))+1
    return UIColor.init(red:getArcR() , green: getArcG(), blue: getArcB(), alpha: 0.618)
}
func getArcR() -> CGFloat{
    return CGFloat(arc4random_uniform(255) + 1) / 255.0 
}
func getArcG() -> CGFloat{
    return CGFloat(arc4random_uniform(255) + 1) / 255.0
}
func getArcB() -> CGFloat{
    return CGFloat(arc4random_uniform(255) + 1) / 255.0
}

func swapTwoValues<T>(_ a: inout T, _ b: inout T){
    let temporaryA = a
    a = b
    b = temporaryA
}
 
func zswap<T> (_ a: inout T, _ b :inout T){
    let str = String(describing: a) + "  " + String(describing: b)
    let tem = a
    a = b
    b = tem
    let stra = str + "->" + String(describing: a) + "  " + String(describing: b)
    print(stra)
}


// 转换 宽高比
func TRANS_GET_H(w:CGFloat ,scale:CGFloat) -> CGFloat{
    return (w / scale)
    
}
func IsLogin() -> Bool{ 
    let user = UserDefaults.standard
    return user.bool(forKey: "isLogin") 
}


typealias BaseBlock = ( _ str:String) -> Void
typealias BaseBlockSuccess = () -> Void
typealias BaseBlock_T<T> = ((T) -> Void)
