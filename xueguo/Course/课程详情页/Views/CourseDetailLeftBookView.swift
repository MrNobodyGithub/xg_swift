//
//  CourseDetailLeftBookView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/30.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
 

class CourseDetailLeftBookView: UIView {
 // (57 + 10) * n + 3
    // 57 * n + 10 * (n-1) + 13
    
    //--------------------- in -------------------------------
    var dataArr:[Any]?{
        didSet{
            addSub(arr: dataArr!)
        }
    }
    
    //--------------------- out -------------------------------
    
    var callback:BaseBlock_T<NSInteger>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
    }
    func addSub(arr:[Any]) {
        // 57 + 10
        let difL:CGFloat = 15
        let h :CGFloat = 57
        for (index,value) in arr.enumerated(){
            let v:UIView = UIView.init(frame: CGRect.init(x: 15, y: CGFloat(index) * (h + 10), width: SCREEN_WIDTH - 2 * difL, height: h))
            self.addSubview(v) 
            v.layer.cornerRadius = 5
            let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapAction(tap:)))
            v.addGestureRecognizer(tap)
            v.tag = 100 + index
            let dict:Dictionary = value as! [String:Any]
            let strTitle:String = dict["bookName"] as! String
            let strDetail:String = dict["ISBN"] as! String
            let strAuthor:String = dict["author"] as! String
            addImg(v: v)
            addLabTop(v: v,str:strTitle)
            addLabDown(v: v,str: strDetail)
        }
    }
    @objc func tapAction(tap:UITapGestureRecognizer){
        let index:NSInteger = tap.view!.tag - 100
        if let _ = callback{
            callback!(index)
        }
        
    }
    
    func addLabDown(v:UIView,str:String){
        let lab  = UILabel.init(frame: CGRect.init(x: 59, y: 31, width: SCREEN_WIDTH - 30 - 59 - 10, height: 14))
        lab.textColor = UIColor.colorWithHex(hexStr: "#B9B9B9")
        lab.text = "ISBN编码：" + str
        lab.font = UIFont.systemFont(ofSize: 12)
        v.addSubview(lab)
    }
    func addLabTop(v:UIView,str:String){
        let lab = UILabel.init(frame: CGRect.init(x: 58, y: 9, width: SCREEN_WIDTH - 30 - 58 - 10, height: 20))
        lab.text = str//"市场定位决策分析"
        lab.textColor = UIColor.colorWithHex(hexStr: "#484848")
        lab.font = UIFont.init(name: "PingFangSC-Semibold", size: 15)
        v.addSubview(lab)
    }
    func addImg(v:UIView){
        // img
        let img = UIImageView.init(frame: CGRect.init(x: 10, y: 12, width: 33, height: 33))
        v.addSubview(img)
        img.image = UIImage.init(named: "courseDetailBook")
    }

}
