//
//  CommonTool.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/19.
//  Copyright © 2019 free. All rights reserved.
// ys.com

import UIKit
import  MBProgressHUD


class CommonTool: NSObject {
    static func addNilView(y:CGFloat = 0,vc:UIViewController,imageName:String,titleStr:String) {
        let v: UIView = UIView.init(frame: CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        vc.view.addSubview(v)
        
        let img = UIImageView.init(frame: CGRect.init(x: 0, y: 140, width: SCREEN_WIDTH, height: 120))
        v.addSubview(img)
        img.contentMode = .scaleAspectFit
        img.image = UIImage.init(named: imageName)
        
        let lab:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: img.frame.maxY + CGFloat(10), width: SCREEN_WIDTH, height: 25))
        v.addSubview(lab)
        lab.text = titleStr
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = UIColor.colorWithHex(hexStr: "#9B9B9B")
        lab.textAlignment = .center
        
    }
    static func stringToArray(str:String) ->Array<Any>?{
        let data = str.data(using: String.Encoding.utf8)
        if let arr = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) {
            return (arr as! Array)
        }
        return nil
    }
    static func stringToDict(str:String) ->[String :Any]?{
        let data = str.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) {
            return (dict as! [String : Any])
        }
        return nil
    }
    static func dictToString(dic:[String: Any]) -> String?{
        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8)
        return str
    }
 
    
    class func cusRandBool() -> Bool{
        let a = arc4random() % 2
        return a == 0
    }
    
    class func CusOrderListArc(count:Int = 10,max:Int = 100) -> [Int] {
        let arr = Array.init(repeating: 0, count: count)
        var newArr = [Int]()
        var temp :Int = 0
        for (_,_) in arr.enumerated(){
            temp  = Int(arc4random()) % max
            newArr.append(temp)
        }
        return newArr
    }
    class func CusOrderList(start:Int = 0,step:Int = 1,count:Int = 10) -> [Int]{
        
        let arr = Array.init(repeating: 0, count: count)
        var newArr = [Int]()
        var temp :Int = start
        for (_,_) in arr.enumerated(){
            newArr.append(temp)
            temp += step
        }
        return newArr
    }

    
    class func addShadowCorner(_ layer:CALayer)  -> Void {
        layer.cornerRadius = 6
        layer.shadowColor = UIColor.black.cgColor
        layer.borderWidth = 0.1
        layer.borderColor = layer.shadowColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize.init(width: 0, height: 0)
    }
    class func addCornerRadius_fast(sizeW: CGFloat,sizeH:CGFloat,layer:CALayer,radius:CGFloat,arr:UIRectCorner){
        let size:CGSize  = CGSize.init(width: sizeW, height: sizeH)
        let cornerSize:CGSize = CGSize.init(width: radius, height: radius)
        let path:UIBezierPath = UIBezierPath.init(roundedRect: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size), byRoundingCorners: arr, cornerRadii: cornerSize)
        let lay = CAShapeLayer.init()
        lay.path = path.cgPath
        lay.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size:  size)
        layer.mask = lay
    }
    class func addCornerRadius(size: CGSize,layer:CALayer,cornerSize:CGSize,arr:UIRectCorner){
        let path:UIBezierPath = UIBezierPath.init(roundedRect: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size), byRoundingCorners: arr, cornerRadii: cornerSize)
        let lay = CAShapeLayer.init()
        lay.path = path.cgPath
        lay.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size:  size)
        layer.mask = lay
    }
    
    class func thirdLoginInfo(_ type:UMSocialPlatformType, success:@escaping (_ result: UMSocialUserInfoResponse) -> (), fail:@escaping(_ error: Error) -> ()){
        UMSocialManager.default()?.getUserInfo(with: type, currentViewController: nil, completion: { (res, err) in
            if (err != nil) {
                fail(err!)
            }else{
                let resp: UMSocialUserInfoResponse = res as! UMSocialUserInfoResponse
                success(resp)
            }
        })
        
    }
    
    class func logIvar(_ cls: AnyClass){
        var count:UInt32 = 0
        var countPro: UInt32 = 0
        var countProtocol : UInt32 = 0
        let ivarList = class_copyIvarList(cls, &count)
        let proList = class_copyPropertyList(cls, &countPro)
        let protocolList = class_copyProtocolList(cls, &countProtocol)
        
        print("---  -ivar- ---");
        for x in (0..<count){
            let ivar:Ivar = ivarList![Int(x)]
            let name = String.init(utf8String: ivar_getName(ivar)!)
            print(name as Any)
        }
        print("---  -property- ---");
        for i in (0..<countPro){
            let property = proList![Int(i)]
            let name = String.init(utf8String: property_getName(property))
            print(name as Any)
        }
        
        print("---  -protocol- ---");
        for i in (0..<countProtocol){
            let prot = protocolList![Int(i)]
            let name = String.init(utf8String: protocol_getName(prot))
            print(name as Any)
        }

    }
    
 
    
    //MARK: OTHER
    static  func inputAccessoryView(_ target:Any?, _ action:Selector?,_ size:CGSize = CGSize.init(width: SCREEN_WIDTH, height: 50)) -> UIToolbar{
        let space = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: target, action: nil)
        let finish =  UIBarButtonItem.init(title: "完成", style: .plain, target: target, action: action)
        
        let toolbar = UIToolbar.init()
        toolbar.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 50)
        toolbar.items = [space,finish]
        return toolbar
    }
    
   
    static func addGradientColo(_ layer: CALayer ,_ size: CGSize,_ arrColor:[String],_ startPoint: CGPoint = CGPoint.init(x: 0, y: 0)   , _ endpoint:CGPoint  = CGPoint.init(x: 1, y: 0)){
        //定义渐变的颜色（从黄色渐变到橙色）
        let topColor = UIColor.colorWithHex(hexStr: arrColor[0])
        let buttomColor = UIColor.colorWithHex(hexStr: arrColor[1])
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
//    gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
//    gradientLayer.endPoint = CGPoint.init(x: 1, y: 0)
    gradientLayer.startPoint = startPoint
    gradientLayer.endPoint = endpoint
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        let  size = CGSize.init(width: size.width , height: size.height )
        gradientLayer.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
        layer.insertSublayer(gradientLayer, at: 0)
    }
      //MARK: ------DATA--------
    static func getUserId() -> String {
        //FIXME: tempData
//        return "1"
        let model:ModelUser = unarhiveUserData()
        return model.id
    }
    static func getCollegeId() -> String { 
        let model:ModelUser = unarhiveUserData()
        return model.collegeId
    }

    //MARK: 归档接档
    static func archiveUserDataWith(user:ModelUser){
        var path:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
         path.append("/user.data") 
        NSKeyedArchiver.archiveRootObject(user, toFile: path)
    }
    static func unarhiveUserData() -> ModelUser{
        var path:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path.append("/user.data")
        let manager = FileManager.default
        let isExist: Bool = manager.fileExists(atPath: path)
         
        print(path)
        if isExist {
            let model:ModelUser = NSKeyedUnarchiver.unarchiveObject(withFile: path) as! ModelUser
            return model
        }else{
            let model:ModelUser = ModelUser.init()
            return model
        }
    }
  //MARK: 段落行间隙 设置可变字符串 获取动态高度
    static func getAttributedWithString(str: String, linespace:CGFloat = 5,fontSize:CGFloat,foreColor:UIColor = .black) -> NSMutableAttributedString{
        let paraSty = NSMutableParagraphStyle.init()
        paraSty.lineSpacing = linespace
        let mutStr = NSMutableAttributedString.init(string: str, attributes: [kCTFontAttributeName as NSAttributedString.Key:UIFont.systemFont(ofSize: fontSize)])
        mutStr.addAttribute(kCTParagraphStyleAttributeName as NSAttributedString.Key , value: paraSty, range: NSRange.init(location: 0, length: str.count))
        mutStr.addAttribute(kCTForegroundColorAttributeName as NSAttributedString.Key, value: foreColor, range:NSRange.init(location: 0, length: str.count))
        return mutStr
    }
    
    static func getAttributionHeightWithString(str: String, lineSpace:CGFloat = 5, fontSize: CGFloat = 12, width:CGFloat) -> CGFloat {
        let parStyle = NSMutableParagraphStyle.init()
        parStyle.lineSpacing = lineSpace
        let arr = [kCTParagraphStyleAttributeName:parStyle,
                   kCTFontAttributeName:UIFont.systemFont(ofSize: fontSize)]
        let newStr: NSString = str as NSString
        let rect : CGRect = newStr.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: arr as [NSAttributedString.Key : Any], context: nil)
        return rect.size.height
    }
    static func getStrWidth(str:String ,fontsize:CGFloat,height:CGFloat) -> CGFloat{
        let newStr :NSString = str as NSString
        let arr = [kCTFontAttributeName:UIFont.systemFont(ofSize: fontsize)]
        let rect:CGRect =  newStr.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: arr as[NSAttributedString.Key: Any], context: nil)
        return rect.size.width
    }
    
 
    
    //MARK:MBProgressHUD
    static func showFail(view:UIView??, text:String){
        MBProgressHUD.showFail(curview: view ?? nil, text: text)
    }
    static func showSuccess(view:UIView??, text:String){
        MBProgressHUD.showSuccess(curview: view ?? nil, text: text)
    }
    static func showLoading(view:UIView){
        MBProgressHUD.zshow(view: view)
    }
    static func showLoadingWithMessage(view:UIView,message:String){
        MBProgressHUD.showMessage(curview: view, message: message)
    }
    static func hideLoading(view:UIView){
        MBProgressHUD.zhide(view: view)
    }
    
    
}
