//
//  HomeResListViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/22.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class HomeResListViewController: UIViewController {

    var courseId: String?
    var courseTitle:String?
    //--------------------- in -------------------------------
    
    // views
    var tableView:UITableView?
    //data
    var dataArr:[ModelCourseInfomation] = []
    //other
    let uniId:String = "HomeResListTableViewCellId"
    var flagCell: HomeResListTableViewCell?
    var flagcount: Float = 0
    var timer:Timer?
    var flagSet: NSSet?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        baseConfiguration()
        setupViews()
        requestDataCourseInfomation()
    }
    func setupViews(){
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .plain)
        self.view.addSubview(tableView!)
        tableView?.dataSource = self
        tableView?.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "HomeResListTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: uniId)
        tableView?.separatorStyle = .none
    }
    func baseConfiguration() -> Void {
        self.view.backgroundColor = UIColor.colorWithHex(hexStr: "F8F9FA")
        self.title = self.courseTitle
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
    @objc func back(){
        self.navigationController?.popViewController(animated:true)
    }
 
    
    //MARK: --------------------request-------------------
    func requestDataCourseInfomation(){
        let param = ParamCourseDetail.init()
        param.userId = CommonTool.getUserId()
        param.courseId = self.courseId
        CourseTool.courseInfomation(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.dataArr = res.arr as! [ModelCourseInfomation]
                self.tableView?.reloadData()

            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
    
}
extension HomeResListViewController :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeResListTableViewCell = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! HomeResListTableViewCell
        cell.indexP = indexPath
        cell.model = self.dataArr[indexPath.row]
        cell.delegate = self
        return cell;
    }

}
extension HomeResListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 17;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95 + 10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        view.backgroundColor =  UIColor.colorWithHex(hexStr: "F8F9FA")
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
  
}
//MARK: --------------------课件资料 点击下载 查看-------------------
extension HomeResListViewController:HomeResListTableViewCellDelegate{
    func HomeResListTableViewCellDelegateTapDownLoad(m: ModelCourseInfomation, indexP: IndexPath) {
        ZDownLoadTool.downLoadWithUrl_short(url: m.url, progress: { (pro) in
            let cell:HomeResListTableViewCell = self.tableView?.cellForRow(at: indexP as IndexPath) as! HomeResListTableViewCell
            print(pro)
            cell.process = pro
        }, success: { path in
            m.filePath = path
        })
    }
    func HomeResListTableViewCellDelegateTapSee(m: ModelCourseInfomation, indexP: IndexPath) {
        let path:String = m.filePath;
        print(path)
        
            let vc = SeeFileViewController()
            vc.filePath = path
            self.navigationController?.pushViewController(vc, animated: true)
 
        
        
    }
}
