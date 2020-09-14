//
//  RegisterViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/24.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit
import  MBProgressHUD
// delegate_1 定义一个协议
protocol RegisterViewControllerDelegate:NSObjectProtocol {
    
    func RegisterViewControllerDelegateSucc(_ str: String)
}
// block_1 定义一个block
typealias RegisterViewControllerBlock = ( _ str : String) -> Void



class RegisterViewController: UIViewController {

    // delegate_2 声明属性 delegate
    var delegate : RegisterViewControllerDelegate?
    // block_2 声明block 属性
    var block : RegisterViewControllerBlock?
    var block_z :((String)->Void)?
    
    @IBOutlet weak var btnGetVcode: UIButton!
    @IBOutlet weak var textFieldUser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        baseConfiguration()
    }
    func baseConfiguration() -> Void {
        //定义渐变的颜色（从黄色渐变到橙色）
        let topColor = UIColor.colorWithHex(hexStr: "67AF48")
        let buttomColor = UIColor.colorWithHex(hexStr: "458544")
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        let  size = CGSize.init(width: SCREEN_WIDTH - 26 * 2  , height: 44.0 )
        gradientLayer.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
        self.btnGetVcode.layer.insertSublayer(gradientLayer, at: 0)
    }
    @IBAction func btnActionGetVCode(_ sender: Any) {
        let count = self.textFieldUser.text?.count ?? 0
        if count <= 0 {
            MBProgressHUD.showFail(curview: self.view, text: "请输入手机号")
            return
        }else if count != 11{
            MBProgressHUD.showFail(curview: self.view, text: "请输入正确手机号")
            return
        }
        
        
        self.requestDataGetVcode(succ: {
            let  VcodeVc = RegisterVCodeViewController()
            VcodeVc.mobile = self.textFieldUser.text!
            self.navigationController?.pushViewController( VcodeVc, animated: true)
            VcodeVc.comeFrom = ComeFrom.register
        })
        
        
        
         
        // delegate_3 调用代理实现协议方法
//        if (delegate != nil) && (delegate?.responds(to: Selector("RegisterViewControllerDelegateSucc:")) != nil) {
//            delegate?.RegisterViewControllerDelegateSucc("teststr")
//        }
        // block_3  调用block 并传 入参
//        block_z!("block_z_str")
        
    }
    
    // 获得验证码
    func requestDataGetVcode(succ:@escaping BaseBlockSuccess) -> Void{
        
        let param : ParamGetVCode = ParamGetVCode.init()
        param.mobile = self.textFieldUser.text
        param.type = "1"
        let json : [String:Any] = param.toJSON()!
        CommonTool.showLoading(view: self.view)
        LoginTool.getVcode(params: json, success: { (rep) in
            CommonTool.hideLoading(view: self.view)
            if rep.success {
                succ()
            }else{
                CommonTool.showFail(view: nil, text: rep.message)
            }
        }, fail: {(err) in
            CommonTool.hideLoading(view: self.view)
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
    
//    func testblock(zblock: @escaping RegisterViewControllerBlock) -> Void {
//        block = zblock
//    }
    
    @IBAction func btnActionLoginWithPw(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
       
        
    }
}

