//
//  MyInfoViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/24.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class MyInfoViewController: BaseViewController {
 
    
    @IBOutlet weak var labTimeEnrollment: UILabel!
    @IBOutlet weak var labSchoolNumber: UILabel!
    
    @IBOutlet weak var labTimeGraduate: UILabel!
    @IBOutlet weak var textFieldID: UITextField!
    @IBOutlet weak var labBirthday: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var labName: UILabel!
    
    @IBOutlet weak var labYears: UILabel!
    @IBOutlet weak var labProfession: UILabel!
    @IBOutlet weak var labColleage: UILabel!
    @IBOutlet weak var labSex: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        print("bbbb")
        super.viewDidLoad()
        baseConfiguration()
        setupViews()
        requestData()
    }
    func baseConfiguration() -> Void {
        self.title = "我的资料"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }
    func setupViews() {
        
    }
    func requestData(){
        
    }

    @IBAction func btnActionImage(_ sender: Any) {
    }
    
    @IBAction func btnActionBirthday(_ sender: Any) {
    }
    
    
    @IBAction func btnActionID(_ sender: Any) {
        self.textFieldID.becomeFirstResponder()
    }
}
