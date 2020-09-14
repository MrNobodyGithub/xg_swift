//
//  HomeScoreDistributeView.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/26.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit

class HomeScoreDistributeView: UIView {
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewPentagon: UIView!
    func refreshUIAnimation() -> Void {
         self.viewPentagon.layer.removeFromSuperlayer()
        self.viewPentagon.layer.removeAllAnimations()
        setupViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        self.viewPentagon.backgroundColor = .white
    }
    func setupViews(){
        //0 添加圆角
        addCorner()
        //1 添加五边形
        // 30 50 70 85
        let disArr = [30,50,70,85]
        let point : CGPoint = CGPoint.init(x: 85, y: 85)

        var number = 0;
        var lineW:CGFloat = 1
        var lineColor: UIColor?
        for dis in disArr {
            number = number + 1
            if number == disArr.count {
                lineW = 2
                lineColor = UIColor.colorWithHex_same(s: 173)
            }else{
                lineW = 1
                lineColor = UIColor.colorWithHex_same(s: 200)
            }
            plotLine(calPoints(point, CGFloat(dis)), lineW,lineColor!)
        }
        //2 添加五角主干 类似*
        plotPointTrunk(calPoints(point, 85), point)
        // 3 根据数据 动态生成不规则五边形
        let pointArr = calPoints(point, 85)
//        let rand_arr1: [CGFloat] = [0.2,0.6,0.4,0.8,0.9]
        let rand_arr1:[CGFloat] = [randData(),randData(),randData(),randData(),randData()]
        let rand_arr2:[CGFloat] = [randData(),randData(),randData(),randData(),randData()]
        let rand_arr3:[CGFloat] = [randData(),randData(),randData(),randData(),randData()]
        
        plotLine(calDynamic(point, pointArr, rand_arr1), 1, UIColor.colorWithHex(hexStr: "54C67B"))
        plotLine(calDynamic(point, pointArr, rand_arr2), 1, UIColor.colorWithHex(hexStr: "82C8FD"))
        plotLine(calDynamic(point, pointArr, rand_arr3), 1, UIColor.colorWithHex(hexStr: "EFA039"))
    }
    private func randData() -> CGFloat {
        let num = 1 + arc4random_uniform(10)
        return CGFloat(num) / 10.0
    }
    
    func calDynamic(_ oriPoint:CGPoint, _ pointArr:[CGPoint] ,_ progressArr:[CGFloat]) -> [CGPoint] {
        
        var newArr: [CGPoint] = []
        var number = 0;
        for point in pointArr{
            let difx = point.x - oriPoint.x
            let dify = point.y - oriPoint.y
            
            let newx = difx * progressArr[number] + oriPoint.x
            let newy = dify * progressArr[number] + oriPoint.y
            
            number = number + 1
            let newPoint = CGPoint.init(x: newx, y: newy)
            newArr.append(newPoint)
        }
        return newArr
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
    
    func plotPointTrunk(_ arr:[CGPoint],_ oriPoint: CGPoint){
        //创建路径
        let linePath = UIBezierPath()
        //起点
        linePath.move(to: oriPoint)
        for point in arr {
            linePath.addLine(to: point)
            linePath.addLine(to: oriPoint)
        }
        //添加其他点
        //        linePath.addLine(to: CGPoint.init(x: 160, y: 160))
        //闭合路径
        linePath.close()
        
        //设施路径画布
        let lineShape = CAShapeLayer()
        lineShape.frame = CGRect.init(x: 0, y: 0, width: viewPentagon.frame.width, height: viewPentagon.frame.height)
        lineShape.lineWidth = 1
        lineShape.lineJoin = CAShapeLayerLineJoin.miter
        lineShape.lineCap = CAShapeLayerLineCap.square
        lineShape.strokeColor =  UIColor.colorWithHex_same(s: 200) .cgColor
        lineShape.path = linePath.cgPath
        lineShape.fillColor = UIColor.clear.cgColor
        self.viewPentagon.layer.addSublayer(lineShape)
        drawLineAnimation(lineShape)
    }
    
    
    func plotLine(_ arr:[CGPoint],_ lineW: CGFloat, _ color:UIColor){
        //创建路径
        let linePath = UIBezierPath()
        //起点
        linePath.move(to: arr.last!)
        for point in arr {
            linePath.addLine(to: point)
        }
        //添加其他点
//        linePath.addLine(to: CGPoint.init(x: 160, y: 160))
        //闭合路径
        linePath.close()
        
        //设施路径画布
        let lineShape = CAShapeLayer()
        lineShape.frame = CGRect.init(x: 0, y: 0,  width: viewPentagon.frame.width, height: viewPentagon.frame.height)
        lineShape.lineWidth = lineW
        lineShape.lineJoin = CAShapeLayerLineJoin.miter
        lineShape.lineCap = CAShapeLayerLineCap.square
        lineShape.strokeColor = color.cgColor
        lineShape.path = linePath.cgPath
        lineShape.fillColor = UIColor.clear.cgColor
        self.viewPentagon.layer.addSublayer(lineShape)
        drawLineAnimation(lineShape)
    }
    
    func calPoints(_ point:CGPoint, _ radius:CGFloat) -> [CGPoint]{
        
        // 左下开始 逆时针旋转 12345 点 72-> 36 -> 54
        let dif1x = point.x - radius * sin(CGFloat(M_PI_2 / 90 * 36))
        let dif1y = point.y + radius * cos(CGFloat(M_PI_2 / 90 * 36))
        let dif2x = point.x + radius * sin(CGFloat(M_PI_2 / 90 * 36))
        let dif2y = point.y + radius * cos(CGFloat(M_PI_2 / 90 * 36))
        let dif3x = point.x + radius * cos(CGFloat(M_PI_2 / 90 * 18))
        let dif3y = point.y - radius * sin(CGFloat(M_PI_2 / 90 * 18))
        let dif4x = point.x
        let dif4y = point.y - radius
        let dif5x = point.x - radius * cos(CGFloat(M_PI_2 / 90 * 18))
        let dif5y = point.y - radius * sin(CGFloat(M_PI_2 / 90 * 18))

        let point1 = CGPoint.init(x: dif1x, y: dif1y)
        let point2 = CGPoint.init(x: dif2x, y: dif2y)
        let point3 = CGPoint.init(x: dif3x, y: dif3y)
        let point4 = CGPoint.init(x: dif4x, y: dif4y)
        let point5 = CGPoint.init(x: dif5x, y: dif5y)
        
        return[point1,point2,point3,point4,point5]
        
    }
    
    func drawLineAnimation(_ layer : CALayer) {
        let bas = CABasicAnimation.init(keyPath: "strokeEnd")
        bas.duration = 2
        bas.fromValue = NSNumber.init(value: 0)
        bas.toValue = NSNumber.init(value: 1)
        layer.add(bas, forKey: "key")
    }
}
