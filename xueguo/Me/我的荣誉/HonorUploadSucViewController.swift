//
//  HonorUploadSucViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/20.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class HonorUploadSucViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
  
    var viewNav:CommonNavView?
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
        setupViewNav()
        setupViewInfo()
    }
    
    func setupViewInfo(){
        let v = UINib.init(nibName: "HonorUploadSuccessView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! HonorUploadSuccessView
        v.frame = CGRect.init(x: 0, y: (self.viewNav?.frame.maxY)!, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.view.addSubview(v)
        v.blockBack = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    func setupViewNav(){
        let v = UINib.init(nibName: "CommonNavView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CommonNavView
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 83);
        self.view.addSubview(v)
        self.viewNav = v
        v.title = "提示"
        v.blockBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func requestData(){
        
    }

}
