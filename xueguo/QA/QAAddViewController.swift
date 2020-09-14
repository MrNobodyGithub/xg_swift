//
//  QAAddViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/27.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class QAAddViewController: UIViewController {

    var flagLabNumber: UILabel?
    var flagLabTeacher: UILabel?
    var shadowView: UIView?
    var flagTextView: UITextView?
    var arrTeacher: [ModelTeacher] = [ModelTeacher]()
    var selTeacherModel: ModelTeacher?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
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
        self.view.backgroundColor = .white
        self.title = "发起提问"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
  
    func setupViews() {
        let v1 = setupShadowView(NAV_HEIGHT+STATUS_HEIGHT)
        let v2 = setupTitleView("提问内容", y: v1.maxY())
        let v3 = setupTextView(y: v2.maxY()+20)
        let v4 = setupShadowView(v3.maxY()+20)
        let v5 = setupTitleView("向谁提问", y: v4.maxY()+5)
        let v6 = setupTeacherView(y: v5.maxY()+20)
        
        let v = UIView.init(frame: CGRect.init(x: 0, y: v6.maxY() + 38, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.view.addSubview(v)
        v.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        
        setupSubmit(y: v6.maxY() + 38 + 26)
    }
    func setupSubmit(y:CGFloat){
        let btn = UIButton.init(frame: CGRect.init(x: 16, y: y, width: SCREEN_WIDTH-32, height: 40))
        self.view.addSubview(btn)
        btn.layer.cornerRadius = 20
        btn.setTitle("提交", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(btnActionSubmit), for: .touchUpInside)
        CommonTool.addGradientColo(btn.layer, btn.frame.size, ["#91DD8A","#55C77A"])
        btn.layer.masksToBounds = true
    }
   
    func setupTeacherView(y:CGFloat) -> UIView{
        let h:CGFloat = 35
        let difL :CGFloat = 16
        let v:UIView = UIView.init(frame: CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h))
        self.view.addSubview(v)
        
        let btn = UIButton.init(frame: CGRect.init(x: difL, y: 0, width: SCREEN_WIDTH - difL*2, height: h))
        v.addSubview(btn)
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor.colorWithHex(hexStr: "#F9F9F9")
        btn.addTarget(self, action: #selector(btnActionTeacher), for: .touchUpInside)
        
        let lab = UILabel.init(frame: CGRect.init(x: btn.frame.origin.x + 13, y: btn.frame.origin.y, width: 100, height: h))
        v.addSubview(lab)
        lab.text = "选择老师"
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = UIColor.colorWithHex(hexStr: "#242D39")
        flagLabTeacher = lab
        
        let img = UIImageView.init(frame: CGRect.init(x: btn.frame.maxX - 26 - 14, y: btn.frame.minY , width: 14, height: 8))
        v.addSubview(img)
        img.center = CGPoint.init(x: img.center.x, y: btn.center.y)
        img.image = UIImage.init(named: "arrow_down_detail")
        
        return v
    }
    @objc func tapGes(_ ges:UITapGestureRecognizer){
        shadowView?.removeFromSuperview()
    }
    @objc func btnActionTeacher(){
        
        if self.arrTeacher.count <= 0 {
            return
        }
        
        self.flagLabTeacher?.text = self.arrTeacher[0].teacherName
        selTeacherModel = self.arrTeacher[0]
        
        // 0 shadowView
        shadowView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.view.addSubview(shadowView!)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapGes(_:)))
        shadowView!.addGestureRecognizer(tap)
        
        let sview : UIView = UIView.init(frame: shadowView!.bounds)
        sview.backgroundColor = UIColor.RGBAColorSame(r: 0, a: 0.4)
        
        shadowView?.addSubview(sview)
        
        
        
        let h: CGFloat = 200
    
       let picker = UIPickerView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - h, width: SCREEN_WIDTH, height: h))
        shadowView!.addSubview(picker)
        picker.delegate = self as UIPickerViewDelegate
        picker.dataSource = self as UIPickerViewDataSource
        
        picker.backgroundColor = .white
        
        let v = UIView.init(frame: CGRect.init(x: 0, y: picker.minY() - 40, width: SCREEN_WIDTH, height: 40))
        shadowView!.addSubview(v)
        v.backgroundColor = UIColor.RGBColor(r: 249, g: 249, b: 249)
        let btnH:CGFloat = 40
        let btnW:CGFloat = 100
        let leftBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: btnW, height: btnH))
        v.addSubview(leftBtn)
        leftBtn.setTitle("取消", for: .normal)
        leftBtn.setTitleColor(.gray, for: .normal)
        leftBtn.addTarget(self, action: #selector(btnActionQuit), for: .touchUpInside)
        
        let rightBtn = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH-btnW, y: 0, width: btnW, height: btnH))
        v.addSubview(rightBtn)
        rightBtn.setTitle("确定", for: .normal)
        rightBtn.setTitleColor(UIColor.RGBColor(r: 114, g: 180, b: 252), for: .normal)
        rightBtn.addTarget(self, action: #selector(btnActionSure), for: .touchUpInside)
        
        
    }
    @objc func btnActionQuit(){
        self.shadowView?.removeFromSuperview()
        
    }
    @objc func btnActionSure(){
        self.shadowView?.removeFromSuperview()
        
    }
    @objc func btnActionSubmit(){
        
        if selTeacherModel == nil {
            CommonTool.showFail(view: self.view, text: "请选择老师")
             return
        }
        if flagTextView?.text.count == 0 {
            
            CommonTool.showFail(view: self.view, text: "请输入问题")
            return
        }
        
        let teacherId = selTeacherModel?.id
        let strTextView = flagTextView?.text
       
        if strTextView?.count == 0{
            CommonTool.showFail(view: self.view, text: "请输入问题")
            return
        }
        let param = ParamQaAdd.init()
        param.studentId = CommonTool.getUserId()
        param.teacherId = teacherId
        param.question = strTextView
        QATool.addQuestion(params: param.toJSON()!, success: { ( res) in
            if res.success{
                let vc = QAViewController()
                self.navigationController?.pushViewController(vc, animated: true) 
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
     
       
    }
    @objc func back(){
        self.navigationController?.popViewController(animated:true)
    }
    
    func setupTextView(y:CGFloat) -> UIView{
        let h:CGFloat = 142
        let v:UIView = UIView.init(frame: CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h))
        self.view.addSubview(v)
        
        let textView:UITextView = UITextView.init(frame: CGRect.init(x: 16, y: 0, width: SCREEN_WIDTH - 32, height: h))
        flagTextView = textView
        v.addSubview(textView)
        textView.backgroundColor = UIColor.colorWithHex(hexStr: "#F9F9F9")
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
        textView.font = UIFont.systemFont(ofSize: 15)
//        print("---   ---");
//        CommonTool.logIvar(UITextView.self)
        textView.delegate = self
        
        let toolbar = CommonTool.inputAccessoryView(self, #selector(disAppleKeyboard), CGSize.init(width: SCREEN_WIDTH, height: 50))
        textView.inputAccessoryView = toolbar
        textView.addPlaceHolder(placeText: "请尽量将问题描述详细")
        
        let labNum:UILabel = UILabel.init(frame: CGRect.init(x: v.frame.width - 100 - 20, y: v.frame.height - 20 - 10, width: 100, height: 20))
        v.addSubview(labNum)
        labNum.text = "（0/500）"
        labNum.font = UIFont.systemFont(ofSize: 13)
        labNum.textColor = UIColor.colorWithHex(hexStr: "#A9A9A9")
        flagLabNumber = labNum
        labNum.textAlignment = .right
        return v
    }
    @objc func disAppleKeyboard(){
        self.view.endEditing(true)
    }
    func setupTitleView(_ title:String, y:CGFloat) -> UIView{
        
        let v:UIView = UIView.init(frame: CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: 40))
        self.view.addSubview(v)
        
        let w:CGFloat = 3
        let h:CGFloat = 14
        
        let difL:CGFloat = 16
        let difT:CGFloat = 30
        let vflag = UIView.init(frame: CGRect.init(x: difL, y: difT, width: w, height: h))
        vflag.layer.cornerRadius = 1
        vflag.layer.masksToBounds = true
        vflag.backgroundColor = UIColor.colorWithHex(hexStr: "#77D483")
        v.addSubview(vflag)
        
        let lab:UILabel = UILabel.init(frame: CGRect.init(x: vflag.maxX() + 10, y: 0, width: 100, height: 21))
        lab.text = title
        lab.center = CGPoint.init(x: lab.center.x, y: vflag.center.y)
        v.addSubview(lab)
        lab.font = UIFont.boldSystemFont(ofSize: 15)
       
        return v
        
        
    }
    func setupShadowView(_ y:CGFloat) -> UIView {
        let v: UIView = UIView.init(frame: CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: 12))
        v.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        self.view.addSubview(v)
        return v
    }
    
    func requestData(){
        requestDataTearchList()
    }
    func requestDataTearchList(){
        
        
        QATool.getTearchList(success: { ( res) in
            if res.success{
                self.arrTeacher = res.arr as! [ModelTeacher]
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}

//MARK:UIPickerViewDelegate
extension QAAddViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let model: ModelTeacher = arrTeacher[row]
        return model.teacherName
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let model: ModelTeacher = arrTeacher[row]
        flagLabTeacher?.text = model.teacherName
        selTeacherModel = arrTeacher[row]
    }
}
//MARK:UIPickerViewDataSource
extension QAAddViewController:UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        for line in pickerView.subviews{
            if line.frame.height < 1{
                line.backgroundColor = UIColor.RGBColor(r: 50, g: 50, b: 50)
            }
        }
      
        let model: ModelTeacher = arrTeacher[row]
        let lab: UILabel = UILabel.init()
        lab.text = model.teacherName
        lab.textColor = .black
        lab.font = UIFont.systemFont(ofSize: 23)
        lab.textAlignment = .center
        return lab
        
       
//        let v:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 1))
//        v.backgroundColor = .lightGray
//        return v
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrTeacher.count
    }
    
    
}
extension QAAddViewController:UITextViewDelegate{
 
    func textViewDidChangeSelection(_ textView: UITextView) {
        let count = textView.text.count
        let str = textView.text
        let threshould : Int = 500
        if count > threshould {
            let stra:String = String(str!.prefix(threshould))
            textView.text = stra
            return
        }
        
        flagLabNumber?.text = "(\(count)/500)"
    } 
}
