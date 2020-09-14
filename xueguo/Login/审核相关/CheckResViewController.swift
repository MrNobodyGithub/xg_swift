//
//  CheckResViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/25.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit

class CheckResViewController: UIViewController {

   
    
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var viewBody: UIView!
    @IBOutlet weak var btnEditing: UIButton!
    
    // view status subviews
    @IBOutlet weak var imageStatus: UIImageView!
    
    @IBOutlet weak var labStatus: UILabel!
    // view body subviews
    @IBOutlet weak var labName: UILabel!
    @IBOutlet weak var labSex: UILabel!
    @IBOutlet weak var labID: UILabel!
    @IBOutlet weak var labClassNumber: UILabel!
    @IBOutlet weak var labClassNumber1: UILabel!
    @IBOutlet weak var labClassNumber2: UILabel!
    @IBOutlet weak var labClassNumber3: UILabel!
    @IBOutlet weak var labClassNumber4: UILabel!

    @IBOutlet weak var labStudentNumber: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        baseConfiguration()
        requestData()
    }
    
    var modelInfo:ModelUser?
    func requestData(){
        let param: ParamGetUserInfo = ParamGetUserInfo()
        param.userId = CommonTool.getUserId()
        
        MeTool.getUserInfo(params: param.toJSON()!, success: { ( res) in
            if res.success{
                let model:ModelUser = CommonTool.unarhiveUserData()
                self.modelInfo = model
                //studentName sex cardID classId
//                collegeName majorName className
                self.labName.text = model.studentName
                self.labSex.text = self.getSexStr(model)
                self.labID.text = model.cardID
                self.labClassNumber.text = model.classNo
                self.labClassNumber1.text = model.collegeName
                self.labClassNumber2.text = model.academyName
                self.labClassNumber3.text = model.majorName
                self.labClassNumber4.text = model.grade + "级" + model.classNumber
                self.labStudentNumber.text = model.studentNo;
                
                if model.status  == "1" { //ing
                    self.imageStatus.image = UIImage.init(named: "checking")
                    self.labStatus.text =  "已提交资料加入班级，请等待老师审核！"
                    self.labStatus.textColor = UIColor.colorWithHex(hexStr: "676565")
                }else if model.status == "3"{ //fail
                    self.imageStatus.image = UIImage.init(named: "check_fail")
                    self.labStatus.text =  "申请被驳回！"
                    self.labStatus.textColor = UIColor.colorWithHex(hexStr: "EA672E")
                }else if model.status == "2" || model.status == "4"{
                    self.navigationController?.popToRootViewController(animated: true)
                    
                }
                 
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
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
    func baseConfiguration() -> Void {
        viewStatus.backgroundColor = .white
        viewStatus.layer.shadowColor = UIColor.black.cgColor
        viewStatus.layer.borderWidth = 0.01
        viewStatus.layer.borderColor = viewStatus.layer.shadowColor
        viewStatus.layer.shadowOpacity = 0.4
        viewStatus.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        
        
        viewBody.backgroundColor = .white
        viewBody.layer.shadowColor = UIColor.black.cgColor
        viewBody.layer.borderWidth = 0.01
        viewBody.layer.borderColor = viewBody.layer.shadowColor
        viewBody.layer.shadowOpacity = 0.4
        viewBody.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        
        
        //定义渐变的颜色（从黄色渐变到橙色）
        let topColor = UIColor.colorWithHex(hexStr: "91DD8A")
        let buttomColor = UIColor.colorWithHex(hexStr: "54C77A")
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        let  size = CGSize.init(width: SCREEN_WIDTH - 2 * 67.0, height: 46.0)
        gradientLayer.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
        btnEditing.layer.insertSublayer(gradientLayer, at: 0)
    
        
    }

    @IBAction func btnActionEditing(_ sender: Any) {
        let vc = CheckViewController.init(nibName: "CheckViewController", bundle: nil)
        if self.modelInfo != nil {
            vc.model = self.modelInfo
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnActionRefresh(_ sender: Any) {
        requestData()
    }
    @IBAction func btnActionScan(_ sender: Any) {
        
    }
    
}

