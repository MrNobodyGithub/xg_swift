//
//  HomeTodayCourseView.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/26.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit

protocol HomeTodayCourseViewDelegate :NSObjectProtocol{
    func HomeTodayCourseViewDelegateAm(_ isOpen:Bool)
    func HomeTodayCourseViewDelegatePm(_ isOpen:Bool)
}
class HomeTodayCourseView: UIView {

    var delegate:HomeTodayCourseViewDelegate?
    
    @IBOutlet weak var viewTop: UIView!
    //MARK:------------------public---------------------
    var switchAm:Bool = true
    var switchPm:Bool = true
    //MARK:------------------private---------------------
    let defalutHeight :CGFloat = 40
    var viewAm: UIView?
    var viewPm: UIView?
    
    func resetFrame() {
        var frame = viewPm?.frame
        frame?.origin.y = (viewAm?.frame.maxY)! + 10
        viewPm?.frame = frame!
    }
    
    var dataPm:NSArray?{
        didSet{
            
            if viewPm != nil {
                for subview:UIView in (viewPm?.subviews)!{
                    subview.removeFromSuperview()
                }
                viewPm?.removeFromSuperview()
            }
            var height:CGFloat = CGFloat((dataPm?.count)! * Int(defalutHeight))
            if  !switchPm {
                height = defalutHeight
            }
            let pmView = UIView.init(frame: CGRect.init(x: 16, y: viewAm!.frame.maxY + 10, width: SCREEN_WIDTH-32, height: height))
            self.addSubview(pmView)
            viewPm = pmView
            //            amView.clipsToBounds = true
            pmView.layer.cornerRadius = 10
            pmView.layer.backgroundColor = UIColor.white.cgColor
            pmView.layer.shadowColor = UIColor.black.cgColor
            pmView.layer.borderWidth = 0.1
            pmView.layer.borderColor = pmView.layer.shadowColor
            pmView.layer.shadowOpacity = 0.4
            pmView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
            
            var number = 0;
            for _ in dataPm! {
                number = number + 1;
                if number == 1 {
                    setupFirstView(pmView,false)
                }else{
                    if switchPm {
                        setupSecondView(pmView, CGFloat(number))
                    }
                }
            }
        }
    }
    var dataAm: NSArray?{
        didSet{
            if viewAm != nil {
                for subview:UIView in (viewAm?.subviews)!{
                    subview.removeFromSuperview()
                }
               

                viewAm?.removeFromSuperview()
            }
            
            
                        var height:CGFloat = CGFloat((dataAm?.count)! * Int(defalutHeight))
            // switcham  false: 设置成 关闭状态
            if  !switchAm {
                height = defalutHeight
            }
            let amView = UIView.init(frame: CGRect.init(x: 16, y: viewTop.frame.maxY , width: SCREEN_WIDTH-32, height: height))
            self.addSubview(amView)
            viewAm = amView
            amView.layer.cornerRadius = 10
            amView.layer.backgroundColor = UIColor.white.cgColor
            amView.layer.shadowColor = UIColor.black.cgColor
            amView.layer.borderWidth = 0.1
            amView.layer.borderColor = amView.layer.shadowColor
            amView.layer.shadowOpacity = 0.4
            amView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
            
            var number = 0;
            for _ in dataAm! {
                number = number + 1;
                if number == 1 {
                    setupFirstView(amView, true)
                }else{
                    if switchAm {
                        setupSecondView(amView, CGFloat(number))
                    }
                }
            }
        }
    }
    func setupSecondView(_ superView:UIView,_ index:CGFloat) -> Void{
        let v = UIView.init(frame: CGRect.init(x: 0, y: (index - 1) * defalutHeight, width: superView.frame.width, height: defalutHeight))
        superView.addSubview(v)
       
        //1 line view
        let line = UIView.init(frame: CGRect.init(x: 82, y: 0, width: v.frame.width - 82 - 20, height: 1))
        v.addSubview(line)
        line.backgroundColor = UIColor.colorWithHex(hexStr: "eb")
        //2 lab  3节
        let lab_a = UILabel.init(frame: CGRect.init(x: line.frame.minX + 25, y: 0, width: 80, height: defalutHeight))
        v.addSubview(lab_a)
        lab_a.text = String.init(format: "3节  %.f", index)
        lab_a.font = UIFont.init(name: "PingFangSC-Semibold", size: 13)
        lab_a.textColor = UIColor.colorWithHex(hexStr: "48")
        //3 lab conten
        let lab_b = UILabel.init(frame: CGRect.init(x: lab_a.frame.maxX , y: 0, width: superView.frame.width - lab_a.frame.maxX , height: defalutHeight))
        v.addSubview(lab_b)
        lab_b.text = "市场定位分析"
        lab_b.font = UIFont.init(name: "PingFangSC-Semibold", size: 13)
        lab_b.textColor = UIColor.colorWithHex(hexStr: "48")
        
    }
    
