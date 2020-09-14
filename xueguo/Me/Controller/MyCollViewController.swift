//
//  MyCollViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/24.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class MyCollViewController: UIViewController {

    
    var tableView:UITableView?
    let uniId:String = "MyCollTableViewCellId"
    let uniIdEdit:String = "MyCollEditTableViewCellId"

    var isEdit: Bool = false
    var btnEdit: UIButton?
    
    var dataArr:[ModelCollection] = []
    var arrEdit:[ModelCollection] = []
    
    //MARK: --------------------viewLoad-------------------
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
        self.title = "我的收藏"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "编辑", style: UIBarButtonItem.Style.plain, target: self, action: #selector(edit(_:)))
    }
    
    //MARK: --------------------stupViews-------------------
    func setupViews() {
        CommonTool.addNilView(vc: self, imageName: "nil_col", titleStr: "暂无收藏");
        setupTableView()
        setupDownView()
    }
    func setupDownView (){
        let h :CGFloat = 50
        let difl :CGFloat = 17
        let btn = UIButton.init(frame: CGRect.init(x: difl, y: SCREEN_HEIGHT, width: SCREEN_WIDTH - 2 * difl, height: h))
        self.view.addSubview(btn)
        
        CommonTool.addGradientColo(btn.layer, btn.frame.size, ["#99CCFC","#5797F7"],CGPoint.init(x: 0, y: 0),CGPoint.init(x: 1, y: 1))
        btnEdit = btn
        btn.addTarget(self, action: #selector(btnActionEdit), for: .touchUpInside)
        btn.layer.cornerRadius = h / 2
        btn.layer.masksToBounds = true
        btn.setTitle("取消关注", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor.white, for: .normal)
        
    }
    func setupTableView(){
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .plain)
        self.view.addSubview(tableView!)
        tableView?.dataSource = self
        tableView?.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "MyCollTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: uniId)
        let nibEdit :UINib = UINib.init(nibName: "MyCollEditTableViewCell", bundle: nil)
        tableView?.register(nibEdit, forCellReuseIdentifier: uniIdEdit)
        
        
        tableView?.separatorStyle = .none
        
    }

    //MARK: --------------------action-------------------
    @objc func edit(_ bar:UIBarButtonItem){
        print("edit")
        isEdit  =  bar.title == "编辑" ? true : false
        if isEdit {
            bar.title = "取消编辑"
            UIView.animate(withDuration: 1) {
                let dif: CGFloat = (self.btnEdit?.frame.height)! + 20
                self.btnEdit?.frame.origin.y  -= dif
                self.tableView?.frame.size = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - dif)
            }
        }else{
            bar.title = "编辑"
            UIView.animate(withDuration: 1) {
                self.btnEdit?.frame.origin.y = SCREEN_HEIGHT
                self.tableView?.frame.size = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
            }
            
        }
        self.tableView?.reloadData()
        
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }

    @objc func btnActionEdit(){
        let arrID:[String] = self.arrEdit.map{
            return $0.id
        };
        let strId = arrID.joined(separator: ",")
        self.requestDataDelCol(strid: strId)
    }
    
    //MARK: --------------------requestData-------------------
    func requestDataDelCol(strid:String) {
        let param:ParamColAddOrDel = ParamColAddOrDel.init()
        param.resources = 0
        param.resourceSrcId = strid
        MeTool.collectionAddOrDel(params: param.toJSON()!, success: { ( res) in
            if res.success{
                CommonTool.showSuccess(view: self.view, text: res.message)
                self.requestData()
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    func requestData(){
        
        let param:BaseParamPage = BaseParamPage.init()
        param.pageSize = 100
        param.pageIndex = 1
        MeTool.collection(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.dataArr = res.arr as! [ModelCollection]
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

extension MyCollViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEdit {
            let cell : MyCollEditTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniIdEdit, for: indexPath) as! MyCollEditTableViewCell
            let model = self.dataArr[indexPath.row]
            cell.model = model
            return cell
        }else{
            let cell : MyCollTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! MyCollTableViewCell
            cell.model = self.dataArr[indexPath.row]
            return cell
        }
       
    }
}
extension MyCollViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isEdit{
            let cell : MyCollEditTableViewCell = tableView.cellForRow(at: indexPath) as! MyCollEditTableViewCell
            cell.btnCircle.isSelected = !cell.btnCircle.isSelected
            let model: ModelCollection = self.dataArr[indexPath.row]
            if cell.btnCircle.isSelected {
                arrEdit.append(model)
            }else
            {
                arrEdit.remove(at: indexPath.row)
            }
        }else
        {
            let cell : MyCollTableViewCell = tableView.cellForRow(at: indexPath) as! MyCollTableViewCell
        }
        
        
        
    }
}
