//
//  HomeScoreStatisticsView.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/26.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit

class HomeScoreStatisticsView: UIView {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var viewCircle: UIView!

    @IBOutlet weak var labScore: UILabel!
    @IBOutlet weak var labFullScore: UILabel!

    @IBOutlet weak var labHigh: UILabel!
//
    
    var timer :Timer!
    
    var shapeLayer:CAShapeLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        
    }
    func setupViews(){
        addCorner()
        cicleWithScale(0.95)
    }
    func addCorner() -> Void {
        viewBg.layer.cornerRadius = 10
        viewBg.backgroundColor = .white
        viewBg.layer.shadowColor = UIColor.black.cgColor
        viewBg.layer.borderWidth = 0.1
        viewBg.layer.borderColor = viewBg.layer.shadowColor
        viewBg.layer.shadowOpacity = 0.4
        viewBg.layer.shadowOffset = CGSize.init(width: 0, height: 0)

    }
    
 
  
    func cicleWithScale(_ scale : CGFloat) -> Void {
        viewCircle.backgroundColor = .white
        let point = CGPoint.init(x: 80, y: 80)
        let radius:CGFloat = 90
        let lineW = 12
        
        // 内圈
        
        let grayPatha = UIBezierPath.init()
        grayPatha.addArc(withCenter: point, radius: radius-10, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        let grayLayera = CAShapeLayer.init()
        grayLayera.path = grayPatha.cgPath
        grayLayera.lineWidth = CGFloat(3)
        grayLayera.fillColor = UIColor.clear.cgColor
        grayLayera.strokeColor =  UIColor.colorWithHex_same(s: 246).cgColor
        grayLayera.lineJoin = CAShapeLayerLineJoin.round
        self.viewCircle.layer.addSublayer(grayLayera)
        
        // 底色圈
        let grayPath = UIBezierPath.init()
        grayPath.addArc(withCenter: point, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        let grayLayer = CAShapeLayer.init()
        grayLayer.path = grayPath.cgPath
        grayLayer.lineWidth = CGFloat(lineW)
        grayLayer.fillColor = UIColor.clear.cgColor
        grayLayer.strokeColor = UIColor.colorWithHex_same(s: 246).cgColor 
        grayLayer.lineJoin = CAShapeLayerLineJoin.round
        self.viewCircle.layer.addSublayer(grayLayer)
        
        let path = UIBezierPath.init()
        path.addArc(withCenter: point, radius: radius, startAngle: CGFloat(-M_PI_2), endAngle: (CGFloat(M_PI * 2) * scale + CGFloat(-M_PI_2)), clockwise: true)
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = CGFloat(lineW)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.RGBColor(r: 110, g: 203, b: 255).cgColor

        shapeLayer.lineJoin = .round
        shapeLayer.lineCap = .round
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
        self.viewCircle.layer.addSublayer(shapeLayer)
        drawLineAnimation(shapeLayer)
    }
    func drawLineAnimation(_ layer : CALayer) {
        let bas = CABasicAnimation.init(keyPath: "strokeEnd")
        bas.duration = 2
        bas.fromValue = NSNumber.init(value: 0)
        bas.toValue = NSNumber.init(value: 1)
        layer.add(bas, forKey: "key")
    }
}



