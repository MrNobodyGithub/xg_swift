//
//  HomeResListTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/22.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit


class circleView: UIView {
    
    var progress: Double = 0.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        let width = 26
        let radius = width / 2
        
        let path : UIBezierPath = UIBezierPath.init(arcCenter: CGPoint.init(x: radius, y: radius), radius: CGFloat(radius - 2), startAngle: CGFloat(0 - M_PI_2) , endAngle: CGFloat(self.progress * 2 * .pi - .pi / 2)  , clockwise: true)
        path.lineWidth = 3
        UIColor.colorWithHex(hexStr: "54B6F1").setStroke()
        path.stroke()
    }
}

protocol HomeResListTableViewCellDelegate:NSObjectProtocol {
    func HomeResListTableViewCellDelegateTapDownLoad(m:ModelCourseInfomation,indexP:IndexPath)
    func HomeResListTableViewCellDelegateTapSee(m:ModelCourseInfomation,indexP:IndexPath)
}

class HomeResListTableViewCell: UITableViewCell {
    
    var delegate:HomeResListTableViewCellDelegate?
    var indexP:IndexPath?
    @IBOutlet weak var viewType: UIView!
    @IBOutlet weak var labType: UILabel!
    
    @IBOutlet weak var labTimeAndSize: UILabel!
    
    @IBOutlet weak var labLike: UILabel!
    @IBOutlet weak var labSee: UILabel!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var viewCorner: UIView!
    
    
    @IBOutlet weak var viewTapDown: UIView!
    @IBOutlet weak var imgDownload: UIImageView!
    
    @IBOutlet weak var viewDownload: UIView!
    
    var timer: Timer?
 
    var model:ModelCourseInfomation?{
        didSet{
            self.labType.text = model!.srcFormat
            self.labTitle.text = model!.title
            let strTime = model!.publishTime
            let strSize = String(model!.srcSize.toInt() / 1000) + "KB"
            self.labTimeAndSize.text = strTime + " " + strSize
            self.labSee.text = model!.visible
            self.labLike.text = model!.likes
            
            if model!.fileIsExist {
                self.imgDownload.image = UIImage.init(named: "look")
            }else{
                self.imgDownload.image = UIImage.init(named: "download")
            }
        }
    }
    
    var process: Double = 0 {
        didSet{
            imgDownload.isHidden = true
            viewDownload.isHidden = false
            self.cirView?.progress = process
            
            if process >= 0.99 {
                self.viewDownload.isHidden = true
                self.imgDownload.isHidden = false
                model?.fileIsExist = true
                self.imgDownload.image = UIImage.init(named: "look")
            }
 
        }
    }
//
    var cirView: circleView?
    var number:Float = 0;
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(hexStr: "F8F9FA")
        // Initialization code
        setupViews()
        self.cirView = viewDownload as! circleView
       
    
        self.viewTapDown.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapDownLoad))
        self.viewTapDown.addGestureRecognizer(tap)
        
        
        
    }
    @objc func tapDownLoad(){
        
        if model?.fileIsExist ?? false {
            if (delegate != nil) && delegate?.responds(to: Selector(("HomeResListTableViewCellDelegateTapSee:"))) != nil {
                delegate?.HomeResListTableViewCellDelegateTapSee(m: model!, indexP: indexP!)
            }
            
            // 查看文件
        }else{
            // 下载文件
            if (delegate != nil) && delegate?.responds(to: Selector(("HomeResListTableViewCellDelegateTapDownLoad:"))) != nil {
                delegate?.HomeResListTableViewCellDelegateTapDownLoad(m: model!, indexP: indexP!)
            }
            
            
        }
    }
//    @objc func timeAction(){
//        number += 0.02
//        if  number >= 1 {
//            number = 0
//            timer?.invalidate()
//             
//
//        }
//        self.cirView!.progress = number
//    }
//    deinit {
//        timer?.invalidate()
//        timer = nil
//    }

    func setupViews(){
        
        let rect = CGRect.init(x: 0 , y: 0, width: SCREEN_WIDTH - 32, height: 95)
        let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: 8, height: 8))
        
        let layer = CAShapeLayer.init()
        layer.frame = rect
        layer.path = path.cgPath
        viewCorner.layer.mask = layer
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    } 
}
