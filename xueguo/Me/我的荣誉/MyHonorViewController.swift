//
//  MyHononerViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/13.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class MyHonorViewController: UIViewController {

    
    var viewNav:HonorNavView?
    var viewSec:HonorSectionView?
    var viewDown:UIView?
    var scrollView :UIScrollView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
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
    }
    func setupViews() {
        CommonTool.addNilView(y: 40, vc: self, imageName: "nil_honor", titleStr: "暂无荣誉")
        setupViewsNav()
        setupViewSection()
        setupViewDown()
        setupScrollView()
    }
    func setupScrollView(){
    
        let h:CGFloat = SCREEN_HEIGHT - (self.viewSec?.maxY())! - (self.viewDown?.frame.height)!
        let sc:UIScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: (self.viewSec?.frame.maxY)!, width: SCREEN_WIDTH, height: h))
        self.view.addSubview(sc)
        self.scrollView = sc
        sc.isPagingEnabled = true
        sc.delegate = self
        
        
        sc.contentSize = CGSize.init(width: SCREEN_WIDTH * 3, height: h)
        setupScrollViewTableViewL()
        setupScrollViewTableViewM()
        setupScrollViewTableViewR()
    }
    
    var tableViewL:UITableView?
    var tableViewM:UITableView?
    var tableViewR:UITableView?
    let uniId:String = "MyHonorTableViewCellId"
    let uniId_check:String = "MyHonorCheckTableViewCellId"
    let uniId_reject:String = "MyHonorRejectTableViewCellId"
    func setupScrollViewTableViewL(){
        
        
        let h:CGFloat = (self.scrollView?.frame.height)!
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: h), style: .plain)
        tableViewL = tableView
        self.scrollView!.addSubview(tableView)
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "MyHonorTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: uniId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
    }
    func setupScrollViewTableViewM(){
        let h:CGFloat = (self.scrollView?.frame.height)!
        let tableView = UITableView.init(frame: CGRect.init(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: h), style: .plain)
        tableViewM = tableView
        self.scrollView!.addSubview(tableView)
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "MyHonorCheckTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: uniId_check)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
    }
    func setupScrollViewTableViewR(){
        let h:CGFloat = (self.scrollView?.frame.height)!
        let tableView = UITableView.init(frame: CGRect.init(x: SCREEN_WIDTH * 2, y: 0, width: SCREEN_WIDTH, height: h), style: .plain)
        tableViewR = tableView
        self.scrollView!.addSubview(tableView)
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "MyHonorRejectTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: uniId_reject)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
    }
    func setupViewDown(){
        let h:CGFloat = 50
        let v:UIView = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - h, width: SCREEN_WIDTH, height: h))
        self.view.addSubview(v)
        self.viewDown = v
        let btn:UIButton = UIButton.init(frame: v.bounds)
        v.addSubview(btn)
        btn.setTitle("+添加新荣誉", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        CommonTool.addGradientColo(btn.layer, btn.frame.size, ["#99CCFC","#5797F7"])
        btn.addTarget(self, action: #selector(btnActionDown), for: .touchUpInside)
    }
    func setupViewsNav(){
        let v :HonorNavView = UINib.init(nibName: "HonorNavView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! HonorNavView
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 100)
        self.viewNav = v
        v.layoutDown.constant = 25;
        v.title.text = "我的荣誉";
        v.blockBack = {
            self.navigationController?.popViewController(animated: true)
        }
        self.view.addSubview(v)
    }
    func setupViewSection(){
        let arr:Array = ["已有荣誉","审核中","驳回"]
        let v: HonorSectionView = HonorSectionView.init(frame: CGRect.init(x: 0, y: (self.viewNav?.frame.maxY)!, width: SCREEN_WIDTH, height: 30))
        v.dataArr = arr;
        self.view.addSubview(v)
        self.viewSec = v
        v.delegate = self
    }
    func requestData(){
        
    }
    
    
    //MARK: --------------------action-------------------
    @objc func btnActionDown(){ 
        let vc = AddHonorViewController() 
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

}
extension MyHonorViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x :CGFloat = (scrollView.contentOffset.x)
        let index: CGFloat = x / SCREEN_WIDTH
        
        self.viewSec?.selIndex = NSInteger(index)
    }
}
extension MyHonorViewController:HonorSectionViewDelegate{
    func HonorSectionViewDelegateIndex(index: NSInteger) {
        self.scrollView?.setContentOffset(CGPoint.init(x: SCREEN_WIDTH * CGFloat(index), y: 0), animated: true)
    }
}


extension MyHonorViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewL {
        }else if tableView == tableViewM{
        }else if tableView == tableViewR{
        }
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewL {
            let cell : MyHonorTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! MyHonorTableViewCell
            return cell
        }else if tableView == tableViewM{
            let cell : MyHonorCheckTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId_check, for: indexPath) as! MyHonorCheckTableViewCell
            return cell
        }else if tableView == tableViewR{
            let cell : MyHonorRejectTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId_reject, for: indexPath) as! MyHonorRejectTableViewCell
            return cell
        }
        let cell : MyHonorTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! MyHonorTableViewCell
        return cell
    }
}
extension MyHonorViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var h:CGFloat = 0;
        if tableView == tableViewL {
            h = 105
        }else if tableView == tableViewM{
            h = 130
        }else if tableView == tableViewR{
            h = 185
        }
        return h
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewL {
            let vc = HonorDetailViewController() 
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if tableView == tableViewM{
            let vc = EditHonorViewController() 
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if tableView == tableViewR{
        }
//        let cell : MyHonorTableViewCell = tableView.cellForRow(at: indexPath) as! MyHonorTableViewCell
        
    }
}
