//
//  RegisterSettingPwViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/24.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit

class RegisterSettingPwViewController: UIViewController {
    
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnSure: UIButton!
    
    @IBOutlet weak var textFieldPw: UITextField!
    @IBOutlet weak var textFieldPwAgain: UITextField!

    
    var mobile:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        baseConfiguration()
    }
    func requestData(){
        let param:ParamRegister = ParamRegister()
        param.mobile = self.mobile
        param.loginPassword = self.textFieldPw.text!
        let json : [String:Any] = param.toJSON()!
        
        LoginTool.register(params: json, success: { (rep) in
            if rep.success {
               
                let vc = CheckViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                CommonTool.showFail(view: self.view, text: rep.message)
            }
        },fail: { (err) in
             CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
        
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
        self.btnSure.layer.insertSublayer(gradientLayer, at: 0)
    }


    @IBAction func btnActionQuit(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionProtocalSel(_ sender: UIButton) {
    }
    
    @IBAction func btnActionProtocal(_ sender: UIButton) {
    }
    
    @IBAction func btnActionSure(_ sender: Any) {
        if self.textFieldPw.text?.count == 0 {
            CommonTool.showFail(view: self.view, text: "请填写密码")
            return
        }
        if self.textFieldPw.text != self.textFieldPwAgain.text {
            CommonTool.showFail(view: self.view, text: "两次输入密码不匹配")
            return
        }
        
        if self.btnCheck.isSelected {
            CommonTool.showFail(view: self.view, text: "请选中学果服务条款")
            return
        }
        
        self.requestData()
    }
    
    @IBAction func btnActionCheck(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
