//
//  Extension.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/25.
//  Copyright © 2019年 free. All rights reserved.
// ys.ex

import UIKit
import MBProgressHUD
import SDWebImage
import CommonCrypto

extension UIImage{
    
     static func z_imageWithColor(color:UIColor) -> UIImage{
        
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let contet = UIGraphicsGetCurrentContext()
        contet?.setFillColor(color.cgColor)
        contet?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image! 
    }
}
extension UIImageView{
    func z_imgUrl(urlStr:String){
        self.sd_setImage(with: URL.init(string: urlStr)) { (img, err, type, url) in
        }
    }
}
extension Int {
      func toString() -> String{
        return String(self)
    }
}

extension String{
    
    func md5() ->String!{
        
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
        return String(format: hash as String)
    }
    
    static func toInt(_ s:String) -> Int {
        return Int(s)!
    }
    func toInt() -> Int {
        if self.count == 0 {
            return 0
        }
        return Int(self)!
    }
    func toFloat() -> Float{
        return Float(self)!
    }
}
extension Array{
    // 去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
 
 
}
extension UIView {
    class func instanteFormNib<T: UIView>() -> T {
        let name = String(describing: T.self)
        let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil).last
        return view as! T
    }
    func maxY() -> CGFloat {
        return self.frame.maxY
    }
    func maxX() -> CGFloat {
        return self.frame.maxX
    }
    func minX() -> CGFloat {
        return self.frame.minX
    }
    func minY() -> CGFloat {
        return self.frame.minY
    }
    
}


extension NSDate{
    class func getStrWithDate(_ date:NSDate) -> String{
        let date = NSDate.init()
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZ"
        return dateFormat.string(from: date as Date)
    }
    class func getTimeIntervalWithDate(_ date:NSDate)  -> TimeInterval{
        return date.timeIntervalSince1970
    }
}

extension UITextView{
    
     func addPlaceHolder(placeText:String = "请尽量将问题描述详细"){
        let plab:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        plab.text = placeText
        plab.textColor = UIColor.colorWithHex(hexStr: "#C0C0C0")
        plab.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(plab)
        self.setValue(plab, forKeyPath: "_placeholderLabel")
    }
}
extension UIColor {
    class func RGBAColorSame(r:CGFloat,a:CGFloat) -> UIColor{
        return UIColor.init(red: r/255, green: r/255, blue: r/255, alpha: a)
    }
    class func RGBColorSame(r:CGFloat) -> UIColor{
        return UIColor.init(red: r/255, green: r/255, blue: r/255, alpha: 1)
    }
    class func RGBAColor(r:CGFloat, g:CGFloat, b:CGFloat,a:CGFloat) -> UIColor{
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    class func RGBColor(r:CGFloat, g:CGFloat, b:CGFloat ) -> UIColor{
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }

    class func colorWithHex_same(s:CGFloat) -> UIColor{
        return UIColor.init(red: s/255, green: s/255, blue: s/255, alpha: 1)
    }
    class func colorWithHex(hexStr:String) -> UIColor{
        return UIColor.colorWithHex(hexStr: hexStr, alpha: 1)
    }
    
    class func colorWithHex(hexStr:String, alpha:Float) -> UIColor{
        var cStr = hexStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        
     
        
        if(cStr.hasPrefix("0x")) {
            cStr = cStr.substring(from: 2) as NSString
        }
        
        if(cStr.hasPrefix("#")){
            cStr = cStr.substring(from: 1) as NSString
        }
        if cStr.length == 2 {
            let arr:NSArray = [cStr,cStr,cStr]
            cStr = arr.componentsJoined(by: "") as NSString
        }
        if cStr.length > 6 {
            cStr = cStr.substring(from: cStr.length-6) as NSString
        }
        if(cStr.length != 6){
            return UIColor.clear;
        }
        
        let rStr = (cStr as NSString).substring(to: 2)
        let gStr = ((cStr as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bStr = ((cStr as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r : UInt32 = 0x0
        var g : UInt32 = 0x0
        var b : UInt32 = 0x0
        
        Scanner.init(string: rStr).scanHexInt32(&r);
        Scanner.init(string: gStr).scanHexInt32(&g);
        Scanner.init(string: bStr).scanHexInt32(&b);
        
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha));
        
    }
}


extension MBProgressHUD{
    // 命名规范 hud+展示or隐藏+
    
    //展示 成功失败 图片 以及 动态提示文案
    class func showSuccess(curview: UIView?, text: String)   {
        self.showWith(curview: curview, text: text, imageName: "success")
    }
    class func showFail(curview: UIView?, text: String)   {
        self.showWith(curview: curview, text: text, imageName: "fail")
    }
    class func showWith(curview: UIView?, text: String, imageName: String) {
        var view = UIView.init()
        if curview == nil{
            view = UIApplication.shared.windows.last!
        }else{
            view = curview!
        }
        // 快速显示一个提示信息
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = text
        //        // 设置图片
        hud.customView = UIImageView.init(image: UIImage.init(named: imageName))
        //        // 再设置模式
        hud.mode = MBProgressHUDMode.customView
        //        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true;
        hud.hide(animated: true, afterDelay: 2)
    }
    
    //展示 loding 以及 文案
    class func showMessage(curview: UIView?, message: String)  {
        var view = UIView.init()
        if curview == nil{
            view = UIApplication.shared.windows.last!
        }else{
            view = curview!
        }
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = message
        hud.removeFromSuperViewOnHide = true;
        hud.dimBackground = true
        //        return hud
    }
    class func hudHid(curview: UIView! ){
        self.hide(for: curview, animated: true)
    }
    
  
    // 快速 展示 关闭
    class func zshow(view: UIView?){
        self.showAdded(to: view!, animated: true);
    }
    class func zhide(view: UIView?){
        self.hide(for: view!, animated: true)
    }
}



extension UIViewController{
    func zNavLeftBarButtonItem(target: Any, action: Selector? = nil) {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "arrow_left_black"), for: .normal);
        btn.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
        btn.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        btn.addTarget(target, action: action ?? #selector(z_back), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
    }
    
    @objc func z_back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func getCurrentViewCon() -> UIViewController {
        let vc = UIApplication.shared.keyWindow?.rootViewController
        return getCurrentVCFrom(rootVC: vc!)
    }
    func getCurrentVCFrom(rootVC : UIViewController) -> UIViewController {
        let curVC : UIViewController
        if (rootVC.presentedViewController != nil) {
            curVC = rootVC.presentedViewController!
        }else if rootVC.isKind(of: UITabBarController.self){
            let rvc = rootVC as! UITabBarController
            //            curVC = rvc.selectedViewController!
            curVC = getCurrentVCFrom(rootVC: rvc.selectedViewController!)
        }else if rootVC.isKind(of: UINavigationController.self){
            let nvc = rootVC as! UINavigationController
            //            curVC = nvc.visibleViewController!
            curVC = getCurrentVCFrom(rootVC: nvc.visibleViewController!)
        }else{
            curVC = rootVC
        }
        return curVC
    }
    
}
