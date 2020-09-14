//
//  CourseTaskDetailViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/13.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseTaskDetailViewController: UIViewController {

    
    //--------------------- in -------------------------------
    var taskDetailId:String?
    //--------------------- pro -------------------------------
    var tableView:UITableView?
    var heightForTableViewH:CGFloat = 0
    
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
    }

    //MARK: --------------------views-------------------
    var uniId:String = "CourseTaskDetailTableViewCellId"
    var uniId_header:String = "CourseTaskDetailHeaderViewId"
    func setupViews() {
        self.setupTableView()
    }
   
    func setupTableView(){
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .grouped)
        self.view.addSubview(tableView!)
        tableView?.dataSource = self as! UITableViewDataSource
        tableView?.delegate = (self as! UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "CourseTaskDetailTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: uniId)
        tableView?.separatorStyle = .none
        
        tableView?.register(CourseTaskDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: uniId_header)
    }
    
    
    //MARK: --------------------requestData-------------------
    var modelInfo:ModelTaskDetail = ModelTaskDetail()
    
    func requestData(){
        let param = ParamTaskDetail.init()
        param.evaluateId = "34"//self.taskDetailId
        CourseTool.taskDetail(params: param.toJSON()!, success: { ( res) in
            if res.success{
                let model : ModelTaskDetail = res.data as! ModelTaskDetail
                self.modelInfo = model
                self.kGetHeightForTableViewHeader()
                self.tableView?.reloadData()
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
   
  
    func baseConfiguration() -> Void {
        self.view.backgroundColor = .white
        self.title = "评核任务"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }
    
    //MARK: --------------------other-------------------
    func kGetHeightForTableViewHeader(){
        let content =  self.modelInfo.cloEvaluate.taskContent  
        
        // w : sw -( 16 + 16 + 15 + 8)
        // font 14
        // h : 212 - 63
        let h = CommonTool.getAttributionHeightWithString(str: content, lineSpace: 5, fontSize: 14, width: SCREEN_WIDTH - (32 - 23))
        self.heightForTableViewH = 212 - 63 + h
    }

}


extension CourseTaskDetailViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.modelInfo != nil {
            return self.modelInfo.evaluateItemList.count
//        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CourseTaskDetailTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! CourseTaskDetailTableViewCell
        cell.model = self.modelInfo.evaluateItemList[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = CourseTaskDetailHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 200))
        v.model = self.modelInfo
        v.height = self.heightForTableViewH;
        return v
    }
}
extension CourseTaskDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.heightForTableViewH
//        return 212
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : CourseTaskDetailTableViewCell = tableView.cellForRow(at: indexPath) as! CourseTaskDetailTableViewCell
        
    }
}
