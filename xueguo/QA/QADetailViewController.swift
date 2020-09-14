//
//  QADetailViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/27.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class QADetailViewController: BaseViewController {

    var questionId:String?
//----------------------------------------------------
    var dataArr = [ModelQaDetail]()
    var dataArrHeight = [CGFloat]()
    
    var blockRepeal:BaseBlock?
  
    
    var tableView:UITableView?
    let uniIdAns:String = "QAAnsTableViewCellId"
    let uniIdAsk:String = "QAAskTableViewCellId"
    let uniIdAccept:String = "QAAnsAcceptTableViewCellId"
    var downView: UIView?
    var askView: QAAskView?
    var flagAskRect: CGRect?
    var flagLeftBtn: UIButton?
     //MARK: --sys--------
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
        self.title = "问答详情"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(notifi:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(notifi:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
     }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardDisappear(notifi:Notification){
        // 获取键盘信息
        
        UIView.animate(withDuration: 0.618) {
            self.askView?.frame = self.flagAskRect!
        }
    }
    @objc func keyboardAppear(notifi:Notification){
//        notifi.userInfo[keyboardfr]
        // 获取键盘信息
        let keyboardinfo = notifi.userInfo![UIResponder.keyboardFrameBeginUserInfoKey]
        let h:CGFloat = ((keyboardinfo as AnyObject).cgRectValue.size.height)

        var frame = self.askView?.frame
        frame?.origin.y -= (h - 44)
        UIView.animate(withDuration: 0.618) {
            self.askView?.frame = frame!
        }
        
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
        if let _ = self.blockRepeal{
            self.blockRepeal!("")
        }
    }

    func setupViews() {
        setupDownView()
        setupAskView()
        setupTableView()
    }
    func setupAskView(){
        let h :CGFloat = 230
        let y: CGFloat = (self.downView?.minY())! - h - 44
        let v = UINib.init(nibName: "QAAskView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! QAAskView
        v.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h)
        self.view.addSubview(v)
        self.askView = v
        self.view.bringSubviewToFront(v)
        flagAskRect = v.frame
         
    }
    func setupDownView(){
        let h :CGFloat = 60
        let v = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - h, width: SCREEN_WIDTH, height: h))
        self.view.addSubview(v)
        self.downView = v
        v.backgroundColor = .white
        let standW: CGFloat = (SCREEN_WIDTH - 16 - 16 - 5) / 3
        let btnH:CGFloat = 40
        let lBtn = UIButton.init(frame: CGRect.init(x: 16, y: 10, width: standW, height: btnH))
        v.addSubview(lBtn)
        CommonTool.addCornerRadius(size: CGSize.init(width: standW, height: btnH), layer: lBtn.layer, cornerSize: CGSize.init(width: btnH/2, height: btnH/2), arr: [UIRectCorner.topLeft,UIRectCorner.bottomLeft])
        
