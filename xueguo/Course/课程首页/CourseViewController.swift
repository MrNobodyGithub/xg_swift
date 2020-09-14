//
//  CourseViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/23.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit
import MJRefresh

class CourseViewController: UIViewController {
    
    
    func z_reloadUI(){
        
    }
    
    var topView: CourseTopView?
    var midView: CourseMidView?
    var status:String = "-1"
    var year:String?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        self.topView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfiguration()
        setupViews()
        requestData()
        // Do any additional setup after loading the view.
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews() {
        CommonTool.addNilView(y:100,vc: self, imageName: "nil_course", titleStr: "暂无课程")
        setupTopView()
        setupMidView()
        setupTableView()
        setupRefresh()
    }
    
    //MARK: --------------------tableview-ui-------------------
    var tableView:UITableView?
    let uniId:String = "CourseListTableViewCellId"
    let uniIdPro:String = "CourseListProgressTableViewCellId"
    
    func setupTableView(){
        let y: CGFloat = (self.midView?.maxY())!
        let h: CGFloat = SCREEN_HEIGHT  - y
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h), style: .plain)
        self.view.addSubview(tableView!)
        tableView?.dataSource = self as UITableViewDataSource
        tableView?.delegate = self as UITableViewDelegate
        let nib :UINib = UINib.init(nibName: "CourseListTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: uniId)
        tableView?.separatorStyle = .none
        
        let nibPro :UINib = UINib.init(nibName: "CourseListProgressTableViewCell", bundle: nil)
        tableView?.register(nibPro, forCellReuseIdentifier: uniIdPro)
        
         
    }
    func setupMidView(){
        let v = UINib.init(nibName: "CourseMidView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseMidView
        v.frame = CGRect.init(x: 0, y: (self.topView?.maxY())!, width: SCREEN_WIDTH, height: 50)
        self.view.addSubview(v)
        self.midView = v
        v.blockType = {ty in
            switch ty {
            case .all: do{
                self.status = "-1"
                self.krefresh()
            }
            case .ing: do{
                self.status = "1"
               self.krefresh()
                }
            case .open: do{
//                self.status = "-1"
//               self.krefresh()
                }
            case .finish: do{
                self.status = "2"
                self.krefresh()
                }
            default:
                break
            }
            
        }
    }
    
    func krefresh(){
        pageIndex = 1
        requestData()
    }
    
    func setupTopView(){
        let v = UINib.init(nibName: "CourseTopView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseTopView
        v.frame  = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 133)
        self.topView = v
        self.view.addSubview(v)
     
        v.blockType = {[weak self] str in
            self?.year = str
            self?.requestData()
        }
    }
    
    //MARK: --------------------refresh-------------------
    var pageIndex: Int = 1
    var pageSize:Int = 10
    
    var dataArr:[ModelCourseList] = []
    func setupRefresh(){
        let header = MJRefreshNormalHeader()
        tableView?.mj_header = header
        header.refreshingBlock = { [weak self] in
            self!.pageIndex = 1
            self?.requestData()
        }
        let footer = MJRefreshAutoNormalFooter()
        tableView?.mj_footer = footer
        footer.refreshingBlock = { [weak self] in
            self!.pageIndex += 1
            self?.requestData()
        }
    }
    func endRefresh(){
        if self.tableView?.mj_header.isRefreshing == true{
            self.tableView?.mj_header.endRefreshing()
        }
        if self.tableView?.mj_footer.isRefreshing == true{
            self.tableView?.mj_footer.endRefreshing()
        }
    }
   
    //MARK: --------------------request-------------------
    func requestData(){
        let param = ParamCourseList.init()
        param.pageIndex =  pageIndex
        param.studentId =  (CommonTool.getUserId())
        param.pageSize = pageSize
        if self.status == "-1" {
        }else{
            param.status = self.status
        }
        
        if self.year  != nil{
             param.year = Int(self.year!)
        }else
        {
            let y = CommonTool.unarhiveUserData().enrolmentTime.prefix(4)
            param.year =  Int(y)
        }

        CourseTool.courseList(params: param.toJSON()!, success: { (res) in
            self.endRefresh()
            if res.success {
                if self.pageIndex == 1 {
                    self.dataArr = res.arr as! [ModelCourseList]
                    self.tableView?.isHidden = self.dataArr.count == 0 ? true : false
                    self.tableView?.mj_footer.resetNoMoreData()
                }else
                {
                    self.tableView?.isHidden = false
                    var arr = [Any]()
                    arr += self.dataArr
                    let hasMore:Bool = res.total >= self.pageSize * param.pageIndex!
                    
                    if hasMore == false{
                        self.tableView?.mj_footer.endRefreshingWithNoMoreData()
                    }else{
                        arr += res.arr
                    }
                    self.dataArr = arr as! [ModelCourseList]
                }
                self.tableView?.reloadData()
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail:{(err) in
            self.endRefresh()
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
        
        
    }

}


//MARK: --------------------UITableViewDataSource-------------------
extension CourseViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model:ModelCourseList = self.dataArr[indexPath.row] as! ModelCourseList
        if model.status == "0" || model.status == "4"{
            let cell : CourseListTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! CourseListTableViewCell
            cell.model = model
            cell.blockClick = {
            }
            return cell
        }else
        {
            let cell : CourseListProgressTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniIdPro, for: indexPath) as! CourseListProgressTableViewCell
            cell.model = model
            return cell
        }
        
    }
}


//MARK: --------------------UITableViewDelegate-------------------

extension CourseViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model:ModelCourseList = self.dataArr[indexPath.row] as! ModelCourseList
        if model.status == "0" || model.status == "4"{
            return 120 + 14 - 44
        }else
        {
            
        }
        
        return 120 + 14
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:ModelCourseList =  self.dataArr[indexPath.row] as! ModelCourseList
        let vc = CourseDetailViewController()
        vc.modelPush = model
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
}
