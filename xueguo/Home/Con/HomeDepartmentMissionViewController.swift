//
//  HomeDepartmentMissionViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class HomeDepartmentMissionViewController: UIViewController {
    
    @IBOutlet weak var viewBlurView: UIView!
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var labTitle: UILabel!
    
    @IBOutlet weak var viewDown: UIView!
    
    var scrollView: UIScrollView?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        //0  添加h模糊效果
//        let blurEffect = UIBlurEffect(style: .dark)
//        let blurView = UIVisualEffectView.init(effect: blurEffect)
//        blurView.frame = self.viewBlurView.bounds
//        blurView.alpha = 0.618
//        self.viewBlurView.addSubview(blurView)
        //1 添加顶部圆角
        var rect = self.viewDown.bounds
        rect.size.width = SCREEN_WIDTH
        let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners:[.topRight,.topLeft], cornerRadii: CGSize.init(width: 20, height: 20))
        let layer = CAShapeLayer.init()
        layer.frame = rect
        layer.path = path.cgPath
        self.viewDown.layer.mask = layer
    }
    func setupViews(){
        setUpScrollView()
//        setupLab()
        requestData()
    }
    func setUpScrollView() -> Void {
        var rect :CGRect = self.viewDown.bounds
        let h = SCREEN_HEIGHT - self.viewBlurView.sd_height
        rect.size = CGSize.init(width: SCREEN_WIDTH , height: h)
        scrollView =  UIScrollView.init(frame: rect)
        scrollView?.contentSize = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_WIDTH)
        self.viewDown.addSubview(scrollView!)
    }
    
    //MARK: --------------------requestdata------------------
    func requestData() {
        let param:ParamMission = ParamMission.init()
        param.collegeId = CommonTool.unarhiveUserData().collegeId
        param.academyId = CommonTool.unarhiveUserData().academyId
        HomeTool.mission(params: param.toJSON()!, success: { ( res) in
            if res.success{
                let model:ModelMission = res.data as! ModelMission
                self.title = model.schoolList.first?.title
                self.labTitle.text = model.schoolList.first?.schoolName
                if model.schoolList.first?.schoolLogo.count ?? 0 > 0  {
                    self.imgIcon.z_imgUrl(urlStr: model.schoolList.first!.schoolLogo)
                }
                
                var detaila :String = ""
                for m:ModelMission_School_Data in model.schoolList.first!.data{
                    detaila.append(m.content)
                    detaila.append("\n")
                }
                var detailB:String = ""
                for m:ModelMission_School_Data in model.collegeList.first?.data ?? [ModelMission_School_Data()]{
                    detailB.append(m.content)
                    detailB.append("\n")
                }
                
                self.setupLab(schoolDetail: detaila, colleageDetail: detailB, colleageTitle: model.collegeList.first!.content)
                
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
    
    func setupLab(schoolDetail:String,colleageDetail:String,colleageTitle:String) -> Void {
        let str = schoolDetail
        let lineSpace: CGFloat = 15
        let difL: CGFloat = 35
        let difTop: CGFloat = 16
        let mutStr = CommonTool.getAttributedWithString(str: str, linespace: lineSpace, fontSize: 15)
        let height = CommonTool.getAttributionHeightWithString(str: str, lineSpace: lineSpace, fontSize:15, width: SCREEN_WIDTH - difL * 2)
        let lab = UILabel.init(frame: CGRect.init(x: difL, y: difTop, width:SCREEN_WIDTH - 2 * difL, height: height))
        scrollView?.addSubview(lab)
        lab.attributedText = mutStr
        lab.numberOfLines = 0
        
        // line
        let line = UIView.init(frame: CGRect.init(x: difL, y: lab.maxY() + 30, width: SCREEN_WIDTH - 2 * difL, height: 1))
        scrollView?.addSubview(line)
        line.backgroundColor = UIColor.colorWithHex(hexStr: "EBEBEB")
        
        // big title
        let laba = UILabel.init(frame: CGRect.init(x: 0, y: line.maxY(), width: SCREEN_WIDTH, height: 56))
        scrollView?.addSubview(laba)
        laba.textAlignment = .center
        laba.font = UIFont.boldSystemFont(ofSize: 21)
        laba.textColor = UIColor.colorWithHex(hexStr: "515151")
        laba.text = colleageTitle
        // lab2
        let font_b : CGFloat = 15;
        let height_b = CommonTool.getAttributionHeightWithString(str: colleageDetail, lineSpace: lineSpace, fontSize:font_b, width: SCREEN_WIDTH - 2 * difL)
        let labb = UILabel.init(frame: CGRect.init(x: difL, y: laba.maxY()+10, width: SCREEN_WIDTH - 2 * difL, height: height_b))
        labb.attributedText = CommonTool.getAttributedWithString(str: colleageDetail, linespace: lineSpace, fontSize: font_b)
        labb.numberOfLines = 0
        labb.font = UIFont.systemFont(ofSize: font_b)
        scrollView?.addSubview(labb)
        scrollView?.contentSize = CGSize.init(width: SCREEN_WIDTH, height: labb.maxY() + 20)
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

    
    
//    func getAttributedWithString(str: String, linespace:CGFloat,font:UIFont) -> NSMutableAttributedString{
//        let paraSty = NSMutableParagraphStyle.init()
//        paraSty.lineSpacing = linespace
//        let mutStr = NSMutableAttributedString.init(string: str, attributes: [kCTFontAttributeName as NSAttributedString.Key:font])
//        mutStr.addAttribute(kCTParagraphStyleAttributeName as NSAttributedString.Key , value: paraSty, range: NSRange.init(location: 0, length: str.count))
//        mutStr.addAttribute(kCTForegroundColorAttributeName as NSAttributedString.Key, value: UIColor.colorWithHex(hexStr: "454545"), range: NSRange.init(location: 0, length: str.count))
//        return mutStr
//    }
    
//    func getAttributionHeightWithString(str: String, lineSpace:CGFloat, font: UIFont, width:CGFloat) -> CGFloat {
//        let parStyle = NSMutableParagraphStyle.init()
//        parStyle.lineSpacing = lineSpace
//        let arr = [kCTParagraphStyleAttributeName:parStyle,
//                   kCTFontAttributeName:font]
//        let newStr: NSString = str as NSString
//        let rect : CGRect = newStr.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: arr as [NSAttributedString.Key : Any], context: nil)
//        return rect.size.height
//    }
}
