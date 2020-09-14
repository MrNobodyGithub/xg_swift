//
//  StudentEvaluateViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class StudentEvaluateViewController: UIViewController {

    var dataArr: Array = [String]()
    
    @IBOutlet weak var btnL: UIButton!
    @IBOutlet weak var btnR: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewStatus: UIView!
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
        self.dataArr = CommonTool.CusOrderList(start: 0, step: 1, count: 4).map({
            return String.init(format: "%d", $0)
        })
        //TEMP: asdf
        topViewIsRed(isRed: CommonTool.cusRandBool())
        
        let w :CGFloat = 110
        CommonTool.addCornerRadius_fast(sizeW: w, sizeH: 40, layer: self.btnL.layer, radius: 20, arr: [UIRectCorner.topLeft,UIRectCorner.bottomLeft])
        
        
        let w_r :CGFloat = SCREEN_WIDTH - w - 32 - 5
        
        CommonTool.addCornerRadius_fast(sizeW: w_r , sizeH: 40, layer: self.btnR.layer, radius: 20, arr: [UIRectCorner.topRight,UIRectCorner.bottomRight])
        CommonTool.addGradientColo(self.btnR.layer, CGSize.init(width: w_r, height: 40), ["#99CCFC","#5797F7"])
        
        self.title = "学生互评"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
    
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }
    func setupViews() {
        setupTableView()
        
    }
   
    
    let uniId:String = "StudentEvaluateTableViewCellId"
    func setupTableView(){
        
        self.tableView.dataSource = self as UITableViewDataSource
        self.tableView.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "StudentEvaluateTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: uniId)
        tableView?.separatorStyle = .none
    }
    func requestData(){
    }
    
    func topViewIsRed(isRed:Bool){
         //ABACAD  #FB445A
        if isRed {
            self.viewStatus.backgroundColor = UIColor.colorWithHex(hexStr: "ABACAD")
        }else{
            
            self.viewStatus.backgroundColor = UIColor.colorWithHex(hexStr: "FB445A")
        }
    }
    //MARK: --------------------action-------------------
    
    var shadowView:UIView?
    func setupPickerView(){
        // 0 shadowView
        shadowView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.view.addSubview(shadowView!)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapGes(_:)))
        shadowView!.addGestureRecognizer(tap)
        
        let sview : UIView = UIView.init(frame: shadowView!.bounds)
        sview.backgroundColor = UIColor.RGBAColorSame(r: 0, a: 0.4)
        
        shadowView?.addSubview(sview)
        
        let h: CGFloat = 200
        
        let picker = UIPickerView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - h, width: SCREEN_WIDTH, height: h))
        shadowView!.addSubview(picker)
        picker.delegate = self as UIPickerViewDelegate
        picker.dataSource = self as UIPickerViewDataSource
        
        picker.backgroundColor = .white
        
        let v = UIView.init(frame: CGRect.init(x: 0, y: picker.minY() - 40, width: SCREEN_WIDTH, height: 40))
        shadowView!.addSubview(v)
        v.backgroundColor = UIColor.RGBColor(r: 249, g: 249, b: 249)
        let btnH:CGFloat = 40
        let btnW:CGFloat = 100
        let leftBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: btnW, height: btnH))
        v.addSubview(leftBtn)
        leftBtn.setTitle("取消", for: .normal)
        leftBtn.setTitleColor(.gray, for: .normal)
        leftBtn.addTarget(self, action: #selector(btnActionQuit), for: .touchUpInside)
        
        let rightBtn = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH-btnW, y: 0, width: btnW, height: btnH))
        v.addSubview(rightBtn)
        rightBtn.setTitle("确定", for: .normal)
        rightBtn.setTitleColor(UIColor.RGBColor(r: 114, g: 180, b: 252), for: .normal)
        rightBtn.addTarget(self, action: #selector(btnActionSure), for: .touchUpInside)
    }
    @objc func btnActionQuit(){
        self.shadowView?.removeFromSuperview()
        
    }
    @objc func btnActionSure(){
        self.shadowView?.removeFromSuperview()
        
    }
    @objc func tapGes(_ ges:UITapGestureRecognizer){
        shadowView?.removeFromSuperview()
    }
    
    @IBAction func btnActionR(_ sender: Any) {
    }
    @IBAction func btnActionL(_ sender: Any) {
    }
    
    var flagCell:StudentEvaluateTableViewCell?
}

extension StudentEvaluateViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : StudentEvaluateTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! StudentEvaluateTableViewCell
        return cell
    }
}
extension StudentEvaluateViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : StudentEvaluateTableViewCell = tableView.cellForRow(at: indexPath) as! StudentEvaluateTableViewCell
        flagCell = cell
        setupPickerView()
        
    }
}


//MARK:UIPickerViewDelegate
extension StudentEvaluateViewController:UIPickerViewDelegate{
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "2"
//    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let str:String = self.dataArr[row]
        flagCell?.btnScore.setTitle(str, for: .normal)
    }
}
//MARK:UIPickerViewDataSource
extension StudentEvaluateViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        for line in pickerView.subviews{
            if line.frame.height < 1{
                line.backgroundColor = UIColor.RGBColor(r: 50, g: 50, b: 50)
            }
        }
        
        let lab: UILabel = UILabel.init()
        lab.text = self.dataArr[row]
        lab.textColor = .black
        lab.font = UIFont.systemFont(ofSize: 23)
        lab.textAlignment = .center
        return lab
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataArr.count;
    }
    
    
}
