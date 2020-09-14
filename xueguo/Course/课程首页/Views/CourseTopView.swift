//
//  CourseTopView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/27.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

enum CourseTopViewType{
    case year_a
    case year_b
    case year_c
    case year_d
}

class CourseTopView: UIView {
    
    var blockType:BaseBlock?
    func reloadData(){
        if self.viewYear.subviews.count == 0 {
            self.setupViewYears()
        }
    }
    
    @IBOutlet weak var viewYear: UIView!
    @IBOutlet weak var viewCon: UIView!
    var flagBtn: UIButton?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        let h : CGFloat = 133
        CommonTool.addGradientColo(self.viewCon.layer, CGSize.init(width: SCREEN_WIDTH, height: h), ["93DE8A","#54C77A"])
    }
    func setupViews(){
        setupViewYears()
    }
    func setupViewYears(){
        
        var end:Int = 0
        var start:Int = 0
        
        
        var isGoOn = false
        let model:ModelUser = CommonTool.unarhiveUserData()
        if model.enrolmentTime.count > 4  && model.graduationTime.count > 4{
            let timeStart = Int(model.enrolmentTime.prefix(4))
            let timeEnd = Int(model.graduationTime.prefix(4))
            end = timeEnd!
            start = timeStart!
            if timeEnd! - timeStart! > 0 {
                isGoOn = true
            }
        }
        
        if isGoOn {
            
            var scContentW = SCREEN_WIDTH
            
            var w = SCREEN_WIDTH / 4
            if end - start > 3 {
                w = SCREEN_WIDTH / 4.25
                scContentW = w * CGFloat(end - start + 1)
            }
            
            let h:CGFloat = 28
            let dif:CGFloat = 12
            let btnW = w  - dif * 2
            let btnH:CGFloat = h
            
            // 创建 滚动视图
            let sc:UIScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: h))
            sc.showsHorizontalScrollIndicator = false
            sc.contentSize = CGSize.init(width: scContentW, height: h)
            sc.isScrollEnabled = true
            self.viewYear.addSubview(sc)
            
            
            for i in 0 ... end - start{
                let rect = CGRect.init(x: dif + CGFloat(i) * w, y: 0, width: btnW, height: btnH)
                let btn = ZUIButton.init(frame: rect)
                
                btn.setTitle(String(start + i) + "年", for: .normal)
                btn.cusData = String(start + i)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                btn.titleLabel?.adjustsFontSizeToFitWidth = true
                sc.addSubview(btn)
                
                let color:UIColor = UIColor.colorWithHex(hexStr: "#FFFFFF")
                let colorSel:UIColor = UIColor.colorWithHex(hexStr: "#5BC97C")
                
                let bgColor: UIColor = UIColor.RGBAColor(r: 255, g: 255, b: 255, a: 0.36)
                let bgColorSel:UIColor = UIColor.colorWithHex(hexStr: "#FFFFFF")

                btn.setTitleColor(color, for: .normal)
                btn.setTitleColor(colorSel, for: .selected)
                btn.backgroundColor = bgColorSel
                btn.layer.cornerRadius = btnH / 2
                btn.layer.masksToBounds = true
                btn.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpInside)
                if i == 0 {
                    btn.isSelected = true
                    flagBtn = btn
                    btn.backgroundColor = bgColorSel
                }else{
                    btn.isSelected = false
                    btn.backgroundColor = bgColor
                }   
            }
        }
    }
    
    

    @objc func btnAction(btn:ZUIButton) {
        if btn == flagBtn {
            return
        }
        let data = btn.cusData as! String
        
        let bgColor: UIColor = UIColor.RGBAColor(r: 255, g: 255, b: 255, a: 0.36)
        let bgColorSel:UIColor = UIColor.colorWithHex(hexStr: "#FFFFFF")
        
        
        btn.isSelected = true
        btn.backgroundColor = bgColorSel
        flagBtn?.isSelected = false
        flagBtn?.backgroundColor = bgColor
        flagBtn = btn
        
        if let _ = blockType{
            blockType!(data)
        }
        
        
    }
    


}
