//
//  CheckViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/24.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController {


    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldID: UITextField!
    @IBOutlet weak var textFieldClassNumber: UITextField!
    
    @IBOutlet weak var textFieldStudentId: UITextField!
    
    
    @IBOutlet weak var btnSex: UIButton!
    @IBOutlet weak var btnJoinClass: UIButton!
    
    var model:ModelUser?{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                
                self.textFieldName.text = self.model!.studentName
                self.btnSex.setTitle(self.getSexStr(self.model!), for: .normal)
//                self.btnSex.titleLabel?.text = self.getSexStr(self.model!)
                self.btnSex.setTitleColor(UIColor.colorWithHex(hexStr: "59C97B"), for: .normal)
                self.textFieldID.text = self.model!.cardID
                self.textFieldClassNumber.text = self.model!.classNo
                self.textFieldStudentId.text = self.model!.studentNo;
                self.textFieldClassNumber.adjustsFontSizeToFitWidth = true
                self.judgeContentFull()
            }
        }
    }
    var btnLayer: CALayer?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        self.navigationController?.navigationBar.isHidden = true
        //        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
    }
    @IBOutlet weak var viewContent: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        baseConfiguration()
    }
    func baseConfiguration() -> Void {
        self.view.backgroundColor = .white
 
        
        let toolbar = CommonTool.inputAccessoryView(self, #selector(keyboardFinish), CGSize.init(width: SCREEN_WIDTH, height: 44))
        
        self.textFieldClassNumber.inputAccessoryView = toolbar
        self.textFieldClassNumber.delegate = self
        self.textFieldID.delegate = self
        self.textFieldName.delegate = self
        self.textFieldStudentId.delegate = self;
        
      
        
        self.textFieldID.addTarget(self, action: #selector(textChange), for: .editingChanged)
        self.textFieldName.addTarget(self, action: #selector(textChange), for: .editingChanged)
        self.textFieldClassNumber.addTarget(self, action: #selector(textChange), for: .editingChanged)
        
        
        viewContent.backgroundColor = .white
        viewContent.layer.shadowColor = UIColor.black.cgColor
        viewContent.layer.borderWidth = 0.01
        viewContent.layer.borderColor = viewContent.layer.shadowColor
        viewContent.layer.shadowOpacity = 0.4
        viewContent.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        
    }
    @objc func textChange() -> Void {
        judgeContentFull()
    }
  

    @objc func keyboardFinish() {
        self.view.endEditing(true)
    }
    func getSexStr(_ model:ModelUser)  -> String{
        if model.sex == "2"{
            return "女"
        }else if model.sex == "1"{
            return "男"
        }else{
            return "-"
        }
    }
    
    @IBAction func btnActionSex(_ sender: Any) {
        let alertc = UIAlertController.init(title: "请选择性别", message: nil, preferredStyle: .actionSheet)
      
        
        let actionMan = UIAlertAction.init(title: "男", style: .default) { (action) in
            
            self.btnSex.setTitle("男", for: .normal)
            self.btnSex.setTitleColor(UIColor.colorWithHex(hexStr: "59C97B"), for: .normal)
            self.judgeContentFull()
        }
        alertc.addAction(actionMan)
        let actionWoman = UIAlertAction.init(title: "女", style: .default) { (action) in
            
            self.btnSex.setTitle("女", for: .normal)
            self.btnSex.setTitleColor(UIColor.colorWithHex(hexStr: "59C97B"), for: .normal)
            self.judgeContentFull()
        }
        alertc.addAction(actionWoman)
        
        let actionQuit = UIAlertAction.init(title: "退出", style: .cancel) { (action) in
            
        }
        alertc.addAction(actionQuit)
        self.present(alertc, animated: true) {
            
        }
    }
    
    @IBAction func btnActionJoinClass(_ sender: Any) {
        let errArr:[String] = ["请输入姓名","请选择性别","请输入身份证号","请输入班级代号","请输入学号"]
        if self.textFieldName.text?.count == 0{
            CommonTool.showFail(view: self.view, text: errArr[0])
            return
        }
        if self.btnSex.titleLabel?.text == "请选择" {
            CommonTool.showFail(view: self.view, text: errArr[1])
            return
        }
        if self.textFieldID.text?.count == 0{
            CommonTool.showFail(view: self.view, text: errArr[2])
            return
        }
        if self.textFieldClassNumber.text?.count == 0{
            CommonTool.showFail(view: self.view, text: errArr[3])
            return
        }
        if self.textFieldStudentId.text?.count == 0 {
            CommonTool.showFail(view: self.view, text: errArr[4])
            return
        }
        requestData()
    }
    func requestData(){
        let param: ParamUpdateInfo  = ParamUpdateInfo()
        param.studentName = self.textFieldName.text
        param.sex  = self.getSetStr()
        param.cardID = self.textFieldID.text
        param.classNo = self.textFieldClassNumber.text
        param.studentNo = self.textFieldStudentId.text
     
        MeTool.updateInfo(params: param.toJSON()!, success: { ( res) in
            if res.success{
               let vc = CheckResViewController.init()
                
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
        
    }
    func getSetStr() -> String{
        let str = self.btnSex.titleLabel?.text
        if str == "男"{
            return "1"
        }else if str == "女"{
            return "2"
        }else{
            return "0"
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func judgeContentFull() {
        btnJoinClass.setBackgroundImage(UIImage.init(named: "btnGray"), for: .normal)
        
        let strName = self.textFieldName.text
        let sex =  self.btnSex.title(for: .normal)
        let id = self.textFieldID.text
        let number = self.textFieldClassNumber.text
        if strName?.count ?? 0 > 0 && id?.count ?? 0 > 0 && number?.count ?? 0 > 0 {
            if sex?.count ?? 3 == 1{
                btnJoinClass.setBackgroundImage(UIImage.init(named: "btnGreen"), for: .normal)
            }
        }
        
     }
    
}
extension CheckViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
         return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.textFieldClassNumber {
            UIView.animate(withDuration: 0.5, animations: {
                var rect = self.view.frame
                rect.origin.y = -50
                self.view.frame = rect
            })
        }
      
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        if textField == self.textFieldClassNumber {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
            })
        }
       
    }
}
