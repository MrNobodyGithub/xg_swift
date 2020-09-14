//
//  CourseDetailViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/30.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CourseDetailViewController: BaseViewController {
    //-> data 传入 课程id
    var modelPush:ModelCourseList?
    
    //views
    var scrollView: UIScrollView?
    var viewL:UIScrollView?
    var viewM:UIScrollView?
    var viewR:UIView?
    var tableViewR:UITableView?
    var topView:CourseDetailTopView?
    var tableViewM:UITableView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfiguration()
        setupViews()
        requestData()
        // Do any additional setup after loading the view.
    }
    func baseConfiguration() -> Void {
        self.title = "from top vc"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }
    func setupViews() {
        setupTopView()
        setupScrollView()
    }
    
    // 课程信息
    var modelInfo:ModelCourseDtail = ModelCourseDtail()
    // 课程成果
    var dataArrCourseArchievement:[ModelCourseAchievement] = []
    var dataArrCourseInfomation :[ModelCourseInfomation] = []
    var dataArrMidHeaderHeight:[CGFloat] = []
    //MARK: --------------------requestData-------------------
    func requestDataforTeacherList(cloId:String,success:@escaping (_ arr:[ModelTeacher]) -> ()){
        let param:ParamGetTeacherByClo = ParamGetTeacherByClo()
        param.courseId = self.modelPush?.courseId
        param.cloId = cloId
        CourseTool.requestGetTeacherWithClo(params: param.toJSON()!, success: { (res) in
             if res.success{
                success(res.arr as! [ModelTeacher])
             }else{
                 CommonTool.showFail(view: self.view, text: res.message)
             }
        }, fail: {(err) in
                   CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
               })
    }
    func requestDataCourseInfomation(){
        let param = ParamCourseDetail.init()
        param.userId = CommonTool.getUserId()
        param.courseId = self.modelPush?.courseId
        CourseTool.courseInfomation(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.dataArrCourseInfomation = res.arr as! [ModelCourseInfomation]
                self.tableViewR?.reloadData()
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
    func requestDataCourseAchievement(){
        let param = ParamCourseDetail()
        param.userId = CommonTool.getUserId()
        param.courseId = self.modelPush?.courseId
        CourseTool.courseAchievement(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.dataArrCourseArchievement = res.arr as! [ModelCourseAchievement]
                self.kGetAllHeightForTableViewM_Height()
                self.tableViewM?.reloadData()
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    func requestData(){
        let param:ParamCourseDetail = ParamCourseDetail.init()
        param.courseId = self.modelPush?.courseId
        param.userId  = CommonTool.getUserId()
        CourseTool.courseDetail(params: param.toJSON()!, success: { ( res) in
            if res.success{
                let model:ModelCourseDtail =  res.data as! ModelCourseDtail
                self.modelInfo = model
                self.setupSubViewsLeft()
                self.title = model.courseName;
                // 更新 ui
                // 0 我的成绩
                self.viewMyGrade!.model = model
                // 1 任课教师
                self.viewTeacherList!.dataArr = model.teacherList
                // 2 课程设置
                self.viewCourseStting!.model = model
                // 3 基本信息
                self.viewBaseInfo!.model = model
                // 4 课程教材
                // 5 课程主旨
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    //MARK: --------------------main scrollview-------------------
    // 整体scrollView
    func setupScrollView(){
        let y:CGFloat = (self.topView?.maxY())!
        let h:CGFloat = SCREEN_HEIGHT - y - 10
        let v:UIScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h))
        v.contentSize = CGSize.init(width: SCREEN_WIDTH * 3, height: h)
        self.view.addSubview(v)
        self.scrollView = v
        v.isPagingEnabled = true
        v.delegate = self
        
        // scrollview Left
        let sl:UIScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: h))
        self.viewL = sl
        v.addSubview(sl)
        sl.contentSize = CGSize.init(width: SCREEN_WIDTH, height: h)

        // scrollview Mid
        let sm:UIScrollView = UIScrollView.init(frame: CGRect.init(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: h))
        self.viewM = sm
        v.addSubview(sm)
        sm.contentSize = CGSize.init(width: SCREEN_WIDTH, height: h)
        
        // tableView Right
       
        let vr:UIView = UIView.init(frame: CGRect.init(x: SCREEN_WIDTH * 2, y: 0, width: SCREEN_WIDTH, height: h))
        self.viewR = vr
        v.addSubview(vr)
        
        sl.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        sm.backgroundColor = .orange
        vr.backgroundColor = .purple
        
        setupSubViews()
    }
    func setupSubViews(){
//        setupSubViewsLeft()
        setupSubViewsMid()
        setupViewRightTableView()
    }
    //MARK: --------------------scrollview Mid-------------------
    func setupSubViewsMid(){
        setupMidTopView()
        setupMidTableView()
    }
    func setupMidTopView(){
        let h:CGFloat = 42
        let v = UINib.init(nibName: "CourseDetailMidTopView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailMidTopView
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: h)
        self.viewM?.addSubview(v)
        v.isHidden = true
        
    }
    
    var tableView:UITableView?
    let uniIdMid:String = "CourseDetailMidTableViewCellId"
    func setupMidTableView(){
        let y:CGFloat = 0
        let h:CGFloat = (self.viewM?.frame.height)! - y
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h), style: .grouped)
        self.viewM!.addSubview(tableView)
        self.tableViewM = tableView
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = (self as UITableViewDelegate)
        let nib :UINib = UINib.init(nibName: "CourseDetailMidTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier:uniIdMid)
        tableView.separatorStyle = .none
        
        tableView.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
    }
    
    func setupSubViewsLeft(){

        let v0 = setupLeftViewMyGrade()
        let v1 = comView(title: "任课教师", y: v0.maxY())
        let v2 = setupLeftViewTeachers(y: v1.maxY())
        let v3:CourseDetailSectionView = comView(title: "课程设置", y: v2.maxY(), hiddenBtn: false, h: 50) as! CourseDetailSectionView
        
        v3.blockClick = {
            print("点击 挂科规则")
            
            let str = self.modelInfo.failRule;
            let vc = UIAlertController.init(title: "挂科规则", message: str, preferredStyle: .alert)
            let actionSure = UIAlertAction.init(title: "确定", style: .default, handler: { ( action) in
                
            })
            vc.addAction(actionSure)
            
            self.present(vc, animated: true, completion: {
                
            })
            
        }
        let v4 = setupLeftViewCourseSetting(y: v3.maxY())
        let v5 = comView(title: "基本信息", y: v4.maxY())
        
        let v6 = setupLeftViewBaseInfo(y: v5.maxY())
        let v7 = comView(title: "课程教材", y: v6.maxY())
        let v8 = setupLeftViewBook(y: v7.maxY())
        let v9 = comView(title: "课程主旨（课程总体目标）", y: v8.maxY())
        setupLeftViewPurport(y: v9.maxY())
    
        
        setupLeftViewEvaluateBtn()
    }
    //MARK: --------------------scrollview left-------------------
    var viewMyGrade:CourseDetailLeftMyGradeView?
    var viewTeacherList:CourseDetailLeftTeachersView?
    var viewCourseStting:CourseDetailLeftSettingView?
    var viewBaseInfo:CourseDetailLeftBaseInfo?
    
    
    func setupLeftViewEvaluateBtn(){ 
        let h :CGFloat = 60
        let v:UIView = UIView.init(frame: CGRect.init(x: 0, y: (self.viewL?.contentSize.height)! - h, width: SCREEN_WIDTH, height: h))
        self.viewL?.addSubview(v)
        v.backgroundColor = .white
        
        
        let btn = UIButton.init(frame: CGRect.init(x: 17, y: 5, width: SCREEN_WIDTH - 17 * 2, height: h - 10))
        v.addSubview(btn)
        btn.setTitle("立即评测", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        CommonTool.addGradientColo(btn.layer, btn.frame.size, ["#99CCFC","#5797F7"])
        btn.addTarget(self, action: #selector(btnActionEvaluating), for: .touchUpInside)
        
        btn.layer.cornerRadius = (h - 10) / 2
        btn.layer.masksToBounds = true
    }
    @objc func btnActionEvaluating(){
        let vc = CourseEvaluateViewController()
        self.navigationController?.pushViewController(vc, animated: true) 
    }
    // 课程主旨
    func setupLeftViewPurport(y:CGFloat) {
        var str  = self.modelInfo.courseTarget;// "物流信息技术是港口物流历专业的专业基础课，通过本课程的学习，学生能理解通过对物流信息的有效管理、达到提升物流整体效率的目标。要求学生具体能够：\n 1.用港口物流管理专业领域的相关术语来描述本专业码头运营和国际物流领域的核心理论知识和实践，并且提供至少一个与专业领域相关的案例。"
        if str == nil {
            str = ""
        }
        let difL :CGFloat = 15
        let labDifL:CGFloat = 12
        let labDifT:CGFloat = 7
        let labh :CGFloat = CommonTool.getAttributionHeightWithString(str: str, fontSize: 15, width: SCREEN_WIDTH - difL * 2 - labDifL * 2)
        let h:CGFloat = labh + labDifT * 2
        let v = UIView.init(frame: CGRect.init(x: difL, y: y, width: SCREEN_WIDTH - difL * 2, height: h))
        self.viewL?.addSubview(v)
        v.layer.cornerRadius = 5
        v.backgroundColor  = .white
        
        let lab:UILabel = UILabel.init(frame: CGRect.init(x: labDifL, y: labDifT, width: v.frame.width - labDifL * 2 , height: labh))
        lab.numberOfLines = 0
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.text = str
        v.addSubview(lab)
        
        self.viewL?.contentSize = CGSize.init(width: SCREEN_WIDTH, height: v.maxY() + 70)
        
    }
    // 课程教材
    func setupLeftViewBook(y:CGFloat) -> UIView{
        
        let arr:Array = CommonTool.stringToArray(str: self.modelInfo.textbook) ?? []
        
        let h:CGFloat = CGFloat(67 * (arr.count) + 3)
        let v = UINib.init(nibName: "CourseDetailLeftBookView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailLeftBookView
        v.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h)
        self.viewL?.addSubview(v)
        v.dataArr = arr
        v.callback = { index in
            print(index)
        }
        return v
    }
    // 基本信息
    func setupLeftViewBaseInfo(y:CGFloat) -> UIView{
        let h_dynamic :CGFloat =  15 + (self.kgetHeightForBaseInfo())
        let h:CGFloat = 412 + 13 - 135 + h_dynamic - 39
        let v = UINib.init(nibName: "CourseDetailLeftBaseInfo", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailLeftBaseInfo
        v.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h)
        self.viewL?.addSubview(v)
        self.viewBaseInfo = v
        return v
    }
    func kgetHeightForBaseInfo() -> CGFloat{
        let strBefore:String = self.modelInfo.beforeCourse
        let strTogether:String = self.modelInfo.togetherCourse
        let strAfter:String = self.modelInfo.afterCourse
        
//        let font:UIFont = UIFont.systemFont(ofSize: 12)
        
        
        let typeArr:[String] = ["[","]","\"","\\"];
        var str_A = strBefore// model?.beforeCourse ?? ""
        var str_b = strTogether//model!.togetherCourse
        var str_c = strAfter//model!.afterCourse
        for type in typeArr{
            str_A = str_A.replacingOccurrences(of: type, with: "")
            str_b = str_b.replacingOccurrences(of: type, with: "")
            str_c = str_c.replacingOccurrences(of: type, with: "")
        }
        
        let arrBefore:[String] =  str_A.components(separatedBy: ",")
        let arrTogether:[String] = str_b.components(separatedBy: ",")
        let arrAfter:[String] = str_c.components(separatedBy: ",")
        
        
        
        let h1:CGFloat = kgetHeightForBaseInfoSingle(arr: arrBefore)
        let h2:CGFloat = kgetHeightForBaseInfoSingle(arr: arrTogether)
        let h3:CGFloat = kgetHeightForBaseInfoSingle(arr: arrAfter)
        
        return h1 + h2 + h3
    }
    func kgetHeightForBaseInfoSingle(arr:[String]) -> CGFloat{
        let font:UIFont = UIFont.systemFont(ofSize: 12)
        let difH :CGFloat = 10
        let difW:CGFloat = 10
        let difAddW:CGFloat = 16
        let allW:CGFloat = SCREEN_WIDTH - 132.0
        var x :CGFloat = 0
        var y:CGFloat = 5
        let h:CGFloat = 20
        var number :CGFloat = 1
        for (index,value) in arr.enumerated() {
            let w :CGFloat = CommonTool.getStrWidth(str:value, fontsize: 12, height:h+difH) + difAddW
            
            x += (w + difW)
            if x > allW {
                x = 0
                y += 30
                number += 1
            }
           
            let lab:UILabel = UILabel.init(frame: CGRect.init(x: x, y: y, width: w, height: h))
            lab.font = font
            lab.textAlignment = .center
        }
        return number * CGFloat(30)
    }
    
    // 课程设置
    func setupLeftViewCourseSetting(y:CGFloat) -> UIView{
        let h:CGFloat = 98 + 13
        let v = UINib.init(nibName: "CourseDetailLeftSettingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailLeftSettingView
        v.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h)
        self.viewL?.addSubview(v)
        self.viewCourseStting = v
        return v
    }
    // 任课教师
    func setupLeftViewTeachers(y:CGFloat) -> UIView{
        let h:CGFloat = 91 + 13
        let v = UINib.init(nibName: "CourseDetailLeftTeachersView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailLeftTeachersView
        v.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h)
        self.viewL?.addSubview(v)
        self.viewTeacherList = v
      return v
    }
    func comView(title:String,y:CGFloat, hiddenBtn:Bool = true,h:CGFloat = 50) -> UIView{
        let v:CourseDetailSectionView = UINib.init(nibName: "CourseDetailSectionView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailSectionView
        v.frame = CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h)
        self.viewL?.addSubview(v)
        v.labTitle.text = title
        v.btnFailExamRule.isHidden = hiddenBtn
        return v
    }
    // 我的成绩
    func setupLeftViewMyGrade() -> UIView{ // 我的成绩
        let h : CGFloat = 12 + 145 + 13
        let v = UINib.init(nibName: "CourseDetailLeftMyGradeView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailLeftMyGradeView
        self.viewMyGrade = v
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: h)
        self.viewL?.addSubview(v)
        v.blockClickStruct = {[weak self] in
            
            let vc = CourseDetailStructViewController()
            vc.courseId = self?.modelPush?.courseId
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        return v
    }
    
    
    //MARK: --------------------view right-------------------
    let uniId:String = "HomeResListTableViewCellId"
    func setupViewRightTableView(){
        let rect = self.viewR?.bounds
        var  tableView = UITableView.init(frame: rect!, style: .plain)
        self.viewR!.addSubview(tableView)
        self.tableViewR = tableView
        tableView.dataSource = self as UITableViewDataSource
        tableView.delegate = self as UITableViewDelegate
        let nib :UINib = UINib.init(nibName: "HomeResListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: uniId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
    }
    
    var unionIdHeader: String = "CourseDetailMidHeaderViewId"
    
    func setupTopView(){
        let h :CGFloat = 50
        let v = UINib.init(nibName: "CourseDetailTopView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailTopView
        v.frame = CGRect.init(x: 0, y: STATUS_HEIGHT + NAV_HEIGHT, width: SCREEN_WIDTH, height: h)
        self.topView = v
        self.view.addSubview(v)
        v.blockIndex = { [weak self] index in
            self!.scrollView?.contentOffset = CGPoint.init(x: SCREEN_WIDTH * CGFloat(index), y: 0)
           self?.kDynamicSegment(index: index)
        }
    }
   
    func setupViewMessageView(section:Int,teacherId:Int){
        
        let v = UINib.init(nibName: "CourseDetailMidMessageView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailMidMessageView
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT);
        v.backgroundColor = .clear
       
       let m:ModelCourseAchievement = self.dataArrCourseArchievement[section]
        v.cloId = m.id
        v.teacherId = String(teacherId)
        v.cloTitle = m.code
        
        self.view.addSubview(v);
    }
    func setupViewTeacherView(section:Int){
        let m:ModelCourseAchievement = self.dataArrCourseArchievement[section];
        
        
        self.requestDataforTeacherList(cloId: m.id) { (arr) in
             let v = CourseDetailMidTeacherView.init(frame: self.view.bounds)
             self.view.addSubview(v)
               v.sectionIndex = section

            v.arrModel = arr
               v.delegate = self
        }
        
      
        
    }
    
    //MARK: --------------------other-------------------
    // MARK: 字符串转字典
    
    func kGetAllHeightForTableViewM_Height(){
        self.dataArrMidHeaderHeight = []
        for m in self.dataArrCourseArchievement{
             self.dataArrMidHeaderHeight.append(self.kgetHeightForHeader_M(str: m.info) + 120 - 12)
        }
    }
    
    func kDynamicSegment(index:NSInteger) {
        if index == 1{
            if self.dataArrCourseArchievement.count == 0 {
                self.requestDataCourseAchievement()
            }
        }else if index == 2{
            if self.dataArrCourseInfomation.count == 0 {
                self.requestDataCourseInfomation()
            }
        }
    }
    
    
    func  kgetHeightForHeader_M(str:String) -> CGFloat{
        let h = CommonTool.getAttributionHeightWithString(str: str, width: (SCREEN_WIDTH - CGFloat(64) ))
        return h
    }
}

//MARK: --------------------CourseDetailMidTeacherViewDelegate-------------------
extension CourseDetailViewController:CourseDetailMidTeacherViewDelegate{
    func CourseDetailMidTeacherViewDelegateDidSel(index: Int, m: ModelTeacher, section: Int) {
        self.setupViewMessageView(section: section,teacherId: m.id.toInt())
    }
}
//MARK: --------------------CourseDetailMidHeaderViewDelegate-------------------
extension CourseDetailViewController:CourseDetailMidHeaderViewDelegate{
    func CourseDetailMidHeaderViewDelegateMessage(section: Int) {

        self.setupViewTeacherView(section: section)
    }
}

extension CourseDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableViewR{
            return 95 + 10
        }else
        {
         return 87
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableViewR {
 
        }else if tableView == self.tableViewM{
            
            let modelSec = self.dataArrCourseArchievement[indexPath.section]
            let model:ModelCourseAchievementVloList = modelSec.scoreVoList[indexPath.row]
            
            // 如果已发布 才可以点击 status 已发布
            if model.status == "已发布"{
                let vc = CourseTaskDetailViewController()
                vc.taskDetailId = model.id
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.tableViewR {
            return 0;
        }else if tableView == self.tableViewM{
            return self.dataArrMidHeaderHeight[section]
        }
        return 120
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { 
        if tableView == self.tableViewM {
            let v = UINib.init(nibName: "CourseDetailMidHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CourseDetailMidHeaderView
            v.delegate = self as CourseDetailMidHeaderViewDelegate
            let model :ModelCourseAchievement = self.dataArrCourseArchievement[section]
            v.dy_height = self.dataArrMidHeaderHeight[section];
            v.model = model
            v.section = section
            return v
        }
        return UIView.init()

    }
    
}

extension CourseDetailViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableViewM{
            return self.dataArrCourseArchievement.count
        }else if tableView == self.tableViewR{
            return 1;
        }
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableViewR{
            return self.dataArrCourseInfomation.count
        }else
        {
            if self.dataArrCourseArchievement.count > 0 {
                let model = self.dataArrCourseArchievement[section];
                return model.scoreVoList.count;
            }
           return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableViewR {
            let cell : HomeResListTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniId, for: indexPath) as! HomeResListTableViewCell
            let model = self.dataArrCourseInfomation[indexPath.row]
            cell.indexP = indexPath
            cell.delegate = self
            cell.model = model
            return cell
        }else{
            let cell : CourseDetailMidTableViewCell  = tableView.dequeueReusableCell(withIdentifier: uniIdMid, for: indexPath) as! CourseDetailMidTableViewCell
            let modelSec = self.dataArrCourseArchievement[indexPath.section]
            let count = modelSec.scoreVoList.count
            if indexPath.row == count - 1 {
                cell.isLast = true
            }
            let model:ModelCourseAchievementVloList = modelSec.scoreVoList[indexPath.row]
            cell.model = model
            return cell
        }
        
    }
}



//MARK: --------------------课件资料 点击下载 查看-------------------
extension CourseDetailViewController:HomeResListTableViewCellDelegate{
    func HomeResListTableViewCellDelegateTapDownLoad(m: ModelCourseInfomation, indexP: IndexPath) {
        ZDownLoadTool.downLoadWithUrl_short(url: m.url, progress: { (pro) in
            let cell:HomeResListTableViewCell = self.tableViewR?.cellForRow(at: indexP as IndexPath) as! HomeResListTableViewCell
            print(pro)
            cell.process = pro
            
        }, success: { path in
            let fileName:String = m.url.components(separatedBy: "/").last ?? ""
            var caches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
            caches?.append("/file/")
            caches?.append(fileName)
            m.filePath = caches!
            
        })
    }
    func HomeResListTableViewCellDelegateTapSee(m: ModelCourseInfomation, indexP: IndexPath) {
 
        let path = m.filePath;
        print(path)
        
        let vc = SeeFileViewController()
        vc.filePath = path
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

//MARK: --------------------UIScrollViewDelegate-------------------
extension CourseDetailViewController:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.scrollView == scrollView{ // 当前视图为 主滚动视图时 与 顶部联动
            let index: Int = Int(scrollView.contentOffset.x / SCREEN_WIDTH)
            self.topView?.selIndex = index
            
            self.kDynamicSegment(index: index)
            
        }
    }
    
}
