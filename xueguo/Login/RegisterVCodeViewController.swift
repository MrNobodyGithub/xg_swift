//
//  RegisterVCodeViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/24.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit 

enum ComeFrom {
    case Def
    case register //l来自 注册页面
    case RetrievePw // 来自 忘记密码
}

class RegisterVCodeViewController: UIViewController {
    
    @IBOutlet weak var labError: UILabel!
    @IBOutlet weak var btnTime: UIButton!
//    60秒后重新获取验证码  CCCCCC 重新获取验证码 5BD18B
    @IBOutlet weak var labNumber: UILabel!
//    验证码已发送至 18018018018
    var comeFrom : ComeFrom = .Def
    var mobile: String = ""
    var timer : Timer?
    var timeCount : Int = 61
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var textField6: UITextField!
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        baseConfiguration()
//        requestDataGetVcode()
        
        
        self.labNumber.isHidden = false
        self.labNumber.text = "验证码已发送至 " + self.mobile
        self.btnTime.isHidden = false
        self.setupTimer()
        
    }
    // 验证验证码
    func requestDataVerifyCode(){
         
        let param :ParamVerifyCode = ParamVerifyCode.init()
        param.mobile = self.mobile
        param.code = getStrVCode()
        param.type = "1"
        switch comeFrom {
        case .Def:do{}
        case .register:do{  param.type = "1" }
        case .RetrievePw:do{ param.type = "3" }
        }
        let json: [String: Any] = param.toJSON()!
        LoginTool.verifyVcode(params: json, success: { (res) in
            if res.success {
                switch self.comeFrom{
                case .Def:do{}
                case .register:do{
                    let vc = RegisterSettingPwViewController()
                    vc.mobile = self.mobile
                    self.navigationController?.pushViewController( vc, animated: true)
                    
                    }
                case .RetrievePw: do{
                   let vc = RetrievePwSetingPwViewController()
                    vc.mobile = self.mobile
                    vc.vcode = param.code
                    vc.block_quit = {
                        self.textField1.text = ""
                        self.textField2.text = ""
                        self.textField3.text = ""
                        self.textField4.text = ""
                        self.textField5.text = ""
                        self.textField6.text = ""
                        self.textField1.becomeFirstResponder()
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                 
            }else{
//                CommonTool.showFail(view: self.view, text: res.message)
                self.labError.isHidden = false
                if res.message != nil && res.message.count != 0 {
                    
                    self.labError.text = res.message
                }
                self.textField1.text = ""
                self.textField2.text = ""
                self.textField3.text = ""
                self.textField4.text = ""
                self.textField5.text = ""
                self.textField6.text = ""
                self.textField1.becomeFirstResponder()
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    // 获得验证码
    func requestDataGetVcode() -> Void{
      
        let param : ParamGetVCode = ParamGetVCode.init()
        param.mobile = self.mobile
        param.type = "1"
        switch comeFrom {
        case .Def:do{}
        case .register:do{  param.type = "1" }
        case .RetrievePw:do{ param.type = "3" }
        
        }
        
        let json : [String:Any] = param.toJSON()!
        CommonTool.showLoading(view: self.view)
        LoginTool.getVcode(params: json, success: { (rep) in
            CommonTool.hideLoading(view: self.view)
            if rep.success {
                self.labNumber.isHidden = false
                self.labNumber.text = "验证码已发送至 " + self.mobile
                self.btnTime.isHidden = false
                self.setupTimer()
                
            }else{
                 CommonTool.showFail(view: nil, text: rep.message)
                self.navigationController?.popViewController(animated: true)
            }
        }, fail: {(err) in
            CommonTool.hideLoading(view: self.view)
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    func setupTimer (){
        if timer != nil {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeAction), userInfo: nil, repeats: true)
        timer?.fire()
    }
    @objc func timeAction(){
        timeCount -= 1
        if timeCount == 0{
            timeCount = 61
            btnTime.setTitle("重新获取验证码", for: .normal)
            btnTime.setTitleColor(UIColor.colorWithHex(hexStr: "5BD18B"), for: .normal)
            timer?.invalidate()
            timer = nil
            return
        }
        //    60秒后重新获取验证码  CCCCCC 重新获取验证码 5BD18B
        btnTime.setTitle(String(timeCount) + "秒后重新获取验证码", for: .normal)
        btnTime.setTitleColor(UIColor.colorWithHex(hexStr: "CCCCCC"), for: .normal)
    }
    deinit {
        timer?.invalidate()
        timer = nil
    }
    func baseConfiguration() -> Void {
        
        let cursorColor = UIColor.colorWithHex(hexStr: "66AD48")
        textField1.tintColor = cursorColor
        textField2.tintColor = cursorColor
        textField3.tintColor = cursorColor
        textField4.tintColor = cursorColor
        textField5.tintColor = cursorColor
        textField6.tintColor = cursorColor
        
        textField1.becomeFirstResponder()
        // Do any additional setup after loading the view.
        textField1.addTarget(self, action: #selector(textAction1), for: .editingChanged)
        textField2.addTarget(self, action: #selector(textAction2), for: .editingChanged)
        textField3.addTarget(self, action: #selector(textAction3), for: .editingChanged)
        textField4.addTarget(self, action: #selector(textAction4), for: .editingChanged)
        textField5.addTarget(self, action: #selector(textAction5), for: .editingChanged)
        textField6.addTarget(self, action: #selector(textAction6), for: .editingChanged)
        
        textField6.delegate = self as UITextFieldDelegate;
    }


    @objc  func textAction1() -> Void { textField2.becomeFirstResponder() }
    @objc  func textAction2() -> Void { textField3.becomeFirstResponder() }
    @objc  func textAction3() -> Void { textField4.becomeFirstResponder() }
    @objc  func textAction4() -> Void { textField5.becomeFirstResponder() }
    @objc  func textAction5() -> Void { textField6.becomeFirstResponder() }
    @objc  func textAction6() -> Void {
        textField6.resignFirstResponder()
        let list:NSArray = [textField1.text as Any,textField2.text as Any,textField3.text!,textField4.text!,textField5.text!,textField6.text!]
        let str = list.componentsJoined(by: "")
        print(str)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            switch self.comeFrom  {
            case .Def :do {
                print("Def")
                }
            case .RetrievePw:do {
                print("retrieve pw")
                self.requestDataVerifyCode()
                }
            case .register:do {
                print("register")
                self.requestDataVerifyCode()
                } }}
        
    }
    func getStrVCode() -> String{
        let str1 = self.textField1.text!
        let str2 = self.textField2.text!
        let str3 = self.textField3.text!
        let str4 = self.textField4.text!
        let str5 = self.textField5.text!
        let str6 = self.textField6.text!
        return str1+str2+str3+str4+str5+str6
    }
    

    @IBAction func btnActionQuit(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnActionTime(_ sender: UIButton) {
        requestDataGetVcode()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
}
extension RegisterVCodeViewController: UITextFieldDelegate{
    
}

