//
//  MyRegisterAddViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/24.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class MyRegisterAddViewController: UIViewController {

    
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldCompay: UITextField!
    
    @IBOutlet weak var labIndustry: UILabel!
    
    @IBOutlet weak var textViewDetail: UITextView!
    @IBOutlet weak var labMoney: UILabel!
    @IBOutlet weak var labPosition: UILabel!
    @IBOutlet weak var labTimeEnd: UILabel!
    @IBOutlet weak var labTimeStart: UILabel!
    @IBOutlet weak var labWorkAddress: UILabel!
    
    @IBOutlet weak var btnSave: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfiguration()
        setupViews()
        requestData()
        // Do any additional setup after loading the view.
    }
    func baseConfiguration() -> Void {
        CommonTool.addGradientColo(self.btnSave.layer, CGSize.init(width: SCREEN_WIDTH, height: 50), ["#99CCFC","#5797F7"])
        self.title = "填写就业登记"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
        self.textViewDetail.delegate = self
        
 
        let toolbar = CommonTool.inputAccessoryView(self, #selector(disAppleKeyboard), CGSize.init(width: SCREEN_WIDTH, height: 50))
        
        self.textFieldCompay.inputAccessoryView = toolbar
        self.textFieldAddress.inputAccessoryView = toolbar
        self.textViewDetail.inputAccessoryView = toolbar

    }
  
    @objc func disAppleKeyboard(){
        self.view.endEditing(true)
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }
    func setupViews() {
        
    }
    func requestData(){
        
    }

    @IBAction func btnActionIndustry(_ sender: Any) {
    }
    
    @IBAction func btnActionAddress(_ sender: Any) {
    }
    
    
    @IBAction func btnActionTimeBegin(_ sender: Any) {
    }
    
    @IBAction func btnActionTimeEnd(_ sender: Any) {
    }
    @IBAction func btnActionPosition(_ sender: Any) {
    }
    @IBAction func btnActionMoney(_ sender: Any) {
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    @IBAction func btnActionSave(_ sender: Any) {
        
    }
    
    
    
    //MARK: --------------------request-------------------
    func requestDataPosition(){
        let param:ParamJob = ParamJob.init()
        param.parentCode = "0"
        MeTool.position(params: param.toJSON()!, success: { ( res) in
            if res.success{
                let arr:[ModelPosition] = res.arr as! [ModelPosition]
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    func requestDataIndustry(code:String){
        let param:ParamJob = ParamJob.init()
        param.parentCode = code
        MeTool.industry(params: param.toJSON()!, success: { ( res) in
            if res.success{
                let arr:[ModelIndustry] = res.arr as! [ModelIndustry]
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
}

extension MyRegisterAddViewController: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.6) {
            var dif: CGFloat = 200
            if isX() {
                dif = 50
            }
             self.view.frame = CGRect.init(x: 0, y: -dif, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.6) {
            self.view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        }
    }
}
