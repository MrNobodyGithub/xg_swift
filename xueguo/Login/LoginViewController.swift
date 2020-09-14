//
//  LoginViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/24.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
 
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var TextFieldUser: UITextField!
    @IBOutlet weak var TextFieldPW: UITextField!
    
     
    var blockLoginSuccess: BaseBlockSuccess?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
//        self.navigationController?.hidesBarsOnTap = true
//        self.navigationController?.hidesBarsOnSwipe = true
        
        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

    }
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
        self.btnLogin.layer.insertSublayer(gradientLayer, at: 0)
        
//        TextFieldPW.rightView = imageEye
//        TextFieldPW.rightViewMode = .whileEditing
        self.TextFieldUser.delegate = self as UITextFieldDelegate
        self.TextFieldPW.delegate = self as UITextFieldDelegate
        
 
        let toolbar = CommonTool.inputAccessoryView(self, #selector(disappleKeyboard), CGSize.init(width: SCREEN_WIDTH, height: 50))
        
        TextFieldUser.inputAccessoryView = toolbar
        TextFieldPW.inputAccessoryView = toolbar
    }
    
    //MARK: ---mark--dfasdf
    //FIXME: -----fixme-----
    //TODO: -------todo----
    
    @objc func disappleKeyboard() -> Void {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    @IBAction func btnActionLogin(_ sender: Any) {
        
        self.TextFieldPW.resignFirstResponder()
        
 
        guard let mobile = self.TextFieldUser.text  else {
            CommonTool.showFail(view: self.view, text: "请输入手机号")
            return
        }
        guard let pw = self.TextFieldPW.text else{
            CommonTool.showFail(view: self.view, text: "请输入密码")
            return
        }
        
        if mobile.count == 0 || mobile.count != 11 {
            CommonTool.showFail(view: self.view, text: "请输入正确手机号")
            return
        }
        
        if pw.count == 0   {
            CommonTool.showFail(view: self.view, text: "请输入密码")
            return
        }
        
        let parm = ParamLogin.init()
        parm.mobile = mobile
        parm.password = pw
        
        LoginTool.login(params: parm.toJSON()!, success: { (res) in
            if res.success{
                self.navigationController?.popToRootViewController(animated: true)
                self.dismiss(animated: true, completion: {
                    if let _ = self.blockLoginSuccess{
                        self.blockLoginSuccess!()
                    }
                })
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
        
    }
    @IBAction func btnActionForgetPW(_ sender: Any) {
        navigationController?.pushViewController(RetrievePwViewController(), animated: true)
    }

    @IBAction func btnActionRegister(_ sender: Any) {
        let regisVC = RegisterViewController()
        navigationController?.pushViewController(regisVC, animated: true)
        regisVC.delegate = self
        
//        regisVC.testblock { (str) in 
//            print(str)
//        }
        
        regisVC.block_z =  { str in
                print(str)
        }
    }
    
    
   
    @IBAction func btnActionThirdQQ(_ sender: Any) {
        let param: ParamLoginThird = ParamLoginThird()
        param.type = 1
        let model :ModelUser = CommonTool.unarhiveUserData()
        if model.qqUnionId.count > 0 {
            param.unionId = model.qqUnionId
        }
        LoginTool.thirdLogin(params: param.toJSON()!, success: { ( res) in
            if res.success{
                
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "isLogin")
                self.navigationController?.popToRootViewController(animated: true)
                self.dismiss(animated: true, completion: {
                    if let _ = self.blockLoginSuccess{
                        self.blockLoginSuccess!()
                    }
                })
                
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
    @IBAction func btnActionThirdWX(_ sender: Any) {
        let param: ParamLoginThird = ParamLoginThird()
        param.type = 0
        let model :ModelUser = CommonTool.unarhiveUserData()
        param.unionId = model.wxUnionId
            
        LoginTool.thirdLogin(params: param.toJSON()!, success: { ( res) in
            if res.success{
                
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "isLogin")
                self.navigationController?.popToRootViewController(animated: true)
                self.dismiss(animated: true, completion: {
                    if let _ = self.blockLoginSuccess{
                        self.blockLoginSuccess!()
                    }
                })
                
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
    @IBAction func btnActionThirdWB(_ sender: Any) {
        let param: ParamLoginThird = ParamLoginThird()
        param.type = 2
        let model :ModelUser = CommonTool.unarhiveUserData()
        param.unionId = model.sinaUnionId
        
        LoginTool.thirdLogin(params: param.toJSON()!, success: { ( res) in
            if res.success{
                
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "isLogin")
                self.navigationController?.popToRootViewController(animated: true)
                self.dismiss(animated: true, completion: {
                    if let _ = self.blockLoginSuccess{
                        self.blockLoginSuccess!()
                    }
                })
                
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
    @IBAction func btnActionEye(_ sender: Any) {
        let btn: UIButton = sender as! UIButton
        btn.isSelected = !btn.isSelected
        
        self.TextFieldPW.isSecureTextEntry = !btn.isSelected
    }
}
extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(textField.text ?? "a")
        return true;
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(TextFieldPW.text)
        print(TextFieldUser.text)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == TextFieldUser {
            TextFieldPW.becomeFirstResponder()
        }
        return true
    }
}

extension LoginViewController: RegisterViewControllerDelegate {
    func RegisterViewControllerDelegateSucc(_ str: String) {
        
        print("get  RegisterViewControllerDelegateSucc "+"   " + str)
    }
     
}