    func setupFirstView(_ superView:UIView,_ isAm:Bool) -> Void {
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: superView.frame.width, height:defalutHeight))
        superView.addSubview(v)
        let colorView = UIView.init(frame: CGRect.init(x: 9, y: 0, width: 4, height: 16))
        v.addSubview(colorView)
        colorView.center.y = v.center.y
        colorView.backgroundColor = UIColor.colorWithHex(hexStr: "54C67B")
        colorView.layer.cornerRadius = 4.5
        // 上午
        let labAm = UILabel.init(frame: CGRect.init(x: colorView.frame.maxX+5, y: 0, width: 70, height: defalutHeight))
        v.addSubview(labAm)
        labAm.text = "上午"
        if !isAm {
            labAm.text = "下午"
        }
        labAm.font = UIFont.init(name: "PingFangSC-Semibold", size: 17)
        labAm.textColor = UIColor.colorWithHex(hexStr: "48")

        labAm.layer.borderColor = UIColor.white.cgColor
        labAm.layer.shadowOpacity = 0.0
//
        // 1~2 节
        let lab_a = UILabel.init(frame: CGRect.init(x: labAm.frame.maxX + 20, y: 0, width: 80, height: defalutHeight))
        v.addSubview(lab_a)
        lab_a.text = "1~2节"
//        lab_a.font = UIFont.boldSystemFont(ofSize: 13)
//        lab_a.font = UIFont.systemFont(ofSize: 13)
        lab_a.font = UIFont.init(name: "PingFangSC-Semibold", size: 13)
        lab_a.textColor = UIColor.colorWithHex(hexStr: "48")
        
        // 市场定位分析
        let btnW:CGFloat  = 30
        let btnR_dif:CGFloat  = 10
        let lab_b = UILabel.init(frame: CGRect.init(x: lab_a.frame.maxX , y: 0, width: superView.frame.width - lab_a.frame.maxX - btnW - btnR_dif, height: defalutHeight))
        
        v.addSubview(lab_b)
        lab_b.text = "市场定位分析"
        lab_b.font = UIFont.init(name: "PingFangSC-Semibold", size: 13)
        lab_b.textColor = UIColor.colorWithHex(hexStr: "48")
        
        // btn
        let btn = ZUIButton.init(frame: CGRect.init(x: lab_b.frame.maxX, y: 0, width: btnW, height: defalutHeight))
        v.addSubview(btn)
        btn.setImage(UIImage.init(named: "arrow_right_g"), for: .normal)
        btn.setImage(UIImage.init(named: "arrow_down_b"), for: .selected)
        
        btn.addTarget(self, action: #selector(btnActionAm(_:)), for: .touchUpInside)
        if isAm {
            btn.cusSel = true
            btn.isSelected = !switchAm
            
        }else{
            btn.cusSel = false
            btn.isSelected = !switchPm
        }
    }
    
    @objc func btnActionAm(_ btn :ZUIButton) {
        btn.isSelected = !btn.isSelected
        if  btn.cusSel {
            if (delegate != nil) && delegate?.responds(to: Selector(("HomeTodayCourseViewDelegateAm:"))) != nil {
                delegate?.HomeTodayCourseViewDelegateAm(!btn.isSelected)
            }
            
        }else{
            if (delegate != nil) && delegate?.responds(to: Selector(("HomeTodayCourseViewDelegatePm:"))) != nil {
                delegate?.HomeTodayCourseViewDelegatePm(!btn.isSelected)
            }
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
