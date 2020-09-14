//
//  CourseDetailLeftTeachersView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/30.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import SDWebImage



class CourseDetailLeftTeachersView: UIView {
 // 91 + 13 = 104
    let h:CGFloat = 91
    var scrollView:UIScrollView?
    @IBOutlet weak var viewCon: UIView!
    var dataArr:[ModelTeacher]? {
        didSet{
            // w 78
            addSub(arr: dataArr!)
        }
    }
    
    
    var callbackData:BaseBlock_T<ModelTeacher>?
    
    func addSub(arr:[ModelTeacher]){
        let w:CGFloat = 78
    
        self.scrollView?.contentSize = CGSize.init(width: w * CGFloat(arr.count), height: h)
         for (index,value) in arr.enumerated() {
           let rect = CGRect.init(x: 0 + CGFloat(index) * w, y: 0, width: w, height: h)
            let v = UIView.init(frame: rect)
            v.tag = 1000 + index
            self.scrollView?.addSubview(v)
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapGes(ges:)))
            v.addGestureRecognizer(tap)
            let model:ModelTeacher = value
            // image
            addImg(v: v, url: value.avatar,sex: model.sex)
            addLab(v: v,title: value.name)
        }
        
    }
    func addImg(v:UIView,url:String,sex:String){
        let w:CGFloat = 46
        let x:CGFloat = 24
        let y:CGFloat = 10
        let img :UIImageView = UIImageView.init(frame: CGRect.init(x: x, y: y, width: w, height: w))
        v.addSubview(img)
        if url == "" {
            if sex == "1"{
                img.image = UIImage.init(named: "teacher_sex_man")
            }else
            {
                img.image = UIImage.init(named: "teacher_sex_female")
            }
        }else
        {
            img.z_imgUrl(urlStr: url)
        }
    }
    func addLab(v:UIView,title:String){
        let w:CGFloat = 46 + 4 * 2
        let x:CGFloat = 20
        let y:CGFloat = 10 + 46 + 3
        let h:CGFloat = 18
        let lab = UILabel.init(frame: CGRect.init(x: x, y: y, width: w, height: h))
        v.addSubview(lab)
        lab.textAlignment = .center
        lab.textAlignment = .center
        lab.text = title
    }
    @objc func tapGes(ges:UITapGestureRecognizer){
        let index =  ges.view!.tag - 1000
        print(index)
        let model:ModelTeacher = dataArr![index]
        if let _ = callbackData{
            callbackData!(model)
        }
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
          scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH - 30, height: h))
        self.viewCon.addSubview(scrollView!)
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.showsVerticalScrollIndicator = false
        let arr: [String] = Array.init(repeating: "a", count: 10)
//        addSub(arr: arr)
        
    }
    
}
