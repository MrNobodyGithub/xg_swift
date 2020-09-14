//
//  CourseDetailStructViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/31.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailStructViewController: BaseViewController {
    
    //--------------------- in -------------------------------
    var courseId:String?
    //----------------------------------------------------
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfiguration()
        requestData()
        // Do any additional setup after loading the view.
    }
    func baseConfiguration() -> Void {
        self.title = "分值结构"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }
    func setupViews() {
        setupScrollView()
        
        let v1 = setupSectionView(y: 0, title: self.model.title, detail: "占学分:" + self.model.credit + "    " + "占成绩:" + self.model.score, imgNameIndex: 0)
        
        var flagV:UIView = v1
        for i in 0 ..< self.model.cloEvaluateList.count {
            flagV = setupModuleViewTop(y: flagV.maxY(), m: self.model.cloEvaluateList[i])
        }
        
        // 过程审核
        let v2 = setupSectionView(y: flagV.maxY(), title: self.model.processEvaluateTitle, detail: "占成绩: " + self.model.processEvaluateScore, imgNameIndex: 1, addH: 15)
 
        let v3 = setupModuleViewDown(arr: self.model.processEvaluateList, y: v2.maxY(), type: 0)
        
        self.scrollView?.contentSize = CGSize.init(width: SCREEN_WIDTH, height: v3.maxY())
        
        
 
//        let v5 = setupModuleViewDown(arr: Array.init(repeating: "", count: 3), y: v4.maxY(), type: 0)
//
//        let v6 = setupSectionView(y: v5.maxY(), title: "其他评核", detail: "占成绩：10", imgNameIndex: 2, addH: 15)
//
//
//        let v7 = setupModuleViewDown(arr: Array.init(repeating: "", count: 2), y: v6.maxY(), type: 1)
//        self.scrollView?.contentSize = CGSize.init(width: SCREEN_WIDTH, height: v7.maxY() + 40)
        
    }
    var scrollView :UIScrollView?
    func setupScrollView(){
        let y:CGFloat = NAV_HEIGHT + STATUS_HEIGHT
        let h:CGFloat = SCREEN_HEIGHT - y
        let v = UIScrollView.init(frame: CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h))
        scrollView = v
        self.view.addSubview(v)
        v.contentSize = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 2)
    }
    func setupModuleViewTop(y:CGFloat,m:ModelCourseCloEvaluateList) -> UIView{
        let dify:CGFloat = 5
        let h:CGFloat = CGFloat(m.scoreVoList.count) * 87  + 70
        let h1:CGFloat = 70
        let h2:CGFloat = 87
        
        let v = UIView.init(frame: CGRect.init(x: 15, y: y + dify, width: SCREEN_WIDTH-30, height: h))
        self.scrollView?.addSubview(v)
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        
        setupCellViewSec(superView: v, y: 0,m: m)
        for (index,sm) in m.scoreVoList.enumerated(){
            let suby = CGFloat(index) * h2 + h1
            setupCellView(superView: v, y: suby, m: sm)
        }
        
        
       return v
    }
    
    func setupModuleViewDown(arr:[ModelCourseProcessEvaluateList],y:CGFloat,type:Int = 0) -> UIView{
        // type -> 模块-> imageName 0 1
        let standH:CGFloat = 87
        let dify:CGFloat = 5
        let h:CGFloat = CGFloat(arr.count ) * standH
        let v = UIView.init(frame: CGRect.init(x: 15, y: y + dify, width: SCREEN_WIDTH-30, height: h))
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        self.scrollView?.addSubview(v)
        
        //subview
        
        var imgNameiIndex: Int = 0
        if type == 0{
            imgNameiIndex = 0
        }else if type == 1{
            imgNameiIndex = 3
        }
        for (index,m) in arr.enumerated(){
            let suby :CGFloat = standH * CGFloat(index)
            var ishidden:Bool = false
            if index == arr.count - 1 {
                ishidden = true
            }
            imgNameiIndex +=  1
        
            setupCellView_process(superView: v, y: suby, m: m, imgNameIndex: imgNameiIndex, titleFontNumber: 15, ishiddenLine: ishidden)
            

        }
        return v
    }
    
    func setupCellView_process(superView:UIView,y:CGFloat,m:ModelCourseProcessEvaluateList,imgNameIndex:Int = 0,titleFontNumber:Int = 13,ishiddenLine:Bool = false) {
        //imgname resDetail
        let h:CGFloat = 87
        let v = UINib.init(nibName: "CourseDetailStructCellView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailStructCellView
        v.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH-30, height: h)
        superView.addSubview(v)
        v.labTitle.text = m.title
        v.labMid.text = "占成绩: " + m.credit
        let stra:String =  "获得成绩: " + m.score
        v.labDown.text = stra
        v.labTitle.font = UIFont.systemFont(ofSize: CGFloat(titleFontNumber))
        v.viewLine.isHidden = ishiddenLine
        let imgName:String = "resDetail" + String.init(format: "%d", imgNameIndex)
        v.imgIcon.image = UIImage.init(named: imgName)
    }
    func setupCellView(superView:UIView,y:CGFloat,m:ModelCourseScoreVoList,imgNameIndex:Int = 0,titleFontNumber:Int = 13,ishiddenLine:Bool = false) {
        //imgname resDetail
        let h:CGFloat = 87
        let v = UINib.init(nibName: "CourseDetailStructCellView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailStructCellView
        v.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH-30, height: h)
        superView.addSubview(v)
        v.labTitle.text = m.title
        v.labMid.text = "占成绩: " + m.credit
        var stra:String = "获得成绩:" + m.score
        if m.achievement.count != 0{
            stra = stra + "       评分: " + m.achievement
        }
        v.labDown.text = stra
        v.labTitle.font = UIFont.systemFont(ofSize: CGFloat(titleFontNumber))
        v.viewLine.isHidden = ishiddenLine
        let imgName:String = "resDetail" + String.init(format: "%d", imgNameIndex)
        v.imgIcon.image = UIImage.init(named: imgName)
    }
    func setupCellViewSec(superView:UIView,y:CGFloat,m:ModelCourseCloEvaluateList){
        let h:CGFloat = 70
        let v = UINib.init(nibName: "CourseDetailStructCellViewSec", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailStructCellViewSec
        v.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH-30, height: h)
        superView.addSubview(v)
        v.labTitle.text  = m.title
        v.labDetial.text = "占学分: " + m.credit + "     " + "占成绩:" + m.score
    }
    
    func setupSectionView(y:CGFloat,title:String,detail:String,imgNameIndex:Int,addH:CGFloat = 0) -> CourseDetailStructSectionView{
        // 80 + 12
        let h:CGFloat = 80 + 12 + addH
        let v = UINib.init(nibName: "CourseDetailStructSectionView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailStructSectionView
        v.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h)
        v.layer.cornerRadius = 10
        v.layer.masksToBounds  = true
        
        self.scrollView?.addSubview(v)
        
        v.labTitle.text = title
        v.labDetail.text = detail
        let imageArr:[String] = ["struct_res","struct_process","struct_other"]
        v.imgStruct.image = UIImage.init(named: imageArr[imgNameIndex])
        
        return v
    }
    
    var model :ModelCourseScoreStruct = ModelCourseScoreStruct()
    
    
    //MARK: --------------------request-------------------
    func requestData(){
        let  param:ParamCourseDetail = ParamCourseDetail()
        param.userId = CommonTool.getUserId()
        param.courseId = self.courseId!
        CourseTool.courseScoreStruct(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.model = res.data as! ModelCourseScoreStruct
                self.setupViews()
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
        
    }

}
