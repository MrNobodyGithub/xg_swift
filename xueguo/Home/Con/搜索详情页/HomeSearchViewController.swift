//
//  HomeSearchViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/9/9.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class HomeSearchViewController: UIViewController {

    //--------------------- in -------------------------------
    //--------------------- out -------------------------------
    //--------------------- pro -------------------------------
    @IBOutlet weak var viewNav: UIView!
    
    @IBOutlet weak var viewCon: UIView!
    
    @IBOutlet weak var textField: UITextField!
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
        self.textField.delegate = self
    }
    //MARK: -------------------- 0 setupViews-------------------
    func setupViews() {
        
    }
    func setupViewsHotKey(){
        let v = UINib.init(nibName: "SearchHistoryView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! SearchHistoryView
        v.frame = CGRect.init(x: 0, y: self.viewNav.frame.maxY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - self.viewNav.frame.maxY)
        self.view.addSubview(v)
        
    }
    //MARK: -------------------- 1 requestData-------------------
    func requestData(){
        
    }
    //MARK: -------------------- 2 Delegate-------------------
    //MARK: -------------------- -2action-------------------
    
    @IBAction func btnActionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnActionSearch(_ sender: Any) {
    }
    
    //MARK: -------------------- -1 other-------------------
    func kaddKeyForSearch(key:String) {
        if key.count == 0 {
            return
        }
        var arr = UserDefaults.standard.array(forKey: DefKeySearchKey)
      
        
        arr?.append(key)
        UserDefaults.standard.set(arr, forKey: DefKeySearchKey)
        
    }
}
extension HomeSearchViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
}
