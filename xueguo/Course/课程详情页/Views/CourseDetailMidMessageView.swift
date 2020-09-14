//
//  CourseDetailMidMessageView.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/12.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailMidMessageView: UIView {
    
    
    
    //--------------------- in -------------------------------
    var teacherId:String?{
        didSet{
            self.requestDataList()
        }
    }
    var cloId:String?{
        didSet {
            self.requestDataList()
        }
    }
    var cloTitle:String?{
        didSet{
           self.labCloTitle.text = cloTitle ?? ""
        }
    }
    
    //--------------------- out -------------------------------
    
    @IBOutlet weak var labCloTitle: UILabel!
    
    //--------------------- pro -------------------------------
    @IBOutlet weak var tableView: UITableView!
//    var dataArr:[ModelCloMessageList] = []
    var modelInfo:ModelCloMessageList?
    var dataArrHeight:[CGFloat] = []
    var rectChat:CGRect?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var viewShadow: UIView!
    
    @IBOutlet weak var viewDown: UIView!
    @IBOutlet weak var viewChat: UIView!
    @IBOutlet weak var viewCon: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        baseConfiguration()
        setupViews()
        self.textField.delegate = self
    }

    func baseConfiguration() -> Void {
        rectChat = self.viewDown.frame
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapActionShadow))
        self.viewShadow.addGestureRecognizer(tap)
        
        let tapchat = UITapGestureRecognizer.init(target: self, action: #selector(tapActionChat))
        self.viewChat.addGestureRecognizer(tapchat)
        //获取键盘高度
    
         //监听当键将要退出时
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(noti:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisAppear(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    //MARK: --------------------views-------------------
    func setupViews(){
        CommonTool.addCornerRadius_fast(sizeW: SCREEN_WIDTH, sizeH: SCREEN_HEIGHT, layer: self.viewCon.layer, radius: 10, arr: [UIRectCorner.topLeft,UIRectCorner.topRight])
 
        let rect  = self.viewCon.frame
        var recta = rect
        recta.origin.y = SCREEN_HEIGHT
        self.viewCon.frame = recta;
        UIView.animate(withDuration: 0.3, animations: {
                  self.viewCon.frame = rect
              }) { (b) in
              }
        self.setupTableView()
        
    }

    var cellId = "CourseDetailMidMessageViewTableViewCellId"
    var cellId_answer = "CourseDetailMidMessageViewAnswerTableViewCellid"
    func setupTableView(){
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.register(UINib.init(nibName: "CourseDetailMidMessageViewTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        self.tableView.register(UINib.init(nibName: "CourseDetailMidMessageViewAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: cellId_answer)
//        self.tableView.keyboardDismissMode  = .onDrag
    }
    
    //MARK: --------------------request-------------------
    func requestDataSendMessage(){
        let check = self.kCheckInfoSendMessage()
        if check  {
            return
        }
        let param:ParamCloAddMessage = ParamCloAddMessage.init()
        param.type = 1
        param.questionId = self.modelInfo?.id.toInt()
        param.answer = self.textField.text!
        param.teacherId = self.teacherId?.toInt()
        CourseTool.requestCloAddMessage(params: param.toJSON()!, success: { ( res) in
            if res.success{
                CommonTool.showSuccess(view: self, text: res.message)
                self.requestDataList()
            }else{
                CommonTool.showFail(view: self, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self, text: MESSAGE_NETWORK_FAIL)
        })
        
    }
    func requestDataList(){
        if self.teacherId?.count ?? 0 > 0 && self.cloId?.count ?? 0 > 0   {
        }else
        {
            return
        }
        
        let param:ParamCloMessageList  = ParamCloMessageList.init()
        param.studentId = CommonTool.getUserId().toInt()
        param.cloId = cloId?.toInt()
        param.teacherId = self.teacherId?.toInt()
        CourseTool.requestCloMessageList(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.modelInfo = (res.data as! ModelCloMessageList)
                self.kgetCellsHeight()
                self.tableView.reloadData()
            }else{
                CommonTool.showFail(view: self, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self, text: MESSAGE_NETWORK_FAIL)
        })
    }
    //MARK: --------------------action-------------------
    @objc func keyboardAppear(noti:Notification){
        DispatchQueue.main.async {
            let userInfo = noti.userInfo
            let rect :CGRect = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            let h:CGFloat = rect.size.height
            var oriRect:CGRect = self.viewDown.frame
            oriRect.origin.y  -= h
            self.viewDown.frame = oriRect
        }
    }
    @objc func keyboardDisAppear(noti:Notification){
        DispatchQueue.main.async {
            let userInfo = noti.userInfo
            let rect :CGRect = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            let h:CGFloat = rect.size.height
            var oriRect:CGRect = self.viewDown.frame
            oriRect.origin.y  += h
            self.viewDown.frame = oriRect
        }
    }
    @objc func tapActionChat(){
        self.textField.resignFirstResponder()
    }
    @objc func tapActionShadow(){
        UIView.animate(withDuration: 0.3, animations: {
            var rect  = self.viewCon.frame
            rect.origin.y = SCREEN_HEIGHT
            self.viewCon.frame = rect
        }) { (b) in
            self.removeFromSuperview()
        }
    }
    
    //MARK: --------------------action-------------------
    @IBAction func btnActionEmoji(_ sender: Any) {
        self.textField.resignFirstResponder()
    }
    
    @IBAction func btnActionArrowDown(_ sender: Any) {
        self.tapActionShadow()
    }
    
    @IBAction func btnActionSend(_ sender: Any) {
        self.textField.resignFirstResponder()
        self.requestDataSendMessage()
    }
    //MARK: --------------------other-------------------
    func kCheckInfoSendMessage() -> Bool{
        if self.textField.text!.count == 0 {
            CommonTool.showFail(view: self, text: "请输入提问问题")
            return true
        }
        return false
    }
    func kgetCellsHeight(){
        // font 12
        // h 34 + 43 +
        //w 171 - 25
        // trueh + 27
        let question = self.modelInfo?.question
        
        let h_question = CommonTool.getAttributionHeightWithString(str: question ?? "", lineSpace: 5, fontSize: 12, width: 171 - 25)
        
        self.dataArrHeight.append(h_question + 27 + 34)
        for m:ModelCloMeeeageList_answer in self.modelInfo!.answerList {
            let answer = m.answer
            let h_answer = CommonTool.getAttributionHeightWithString(str: answer, lineSpace: 5, fontSize: 12, width: 171 - 25)
            self.dataArrHeight.append(h_answer + 27 + 34)
        }
    }
}

extension CourseDetailMidMessageView:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}



extension CourseDetailMidMessageView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.modelInfo != nil {
            return (self.modelInfo?.answerList.count)! + 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell : CourseDetailMidMessageViewTableViewCell  = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CourseDetailMidMessageViewTableViewCell
            cell.height = self.dataArrHeight[0];
            cell.model = self.modelInfo
            return cell
        }else
        {
            let cell :CourseDetailMidMessageViewAnswerTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId_answer, for: indexPath) as! CourseDetailMidMessageViewAnswerTableViewCell
            cell.height = self.dataArrHeight[indexPath.row]
            cell.model = self.modelInfo?.answerList[indexPath.row - 1]
            return cell
            
        }
    }
}
extension CourseDetailMidMessageView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataArrHeight.count != 0 {
            return self.dataArrHeight[indexPath.row]
        }
        return 77
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
