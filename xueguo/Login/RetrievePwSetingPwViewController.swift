//
//  RetrievePwSetingPwViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/24.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit

class RetrievePwSetingPwViewController: UIViewController {

    var vcode:String?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @IBOutlet weak var textFieldNewPw: UITextField!
    @IBOutlet weak var textFieldNewPwAgain: UITextField!

    var block_quit: (() -> Void)?
    var mobile:String? 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        baseConfiguration()
        
    }
    
    func requestData(){
        
        
        let param :ParamUpdatePw = ParamUpdatePw()
        param.mobile =  self.mobile
        param.password = self.textFieldNewPw.text
        param.code = self.vcode ?? "0"
        
        MeTool.updatePw(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.navigationController?.popToRootViewController(animated: true)
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
    func baseConfiguration() -> Void {
        
    }
     @IBAction func btnActionSure(_ sender: Any) {
        if self.textFieldNewPw.text?.count == 0 {
            CommonTool.showFail(view: self.view, text: "请输入密码")
            return
        }
        if self.textFieldNewPw.text != self.textFieldNewPwAgain.text {
            CommonTool.showFail(view: self.view, text: "两次输入密码不同")
            return
        }
        
        requestData()
     }
    @IBAction func back(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
        if let  _ = block_quit{ 
            block_quit!()
        }
    }
    
}
