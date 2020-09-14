//
//  CourseEvaluateViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/31.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseEvaluateViewController: BaseViewController {

    var topView:CourseEvaluateTopView?
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
        self.title = "课程评测"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }

    func setupViews() {
        setupTopView()
        setupTableView()
        setupEvaluateBtn()
    }
    
    var tableView:UITableView?
    let uniId:String = "CourseEvaluateTableViewCellId"
    
    func setupTableView(){
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .grouped)
        self.view.addSubview(tableView!)
        tableView?.dataSource = self as UITableViewDataSource
        tableView?.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "CourseEvaluateTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: uniId)
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
    }
    func setupTopView(){
        let h:CGFloat = 80
        let y:CGFloat = NAV_HEIGHT + STATUS_HEIGHT
        let v = UINib.init(nibName: "CourseEvaluateTopView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseEvaluateTopView
        v.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h)
        self.view.addSubview(v)
        self.topView = v
    }
    func setupEvaluateBtn(){
        let h :CGFloat = 60
        let v:UIView = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - h, width: SCREEN_WIDTH, height: h))
        self.view.addSubview(v)
        v.backgroundColor = .white
        
        
        let btn = UIButton.init(frame: CGRect.init(x: 17, y: 5, width: SCREEN_WIDTH - 17 * 2, height: h - 10))
        v.addSubview(btn)
        btn.setTitle("立即评测", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        CommonTool.addGradientColo(btn.layer, btn.frame.size, ["#99CCFC","#5797F7"])
        btn.addTarget(self, action: #selector(btnActionEvaluating), for: .touchUpInside)
        
        btn.layer.cornerRadius = (h - 10) / 2
        btn.layer.masksToBounds = true
    }
    @objc func btnActionEvaluating(){
        print("click eva")
    }
    
    
    func requestData(){
        
    }
 

}
extension CourseEvaluateViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : CourseEvaluateTableViewCell = tableView.cellForRow(at: indexPath) as! CourseEvaluateTableViewCell
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UINib.init(nibName: "CourseEvaluateHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseEvaluateHeaderView
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 160)
        return v
    }
}

extension CourseEvaluateViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CourseEvaluateTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! CourseEvaluateTableViewCell
        if indexPath.row == 9{
            cell.isLast = true
        }
        return cell
    }
}
