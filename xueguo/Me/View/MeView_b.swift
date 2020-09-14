//
//  MeView_b.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/23.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class MeView_b: UIView {
    
    @IBOutlet weak var viewCon: UIView!
    @IBOutlet weak var topView: UIView!
    
    var viewPro: UIView? // 彩色背景
    var progress:CGFloat = 0.5 {
        didSet{
            // 0 进度条
            setupGraView(progress)
            //1 指示
            
            let width:CGFloat =  35
            let height:CGFloat = 22
            
            let x:CGFloat = (viewPro?.maxX())! - width
            let y:CGFloat = (viewPro?.minY())! - height - 5
            let v: UIView = UIView.init(frame: CGRect.init(x: x, y: y, width: width, height: height))
            self.viewCon.addSubview(v)
            
            let imgV: UIImageView = UIImageView.init(frame: v.bounds)
            v.addSubview(imgV)
            imgV.image = UIImage.init(named: "flagIndex")
            imgV.contentMode = .scaleAspectFit

            let lab :UILabel = UILabel.init(frame: v.bounds)
            v.addSubview(lab)
            lab.text = String.init(format: "%.f", progress * 100) + "%"
            
            lab.contentMode = .center
            lab.textAlignment = .center
            lab.textColor = .white
            lab.font  = UIFont.systemFont(ofSize: 13)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewGray()
    }
    func setupGraView(_ progress:CGFloat) {
        let difL : CGFloat = 19
        let difBottom : CGFloat = 17
        let height: CGFloat = 20
        
        let width =  (SCREEN_WIDTH - difL * 2 - 2 * 16) * progress
        let v : UIView = UIView.init(frame: CGRect.init(x: difL, y: 106 - topView.sd_height - difBottom - height, width: width, height: height))
        self.viewCon.addSubview(v)
        v.layer.cornerRadius = height / 2
        v.layer.masksToBounds = true
        viewPro = v
        CommonTool.addGradientColo(v.layer, CGSize.init(width: width, height: height), ["82C8FD","61CC7D"])
        

    }
    func setupViewGray(){
        let difL : CGFloat = 19
        let difBottom : CGFloat = 17
        
        let height: CGFloat = 20
        let width =  SCREEN_WIDTH - difL * 2 - 2 * 16
        
        let viewBg: UIView = UIView.init(frame: CGRect.init(x: difL, y:  self.frame.size.height - topView.sd_height - height - difBottom, width:width, height: height))
        self.viewCon.addSubview(viewBg)
        
        viewBg.backgroundColor =  UIColor.colorWithHex(hexStr: "F6F6F6")
        viewBg.layer.cornerRadius = 10
    }
}
