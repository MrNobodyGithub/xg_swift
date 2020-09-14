//
//  HomeViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/23.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class HomeViewController: UIViewController {

    
//    var scrollView: UIScrollView?
    var headSearchView : HomeTopSearchView?
    var headView: HomeTopView?
    
    var tableView:UITableView?
    //----- pro -------------------------------
    var dataArr:[ModelCourseList] = []
    //MARK:----func---------------------
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
           UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        // 检验是否有通知
        self.requestDataNotification()
   
        //  确认当前认证状态
        getMyStatus()
        // 更新头部实际数据
        self.headSearchView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfiguration()
        setupViews()
        refresh()
        //temp
//        requestData()
//        requestDataBanner()
    }
    func baseConfiguration() -> Void {
       
      
    }
    func  refresh() -> Void {
        
        let header = ZRefreshGif.init()
        header.setRefreshingTarget(self, refreshingAction: #selector(refreshHeader))
        tableView?.mj_header = header
         
    }

    
    //MARK: ----requestData-------------------
    func requestDataBanner(){
        let param:ParamBanner = ParamBanner.init()
        param.pubState = 1
        param.pageIndex = 1
        HomeTool.banner(params: param.toJSON()!, success: { ( res) in
            if res.success{
//                self.headView.dataArr = res.arr as! [ModelBanner]
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
    func requestData(){
      
        if !IsLogin() {
            return;
        }
        let  user = CommonTool.unarhiveUserData();
        
        let param:ParamCourseList = ParamCourseList.init()
        param.homePage = 1
        param.pageSize = 20;
        param.pageIndex = 1
        param.grade = user.grade.toInt();
        param.stuedendId = user.id;
        CourseTool.courseList(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.dataArr = res.arr as! [ModelCourseList]
                self.tableView?.reloadData()
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    func requestDataNotification(){
        let param:ParamNotificationList = ParamNotificationList.init()
        param.receiverId = CommonTool.unarhiveUserData().token
        HomeTool.notificationList(params: param.toJSON()!, success: { ( res) in
            if res.success{
                let arr = res.arr as! [ModelNotification]
                if arr.count > 0{
                    self.headSearchView?.settingBtnRed(isRed: true)
                }else{
                    self.headSearchView?.settingBtnRed(isRed: false)
                }
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
    
    //MARK: -----subviews---------------------

        func setupViews() -> Void {
            setupHeadSearchView()
            setupTableView()
    //        setupScrollView()
            setupHeadView()
            
        }
    
    let uniId:String = "CourseListProgressTableViewCellId"
    func setupTableView(){
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: (self.headSearchView?.frame.maxY)!, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - (self.headSearchView?.frame.maxY)! ), style: .plain)
        self.view.addSubview(tableView!)
        tableView?.dataSource = self as UITableViewDataSource
        tableView?.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "CourseListProgressTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: uniId)
        tableView?.separatorStyle = .none
        
    }


    func setupHeadView() -> Void {
        var height = 136.0 + 106.0  + TRANS_GET_H(w: SCREEN_WIDTH - 34, scale: 342.0/167.0)
        height = height - 136.0
        let headview  = UINib.init(nibName: "HomeTopView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! HomeTopView
        self.headView = headview

        headview.delegate = self
        headview.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: height)
//        scrollView!.addSubview(headview)
        tableView?.tableHeaderView = headview
    }
    func setupHeadSearchView(){
        let height:CGFloat = 136.0
        let headview  = UINib.init(nibName: "HomeTopSearchView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! HomeTopSearchView
        self.headSearchView = headview
        headview.delegate = self
        
        headview.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: height)
        self.view.addSubview(headview)
    }
    
    
    //MARK: -----action-------------------
    @objc func refreshHeader() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            if (self.tableView?.mj_header.isRefreshing)!  {
                self.tableView?.mj_header.endRefreshing()
            }
        }
    }
        
    
    //MARK:  ---other-------------------
    func getMyStatus () {
    
        if IsLogin(){
            let param: ParamGetUserInfo = ParamGetUserInfo()
            param.userId = CommonTool.getUserId()
            MeTool.getUserInfo(params: param.toJSON()!, success: { ( res) in
                if res.success{
                    let model: ModelUser = CommonTool.unarhiveUserData()
                    let status:String = model.status
                    if status == "2" || status == "4"{
                    }else if  status == "1" || status == "3"{
                        let vc = CheckResViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else if status == "0"{
                        let vc = CheckViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                }else{
                    CommonTool.showFail(view: self.view, text: res.message)
                }
            }, fail: {(err) in
                CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
            })
        }else
        {
            let vc = LoginViewController()
            vc.blockLoginSuccess = {
                //temp
//                self.requestData();
//                self.requestDataBanner()
//                self.requestDataNotification()
            }
            
            let nav: UINavigationController = UINavigationController.init(rootViewController: vc)
            self.present(nav, animated: true) {

            };
        }
    }
      
}


extension HomeViewController: HomeTopViewDelegate {
  
    func HomeTopViewDelegateType(_ type: HomeTopViewType) {
        
        switch type {
        case .colleage: do{  self.navigationController?.pushViewController(HomeDepartmentMissionViewController(), animated: true)
            break}
        case .file:do{
            self.navigationController?.pushViewController(HomeCoursewareViewController(), animated: true)
            
            break}
        default: break
        }
    }
    
    
    func HomeTopViewDelegateCycleScroll(_ index: Int) {
        
//        print("scroll" + String(index))
    }
    
    func HomeTopViewDelegateCycleSelect(_ index: Int) {
        print("select" + String(index))
    }
}

 
extension HomeViewController: HomeTopSearchViewDelegate{
    func HomeTopSearchViewDelegateSearch() {
        let vc = HomeSearchViewController() 
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func HomeTopSearchViewDelegateNotification() {
        self.navigationController?.pushViewController(NotificationViewController(), animated: true)
      
    }
}
//MARK:------------------for better ---------------------
 

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CourseListProgressTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! CourseListProgressTableViewCell
        cell.model = self.dataArr[indexPath.row]
        return cell
    }
}
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 + 14
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:ModelCourseList =  self.dataArr[indexPath.row] as! ModelCourseList
        let vc = CourseDetailViewController()
        vc.modelPush = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