//        lBtn.backgroundColor = UIColor.colorWithHex(hexStr: "EFA33F")
//        lBtn.setTitle("采纳", for: .normal)
        
        lBtn.backgroundColor = UIColor.colorWithHex(hexStr: "#CCCCCC")
        lBtn.setTitle("撤销", for: .normal)
       
        lBtn.addTarget(self, action: #selector(btnActionLeft(_:)), for: .touchUpInside)
        flagLeftBtn = lBtn;
        
        let rbtn = UIButton.init(frame: CGRect.init(x: lBtn.maxX()+5, y: 10, width: standW * 2, height: btnH))
        v.addSubview(rbtn)
        CommonTool.addCornerRadius(size: CGSize.init(width: standW*2, height: btnH), layer: rbtn.layer, cornerSize: CGSize.init(width: btnH / 2, height: btnH/2), arr: [UIRectCorner.topRight,UIRectCorner.bottomRight])
        CommonTool.addGradientColo(rbtn.layer, CGSize.init(width: standW * 2, height: btnH), ["#91DD8A","#55C77A"])
        rbtn.setTitle("提交", for: .normal)
        rbtn.addTarget(self, action: #selector(btnActionRight), for: .touchUpInside)
    }
    func setupTableView(){
        var h :CGFloat = SCREEN_HEIGHT
        // 非采纳时 页面变化
        h =  (self.askView?.minY())!
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: h), style: .plain)
        self.view.addSubview(tableView!)
        tableView?.dataSource = self as UITableViewDataSource
        tableView?.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "QAAskTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: uniIdAsk)
        tableView?.separatorStyle = .none
        
        tableView?.backgroundColor = UIColor.colorWithHex(hexStr: "#F9F9F9")
        let nibAns :UINib = UINib.init(nibName: "QAAnsTableViewCell", bundle: nil)
        tableView?.register(nibAns, forCellReuseIdentifier: uniIdAns)
        
        
        
        let nibAccept :UINib = UINib.init(nibName: "QAAnsAcceptTableViewCell", bundle: nil)
        tableView?.register(nibAccept, forCellReuseIdentifier: uniIdAccept)
        
        
        
        //tableFooterview
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        tableView?.tableFooterView = v
        //        v.backgroundColor =
        let lab = UILabel.init(frame: v.bounds)
        lab.textAlignment = .center
        lab.text = "暂无回答"
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = UIColor.colorWithHex(hexStr: "#9B9B9B")
        v.addSubview(lab)
        
        self.view.bringSubviewToFront(self.askView!)
    }
    

     //MARK: ----action--------
    @objc func btnActionLeft(_ btn:UIButton){
        let title:String  = btn.titleLabel!.text!
        if title == "撤销"{
            requestDataRepeal()
        }else{// 采纳
            requestDataAccept()
        }
    }
    @objc func btnActionRight(){
        let param : ParamQaAskAgain = ParamQaAskAgain()
        if self.askView?.textView.text.count == 0 {
            CommonTool.showFail(view: self.view, text: "请填写追问内容")
            return
        }
//        param.questionId = Int(self.questionId!)
        param.questionId = self.questionId?.toInt()
        param.answer = self.askView?.textView.text
        param.teacherId = dataModel!.teacherId.toInt()
        
        QATool.askAgain(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.requestData()
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    
    }
  
     //MARK: ----request--------
    func getAcceptForAnswerId() -> String{
        let arrAns: [ModelQaAnswer] = (dataModel?.answerList.filter{
            return $0.type == 0
            })!
        let model: ModelQaAnswer = arrAns.last!
        return model.id
    }
    func requestDataAccept(){
        let param : ParamQaAccept = ParamQaAccept()
        param.studentId = CommonTool.getUserId()
        param.questionId = self.questionId?.toInt()
        param.answerId = getAcceptForAnswerId().toInt()
        QATool.accept(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.requestData()
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
  
    func requestDataRepeal(){
        let param: ParamQaRepeal = ParamQaRepeal()
        param.questionId = self.questionId?.toInt()
        param.studentId = CommonTool.getUserId()
        QATool.repealQa(params: param.toJSON()!, success: { ( res) in
            if res.success{
                if self.dataModel?.answerList.count == 0{
                   self.back()
                }else
                {
                     self.requestData()
                }
               
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    func requestData(){
     
        let param: ParamQaDetail = ParamQaDetail()
        param.questionId = questionId
        QATool.detail(params: param.toJSON()!, success: { ( res) in
            if res.success{
                let model: ModelQaDetail = res.data as! ModelQaDetail
//                self.dataArr.append(model)
                self.dataModel = model
                
                self.dealModelToNumberOfRows(model: model)
                self.getHeight()
                
                self.checkAllUnRead()
                self.tableView?.reloadData()
                self.checkAcept()
                
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
 
    
    var numberOfRows = 0;
    var dataModel: ModelQaDetail?
    
    // 根据模型 生成总数量 包含 问 追问 回答 type 01 回答 追问  status 01 未采纳 已采纳
    
    func dealModelToNumberOfRows(model:ModelQaDetail){
//        model.ztype = 0
//
        numberOfRows = 1
//        self.dataArr.append(model)
        let answerList = model.answerList
        if  answerList.count > 0 {
            numberOfRows += answerList.count
        }
    }
    // 验证 底部按钮是否展示位  采纳
    func  checkAcept(){
        if (dataModel?.answerList.count)! > 0{
            let arrType = dataModel?.answerList.map{
                return $0.type
            }
            if (arrType?.contains(0))!{
                flagLeftBtn?.setTitle("采纳", for: .normal)
                flagLeftBtn?.backgroundColor = UIColor.colorWithHex(hexStr: "EFA33F")
            }
            let arrStatus = dataModel?.answerList.map{
                return $0.status
            }
            if (arrStatus?.contains(1))!{ // 包含采纳
                self.downView?.isHidden = true
                self.askView?.isHidden  = true
                self.tableView?.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
//                flagLeftBtn!.backgroundColor = UIColor.colorWithHex(hexStr: "#CCCCCC")
//                flagLeftBtn!.setTitle("撤销", for: .normal)
            }
        }
    }
    func getHeight(){
        
        let w :CGFloat = SCREEN_WIDTH - 16*2 - 73 - 13
        var h:CGFloat = CommonTool.getAttributionHeightWithString(str: self.dataModel!.question, width: w)
        if h > 36 {
            h += 74
        }else
        {
            h = 110
        }
        dataArrHeight.append(h)
        
        if (self.dataModel?.answerList.count)! > 0 {
            for model: ModelQaAnswer in self.dataModel!.answerList{
                let type = model.type
                if type == 1{ // 追问
//                    let w :CGFloat = SCREEN_WIDTH - 16*2 - 73 - 13
                    var h:CGFloat = CommonTool.getAttributionHeightWithString(str: model.answer, width: w)
                    if h > 36 {  h += 74  }else {  h = 110 }
                    dataArrHeight.append(h)
                    
                }else{ //if type == 0 //回答
                    
//                    let w: CGFloat = SCREEN_WIDTH - 16 * 2 - 73 - 13
//                        let h: CGFloat = 60 + 50
                    // if h > 50 -> 60 + true else 110
                    
                    // accept
//                    let w: CGFloat = SCREEN_WIDTH - 16 * 2 - 73 - 13
//                    let h: CGFloat = 40+20 + 26 // 24
                    let status = model.status
                    if status == 1{ //  已采纳
                        var h:CGFloat = CommonTool.getAttributionHeightWithString(str: model.answer, width: w)
                        if h > 24 {  h += 86  }else  {   h = 110 }
                        dataArrHeight.append(h)
                    }else{ // 0  未采纳
                        var h:CGFloat = CommonTool.getAttributionHeightWithString(str: model.answer, width: w)
                        if h > 50 {  h += 60  }else  {   h = 110 }
                        dataArrHeight.append(h)
                    }
                   
                }
            }
        }
        
        
    }
    // 是否全部都为 未读消息  若有回答  隐藏tablefooterview
    func checkAllUnRead() {
        
        if dataModel?.answerList.count == 0 {
            return
        }
        let arrType = dataModel?.answerList.map{
            return $0.type
        }
        if (arrType?.contains(0))!{
            self.tableView?.tableFooterView  = UIView.init()
        }
        
    }
}


extension QADetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell : QAAskTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniIdAsk, for: indexPath) as! QAAskTableViewCell
            cell.conH = self.dataArrHeight[indexPath.row]
            cell.model = dataModel
            return cell
        }else
        {
            let model:ModelQaAnswer = (dataModel?.answerList[indexPath.row - 1])!
            if model.type == 1{ //追问
                let cell : QAAskTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniIdAsk, for: indexPath) as! QAAskTableViewCell
                cell.conH = self.dataArrHeight[indexPath.row]

                cell.modelAnswer = model
                return cell
                
            }else { // if model.type == 0  // 回答
                
                let status = model.status
                if status == 1 { // 已采纳
                    let cell : QAAnsAcceptTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniIdAccept, for: indexPath) as! QAAnsAcceptTableViewCell
//                    cell.conH = self.dataArrHeight[indexPath.row]
                    cell.model = model
                    return cell

                }else{ // 未采纳
                    let cell : QAAnsTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniIdAns, for: indexPath) as! QAAnsTableViewCell
                    cell.conH = self.dataArrHeight[indexPath.row]
                    cell.model = model
                    return cell

                }
                
            }
        }
        
    }
  
}
extension QADetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let h = dataArrHeight[indexPath.row]
        return h
 
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell : QAAskTableViewCell = tableView.cellForRow(at: indexPath) as! QAAskTableViewCell
//        let cell : QAAnsTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniIdAns, for: indexPath) as! QAAnsTableViewCell

        
    }
   
}
