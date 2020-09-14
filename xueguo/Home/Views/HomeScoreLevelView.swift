//
//  HomeScoreLevelView.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/26.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit

class HomeScoreLevelView: UIView {

    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewGraph: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        addCorner()
        baseConfiguration()
        setupViews()
        
    }
    func setupViews(){
        
        // 1 画扇形图
        let point = CGPoint.init(x: viewGraph.frame.width / 2, y: viewGraph.frame.height/2)
        
        let scaleArr:[CGFloat] = [0.4,0.3,0.15,0.15]
        let colorArr:[UIColor] = [UIColor.colorWithHex(hexStr: "8DE5B2"),
                                  UIColor.colorWithHex(hexStr: "B8E6FF"),
                                  UIColor.colorWithHex(hexStr: "F8CE6B"),
                                  UIColor.colorWithHex(hexStr: "A09E9E")]
        let gradColorArr = [UIColor.colorWithHex(hexStr: "54C67B"),
                            UIColor.colorWithHex(hexStr: "82C8FD"),
                            UIColor.colorWithHex(hexStr: "EFA039"),
                            UIColor.colorWithHex(hexStr: "676565")]
        let longArr: [CGFloat] = [80, 74, 67 ,67]
        plotSector(point, scaleArr, colorArr, longArr,gradColorArr)
        
        // 2 标注扇形图
        var number:Int  = -1
        var total:CGFloat = 0;
        var midAng: CGFloat = 0
        for scale in scaleArr{
            number = number + 1
            total = total + scale
            midAng =  total - scale / 2
            let rad :CGFloat = longArr[number]
            calSecondPoint(point, rad - 25, midAng,colorArr[number],scale)
        }
//
    }
    // 圆心 半径  旋转角度(整体占比)  获得第二个点
    func calSecondPoint(_ point:CGPoint,_ radius: CGFloat,_ angles : CGFloat,_ color:UIColor,_ oriAng: CGFloat ) {
        // 默认从 0 开始计算弧度
        let anga = asin(0 / radius)
//        let anga = asin((firstPoint.x - point.x) / radius)
        + CGFloat(.pi / 180 * 360 * Double(angles))
        //        +
        let x1 = point.x + sin(anga) * radius
        let y1 =  point.y - cos(anga) * radius
        
        let lab = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 20))
        lab.backgroundColor = .clear
        lab.center = CGPoint.init(x: x1, y: y1)
        lab.font = UIFont.systemFont(ofSize: 12)
        lab.textColor = .white
        lab.textAlignment = .center
        lab.text = String.init(format: "%.f", oriAng * 100) + "%"
        
        self.viewGraph.addSubview(lab)
        
            }
    
    func plotSector(_ point: CGPoint,_ scaleArr: [CGFloat],_ colorArr:[UIColor],_ longArr:[CGFloat],_ gradColorArr: [UIColor]){
        
        
        //0 扇形图
        var number = -1
        var totalScale:CGFloat = 0
        for scale in scaleArr {
            number = number + 1
            totalScale = scale + totalScale
            let difScale:CGFloat = 0.25
            let beginAng = CGFloat(.pi / 180 * 360 * Double(totalScale - scale - difScale))
            let endAng = CGFloat(.pi / 180 * 360 * Double(totalScale-difScale))
            let aPath = UIBezierPath(arcCenter: point, radius:longArr[number],
                                     startAngle: beginAng, endAngle: endAng, clockwise: true)
            aPath.addLine(to: point)
            aPath.close()
            aPath.lineWidth = 1.0 // 线条宽度
//                        aPath.stroke() // Draws line 根据坐标点连线，不填充
            aPath.fill() // Draws line 根据坐标点连线，填充
//
            let layer = CAShapeLayer.init()
            layer.path = aPath.cgPath
            layer.fillColor = colorArr[number].cgColor
            layer.strokeColor = colorArr[number].cgColor
//            self.viewGraph.layer.addSublayer(layer)
            
            
            
            let gradLayer = CAGradientLayer.init()
            gradLayer.frame = CGRect.init(x: 0, y: 0, width: 180, height: 180)
//            gradLayer.colors = [RGB_arc_Color().cgColor,RGB_arc_Color().cgColor]
            gradLayer.colors = [colorArr[number].cgColor,gradColorArr[number].cgColor]
            gradLayer.startPoint = CGPoint.init(x: 0, y: 1)
            gradLayer.endPoint = CGPoint.init(x: 1, y: 1)
            gradLayer.locations = [0.2,0.7]
            gradLayer.type = .axial
            
            self.viewGraph.layer.addSublayer(gradLayer)
            // 1 渐变色
            gradLayer.mask = layer

            
        }
        
    }
  
    func baseConfiguration() -> Void {
        self.viewGraph.backgroundColor = .white
    }
    
    func addCorner() -> Void {
        viewContent.layer.cornerRadius = 10
        viewContent.backgroundColor = .white
        viewContent.layer.shadowColor = UIColor.black.cgColor
        viewContent.layer.borderWidth = 0.1
        viewContent.layer.borderColor = viewContent.layer.shadowColor
        viewContent.layer.shadowOpacity = 0.4
        viewContent.layer.shadowOffset = CGSize.init(width: 0, height: 0)
    }
    
    
    
    //MARK:------------------暂存---------------------
    func testa(_ layer: CAShapeLayer,_ index:Int) -> Void {
        //定义渐变的颜色（从黄色渐变到橙色）
        //            let topColor = UIColor.colorWithHex(hexStr: "91DD8A")
        //            let buttomColor = UIColor.colorWithHex(hexStr: "54C77A")
        let topColor =  RGB_arc_Color()
        let buttomColor =  RGB_arc_Color()
        
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        let  size = CGSize.init(width: 180, height: 180)
        gradientLayer.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
        
    }
    func aaa(){
        //绘制UIBezierPath路径
        let path = UIBezierPath.init()
        let point: CGPoint = CGPoint.init(x: 0, y:0)
        path.addArc(withCenter: point, radius: 150, startAngle: 0, endAngle:  (CGFloat(Double.pi / 180 * 76)), clockwise: true)
        path.addLine(to: point)
        //绘制渐变 图片
        let img = drawLinearGradient(startColor: UIColor.green.cgColor, endColor: UIColor.red.cgColor)

        let layer = CAShapeLayer.init()
        //本质上生成一张渐变色图片 作为layer的填充背景
        layer.fillColor = UIColor.init(patternImage: img).cgColor
        layer.path = path.cgPath
        self.viewGraph.layer.addSublayer(layer)
    }
    
    /**
     绘制渐变
     */
    func drawLinearGradient(startColor:CGColor, endColor:CGColor) -> UIImage {
        //创建CGContextRef
        UIGraphicsBeginImageContext(self.viewGraph.bounds.size)
        let context = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath.init()
        
        path.addArc(withCenter: CGPoint.init(x: 0, y: 0), radius: 200, startAngle: 0, endAngle: CGFloat(( 200 * M_PI/180)), clockwise: true)
        
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations = [CGFloat(0.0), CGFloat(1.0)]
        let colors = [startColor, endColor]
        let gradient = CGGradient.init(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
        
        let pathRect: CGRect = path.cgPath.boundingBox
        //具体方向可根据需求修改
        let startPoint = CGPoint.init(x: pathRect.minX, y: pathRect.midY)
        let endPoint = CGPoint.init(x: pathRect.maxX, y: pathRect.midY)
        
        context?.saveGState()
        context?.addPath(path.cgPath)
        context?.clip()
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        context?.restoreGState()
        //获取绘制的图片
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }

    
}
