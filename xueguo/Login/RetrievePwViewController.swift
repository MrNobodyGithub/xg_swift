//
//  RetrievePwViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/24.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit

class RetrievePwViewController: UIViewController {
 
    @IBOutlet weak var textFieldUser: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnActionGetVcode(_ sender: Any) {
     
        guard let mobile = self.textFieldUser.text else {
            CommonTool.showFail(view: self.view, text: "请输入手机号")
            return
        }
        if mobile.count == 0 || mobile.count != 11 {
            CommonTool.showFail(view: self.view, text: "请填写正确手机号")
            return
        }
      
        self.requestDataGetVcode(succ: {
            let vcodeVc = RegisterVCodeViewController()
            vcodeVc.comeFrom = ComeFrom.RetrievePw
            vcodeVc.mobile = mobile
            self.navigationController?.pushViewController(vcodeVc, animated: true)
            
        })
        
        
    }
 
    
    
    // 获得验证码
    func requestDataGetVcode(succ:@escaping BaseBlockSuccess) -> Void{
        
        let param : ParamGetVCode = ParamGetVCode.init()
        param.mobile = self.textFieldUser.text
        param.type = "3"
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
    
    
 
    @IBAction func btnActionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
