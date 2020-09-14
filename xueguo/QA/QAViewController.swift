//
//  QAViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/23.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit
import MJRefresh
class QAViewController: UIViewController {

    var tableView:UITableView?
    let uniId:String = "QAListTableViewCellId"
    var topView: QATopView?
    var midView: QAMidView?
    var nullView: QANullView?
    var flagStatus: Int = -1
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfiguration()
        setupViews()
        requestData()
        setupRefresh()
        // Do any additional setup after loading the view.
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews() {
        setupTopView()
        setupMidView()
        setupNullView()
        setupTableView()
        setupAddView()
    }
    func setupAddView(){
        let w:CGFloat = 73
        let h = w
        let difL:CGFloat = 19
        let difD:CGFloat = 90
        
        let btn:UIButton = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - difL - w, y: SCREEN_HEIGHT - TABBAR_HEIGHT - difD - h, width: w, height: h))
        btn.setImage(UIImage.init(named: "add_qa"), for: .normal)
        self.view.addSubview(btn);
        btn.addTarget(self, action: #selector(btnActionAdd), for: .touchUpInside)
        
    }
    @objc func btnActionAdd(){
        let vc = QAAddViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setupNullView(){
        let h: CGFloat = SCREEN_HEIGHT - (self.midView?.maxY())! - TABBAR_HEIGHT
        let y: CGFloat = (self.midView?.maxY())!
        
        let v = UINib.init(nibName: "QANullView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! QANullView
        v.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h)
        self.view.addSubview(v)
        self.nullView = v
    }
    func setupMidView(){
        let v = UINib.init(nibName: "QAMidView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! QAMidView
        self.midView = v
        v.frame = CGRect.init(x: 0, y: (self.topView?.maxY())!, width: SCREEN_WIDTH, height: 50)
        self.view.addSubview(v)
        
        
        v.blockType = { type in
            switch type {
            case .all:do{
                self.flagStatus = -1
                self.requestData()
                }
            case .ed:do{
                self.flagStatus = 1
                self.requestData("", 1)
                }
            case .not:do{
                self.flagStatus = 0
                self.requestData("", 0)
                }
            case .accept:do{
                self.flagStatus = 2
                self.requestData("", 2)
                }
            default:
                break
            }
        }
    }
    func setupTableView(){
        let h: CGFloat = SCREEN_HEIGHT - (self.midView?.maxY())! - TABBAR_HEIGHT
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: (self.midView?.maxY())!, width: SCREEN_WIDTH, height: h), style: .plain)
        self.view.addSubview(tableView!)
        tableView?.dataSource = self
        tableView?.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "QAListTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: uniId)
        tableView?.separatorStyle = .none
        
    }
    func setupTopView(){
        let v:QATopView = UINib.init(nibName: "QATopView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! QATopView
        let h :CGFloat = 133
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: h)
        self.view.addSubview(v)
        self.topView = v
        v.blockText = {[weak self] (str) in
            self?.requestData(str, self!.flagStatus)
        }
    }
    
    //MARK: ------refresh--------
    var pageIndex: Int = 1
    var dataArr:[ModelQaList] = [ModelQaList]()
    var pageSize:Int = 10
    func setupRefresh(){
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(refreshUpToDown))
        tableView?.mj_header = header
        
        let footer = MJRefreshAutoNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(refreshDownToUp))
        tableView?.mj_footer = footer
    }
    func endRefresh(){
        if self.tableView?.mj_header.isRefreshing == true{
            self.tableView?.mj_header.endRefreshing()
        }
        if self.tableView?.mj_footer.isRefreshing == true{
            self.tableView?.mj_footer.endRefreshing()
        }
    }
    @objc func refreshDownToUp(){
        pageIndex += 1
        requestData()
    }
    @objc func refreshUpToDown(){
        pageIndex = 1
        requestData()
    }
    func requestData(_ question:String = "",_ status:Int = -1){ // status 不传 012: 全部 未答 已答 采纳
        let param = ParamQaList.init()
        param.pageIndex =  pageIndex
        param.studentId =  (CommonTool.getUserId())
        param.pageSize = pageSize
        if question.count > 0 {
            param.question = question
        }
        if status != -1 {
             param.status = status
        }
        QATool.list(params: param.toJSON()!, success: { ( res) in
            self.tableView?.isHidden = false
            self.endRefresh()
            if res.success{
                if self.pageIndex == 1{
                    self.dataArr = res.arr as! [ModelQaList]
                    self.tableView?.mj_footer.resetNoMoreData()
                    // 无数据 时
                    if self.dataArr.count == 0 {
                        self.tableView?.isHidden = true
                    }
                    
                    //test
                    
//                    let ppp: [ModelQaList] = self.dataArr
//                    let testArr = self.dataArr.map({ (model) -> ModelQaList in
//                        let m = model.copy() as! ModelQaList
//                        return m
//                    })
//                    let aaa:[ModelQaList] = testArr
//                    ppp.first?.answer?.teacherName = "t111--------------"
//                    ppp.first?.status = -100
//                    aaa.first?.status = 999
//                    aaa.first?.answer?.teacherName = "t222=-------------"
//                    print(ppp.first?.status as Any)
//                    print(aaa.first?.status as Any)
//                    let model: ModelQaList = ppp.first!
//                    model.status = 123
//                    
//                    print(ppp.first?.status as Any)
//                    print(model.status as Any)
//                    
//                    print(String.init(format: "%p", ppp))
//                    print(String.init(format: "%p", aaa))

                  
                    
                }else{
                    var arr = [Any]()
                    arr += self.dataArr
                    let hasMore:Bool = res.total >= self.pageSize * param.pageIndex!
 
                    if hasMore == false{
                    self.tableView?.mj_footer.endRefreshingWithNoMoreData()
                    }else{
                        arr += res.arr
                    }
                    self.dataArr = arr as! [ModelQaList]
                }
                self.tableView?.reloadData()
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            self.endRefresh()
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }

}

//MARK:------------------UITableViewDelegate---------------------
extension QAViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85 + 10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let _: QAListTableViewCell = tableView.cellForRow(at: indexPath) as! QAListTableViewCell
        let vc = QADetailViewController()
        let model : ModelQaList = self.dataArr[indexPath.row] as! ModelQaList
        vc.questionId = model.id
        vc.blockRepeal = { [weak self] str in
            self?.requestData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

  //MARK: ------UITableViewDataSource--------
extension QAViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : QAListTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! QAListTableViewCell

        cell.model = self.dataArr[indexPath.row] as? ModelQaList

        return cell

        
    }
}
