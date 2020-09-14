

//
//  MyRegisterViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/24.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class MyRegisterViewController: BaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    var tableView:UITableView?
    let uniId:String = "MyRegisterTableViewCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfiguration()
        setupViews()
        requestData()
        // Do any additional setup after loading the view.
    }
    func baseConfiguration() -> Void {
        self.title = "就业登记"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }

    func setupViews() {
        CommonTool.addNilView(vc: self, imageName: "nil_register", titleStr: "暂无登记")
        setupTableView()
        setupDownView()
    }
    func setupDownView(){
        let h : CGFloat = 50
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - h, width: SCREEN_WIDTH, height: h))
        self.view.addSubview(btn)
        CommonTool.addGradientColo(btn.layer, btn.frame.size, ["#99CCFC","#5797F7"])
        btn.setTitle("+ 添加就业信息", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(btnActionAdd), for: .touchUpInside)
    }
    @objc func btnActionAdd(){
        let vc = MyRegisterAddViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    func setupTableView(){
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 50), style: .plain)
        self.view.addSubview(tableView!)
        tableView?.dataSource = self
        tableView?.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "MyRegisterTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: uniId)
        tableView?.separatorStyle = .none
        
    }
    
    //MARK: --------------------requestData-------------------
    var dataArr:[ModelJobList] = []
    func requestData(){
        let param:BaseParamPage = BaseParamPage.init()
        param.pageSize = 100;
        param.pageIndex = 1;
        MeTool.jobList(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.dataArr = res.arr as! [ModelJobList]
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


extension MyRegisterViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MyRegisterTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! MyRegisterTableViewCell
        cell.model = self.dataArr[indexPath.row]
        return cell
    }
}
extension MyRegisterViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : MyRegisterTableViewCell = tableView.cellForRow(at: indexPath) as! MyRegisterTableViewCell
        
        let vc = MyRegisterAddViewController() 
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}


