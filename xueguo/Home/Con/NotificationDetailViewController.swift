//
//  NotificationDetailViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/23.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class NotificationDetailViewController: UIViewController {

//    var notificationId:String?
    var model:ModelNotification?
    
    @IBOutlet weak var labDetail: UILabel!
    
    @IBOutlet weak var labTitle: UILabel!
    @IBOutlet weak var imgType: UIImageView!
    
    @IBOutlet weak var viewCon: UIView! //展示动态文字
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        baseConfiguration()
        setupViews()
        requestDataNotificationRead()
    }
    func setupViews(){
        let width  :CGFloat = SCREEN_WIDTH - 84 - 23
        
        let height :CGFloat = SCREEN_HEIGHT - viewCon.mj_origin.x - TABBAR_HEIGHT
        let rect =  CGRect.init(x: 0, y: 0, width: width, height: height)
        let scrollView = UIScrollView.init(frame:rect)
        self.viewCon.addSubview(scrollView)
        
        
        var str = "本校将于2019年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校将于2019年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校将于2019年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校将于2019年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校将于2019年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校将于2019年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校将于2019年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校将于2019年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校将于2019年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校将于2019年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。00987654319年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校将于2019年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校2fghj19年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校将于2019年4月22日在校阶梯教室举行社会普法专项活动，届时请已报名的同学提前到达。本校end"
        
        str = self.model!.noticeContent
        let trueHeight = CommonTool.getAttributionHeightWithString(str: str, lineSpace: 5, fontSize: 15, width: width)
        scrollView.contentSize = CGSize.init(width: width, height: trueHeight + 50)
        
        var labRect = rect
        labRect.size.height = trueHeight
        let lab = UILabel.init(frame: labRect)
        scrollView.addSubview(lab)
        lab.attributedText = CommonTool.getAttributedWithString(str: str, linespace: 5, fontSize:  15, foreColor: UIColor.colorWithHex(hexStr: "242D39"))
        lab.numberOfLines = 0
    }
    
    func baseConfiguration() -> Void {
        self.title = model?.noticeTitle
        self.labTitle.text = model?.noticeTitle
        self.labDetail.text = model?.readTime
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))

    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }
    
    
    //MARK: --------------------requestData-------------------
    func requestDataNotificationRead(){
        let param:ParamNotificationList = ParamNotificationList.init()
        param.noticeId = model?.noticeId
        HomeTool.notificationRead(params: param.toJSON()!, success: { ( res) in
            if res.success{
                CommonTool.showSuccess(view: self.view, text: res.message)
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
// 更新已读标识
    func requestDataUpdateNotification(){
        let param:ParamNotificationList = ParamNotificationList.init()
        param.receiverId = model?.receiverId
        param.noticeId = model?.noticeId
        HomeTool.updateNotification(params: param.toJSON()!, success: { ( res) in
            if res.success{
                
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
}
