//
//  MeView_c.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/23.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class MeView_c: UIView {

    
    @IBOutlet weak var viewCon: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        
        let width :CGFloat = self.viewCon.frame.width
        let height:CGFloat = self.viewCon.frame.height
        
        //1 添加三角形
        // 30 50 70 85
        let disArr = [30,50,70 ,85]
        let point : CGPoint = CGPoint.init(x: width / 2, y: height * 2 / 3 )
        
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
        
        
        // 3 根据数据 动态生成不规则三变形
        let pointArr = calPoints(point, 85)
        //        let rand_arr1: [CGFloat] = [0.2,0.6,0.4,0.8,0.9]
        let rand_arr1:[CGFloat] = [randData(),randData(),randData(),randData(),randData()]
        let rand_arr2:[CGFloat] = [randData(),randData(),randData(),randData(),randData()]
        let rand_arr3:[CGFloat] = [randData(),randData(),randData(),randData(),randData()]
        
        plotLine(calDynamic(point, pointArr, rand_arr1), 1, UIColor.colorWithHex(hexStr: "54C67B"))
        plotLine(calDynamic(point, pointArr, rand_arr2), 1, UIColor.colorWithHex(hexStr: "82C8FD"))
        plotLine(calDynamic(point, pointArr, rand_arr3), 1, UIColor.colorWithHex(hexStr: "EFA039"))
        
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
    
    private func randData() -> CGFloat {
        let num = 1 + arc4random_uniform(10)
        return CGFloat(num) / 10.0
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
        lineShape.frame = CGRect.init(x: 0, y: 0, width: self.viewCon.frame.width, height: viewCon.frame.height)
        lineShape.lineWidth = 1
        lineShape.lineJoin = CAShapeLayerLineJoin.miter
        lineShape.lineCap = CAShapeLayerLineCap.square
        lineShape.strokeColor =  UIColor.colorWithHex_same(s: 200) .cgColor
        lineShape.path = linePath.cgPath
        lineShape.fillColor = UIColor.clear.cgColor
        self.viewCon.layer.addSublayer(lineShape)
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
        lineShape.frame = CGRect.init(x: 0, y: 0,  width: self.viewCon.frame.width, height: self.viewCon.frame.height)
        lineShape.lineWidth = lineW
        lineShape.lineJoin = CAShapeLayerLineJoin.miter
        lineShape.lineCap = CAShapeLayerLineCap.square
        lineShape.strokeColor = color.cgColor
        lineShape.path = linePath.cgPath
        lineShape.fillColor = UIColor.clear.cgColor
        self.viewCon.layer.addSublayer(lineShape)
        drawLineAnimation(lineShape)
    }
    func calPoints(_ point:CGPoint, _ radius:CGFloat) -> [CGPoint]{
        
        // 左下开始 顺时针旋转 123 点
        let dif1x = point.x - radius * cos(CGFloat(M_PI_2 / 90 * 30))
        let dif1y = point.y + radius * sin(CGFloat(M_PI_2 / 90 * 30))
        let dif2x = point.x
        let dif2y = point.y - radius
        let dif3x = point.x + radius * cos(CGFloat(M_PI_2 / 90 * 30))
        let dif3y = point.y + radius * sin(CGFloat(M_PI_2 / 90 * 30))
       
        let point1 = CGPoint.init(x: dif1x, y: dif1y)
        let point2 = CGPoint.init(x: dif2x, y: dif2y)
        let point3 = CGPoint.init(x: dif3x, y: dif3y)
        
        return[point1,point2,point3]
        
    }
    
    
    func drawLineAnimation(_ layer : CALayer) {
        let bas = CABasicAnimation.init(keyPath: "strokeEnd")
        bas.duration = 2
        bas.fromValue = NSNumber.init(value: 0)
        bas.toValue = NSNumber.init(value: 1)
        layer.add(bas, forKey: "key")
    }

    

}
