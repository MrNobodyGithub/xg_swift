//
//  NotificationViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/23.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

    
    var tableView:UITableView?
    let uniId:String = "NotificationTableViewCellId"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        baseConfiguration()
        CommonTool.addNilView(vc: self, imageName: "nil_notification", titleStr: "暂无通知")
        setupViews()
        requestDataNotification()
    } 
    func setupViews(){
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .plain)
        self.view.addSubview(tableView!)
        tableView?.dataSource = self
        tableView?.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "NotificationTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: uniId)
        tableView?.separatorStyle = .none
    }
    
    
    func baseConfiguration() -> Void {
        self.view.backgroundColor = UIColor.colorWithHex(hexStr: "F8F9FA")
        self.title = "通知"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))

    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }
    var dataArr:[ModelNotification] = []
    //MARK: --------------------requestdata-------------------
    func requestDataNotification(){
        let param:ParamNotificationList = ParamNotificationList.init()
        param.receiverId = CommonTool.unarhiveUserData().token
        HomeTool.notificationList(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.dataArr = res.arr as! [ModelNotification]
                    self.tableView?.isHidden = self.dataArr.count == 0 ? true : false
                self.tableView?.reloadData()
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
  

}
extension NotificationViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NotificationTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! NotificationTableViewCell
        cell.model = self.dataArr[indexPath.row]
        return cell
    }
}

extension NotificationViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  78 + 10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _ : NotificationTableViewCell = tableView.cellForRow(at: indexPath) as! NotificationTableViewCell
        
        let vc = NotificationDetailViewController()
        vc.model = self.dataArr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
      
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView.init()
        v.backgroundColor = UIColor.colorWithHex(hexStr: "F8F9FA")
        return v
    }
}
