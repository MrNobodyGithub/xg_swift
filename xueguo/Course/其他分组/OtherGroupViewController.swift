//
//  OtherGroupViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class OtherGroupViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    var dataArr:Array<NSInteger> = [7,4,4,4]//[NSInteger]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfiguration()
        setupViews()
        requestData()
        // Do any additional setup after loading the view.
    }
    func baseConfiguration() -> Void {
        self.view.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        self.title = "其他分组"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }
    func setupViews() {
        setupScrollView()
        setupSubView()
    }
    var scrollView:UIScrollView?
    func setupScrollView(){
        let s :UIScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.scrollView = s
        self.view.addSubview(s)
        s.contentSize = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 1.5)
    }
    func setupSubView(){
        var flagY :CGFloat =  0
        for x:NSInteger in self.dataArr{
            let h :CGFloat = getHeightWith(number: x)
            let v = UINib.init(nibName: "OtherGroupSubView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! OtherGroupSubView
            v.frame = CGRect.init(x: 0, y: flagY, width: SCREEN_WIDTH, height: h)
            self.scrollView!.addSubview(v)
            v.addMemberWith(num: x)
            flagY += h
        }
        self.scrollView?.contentSize = CGSize.init(width: SCREEN_WIDTH, height: flagY + 50)
        
    }
    func getHeightWith(number:NSInteger) -> CGFloat{
        if  number <= 0 {
            return 0
        }else if number <= 4 {
            return 135 + 10
        }else{
            return 10 + 135 + (78) * CGFloat(number / 4)
        }
    }
    func requestData(){
        
    }
    

 

}
