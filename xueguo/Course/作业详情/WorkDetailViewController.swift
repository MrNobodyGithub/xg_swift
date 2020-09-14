//
//  WorkDetailViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/13.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import MobileCoreServices
class WorkDetailViewController: UIViewController {
    
    var workId:String?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        baseConfiguration()
//        setupViews()
        requestData()
        // Do any additional setup after loading the view.
    }
  
    func setupViews() {
        setupScrollView()
        setupTopView()
        setupGroupView()
        setupMyWorksView()
        setupDownView()
    }
    
    var scrollView:UIScrollView = UIScrollView.init()
  
    var topView:WorkDetailTopView?
    var groupView:WorkDetailGroupView?
    var myWorksView: WorkDetailMyWorksView?
    
    func setupDownView(){
        let h:CGFloat = 60;
        let v:UIView = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - h, width: SCREEN_WIDTH, height: h))
        self.view.addSubview(v)
        let difL:CGFloat = 17
        let difT:CGFloat = 5
        let btn:UIButton = UIButton.init(frame: CGRect.init(x: difL, y: difT, width: SCREEN_WIDTH - 2 * difL, height: h - 2 * difT))
        v.addSubview(btn)
        btn.layer.cornerRadius = h / 2 - difT
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(btnActionSubmit), for: .touchUpInside)
        
        let a = arc4random() % 2
        if a == 0 {
            CommonTool.addGradientColo(btn.layer, CGSize.init(width: (SCREEN_WIDTH - 2 * difL), height: ( h - 2 * difT)), ["#99CCFC","#99CCFC"])
            btn.setTitle("提交作业", for: .normal)
        }else{
            CommonTool.addGradientColo(btn.layer, CGSize.init(width: (SCREEN_WIDTH - 2 * difL), height: ( h - 2 * difT)), ["##EE8C37","##EB692E"])
            btn.setTitle("重新提交作业", for: .normal)
        }
   
        
        
        
    }
    func setupMyWorksView(){
        
        let arr:Array = Array.init(repeating: "1", count: 0)
        
        let v:WorkDetailMyWorksView = UINib.init(nibName: "WorkDetailMyWorksView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! WorkDetailMyWorksView
        let h :CGFloat = 80 + 91 + 30 + CGFloat(arr.count) * 91
        v.frame = CGRect.init(x: 0, y: groupView?.frame.maxY ?? 0, width: SCREEN_WIDTH, height: h)
        
        self.scrollView.addSubview(v)
        self.myWorksView = v
        v.delegate = self
         
        v.array = arr;
        
        self.scrollView.contentSize = CGSize.init(width: SCREEN_WIDTH, height: v.frame.maxY + 100)
        
    }
    
    func setupGroupView(){
        let v = UINib.init(nibName: "WorkDetailGroupView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! WorkDetailGroupView
        v.frame = CGRect.init(x: 0, y: (topView?.frame.maxY)!, width: SCREEN_WIDTH, height: 181)
        self.scrollView.addSubview(v)
        self.groupView = v
        v.blockEvaluate = {
            let vc = StudentEvaluateViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        v.blockOtherGroup = {
            let vc = OtherGroupViewController() 
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    func setupTopView(){
        let v = UINib.init(nibName: "WorkDetailTopView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! WorkDetailTopView
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 255)
        self.scrollView.addSubview(v)
        self.topView = v
    }
    func setupScrollView(){
        let s = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        self.view.addSubview(s)
        s.contentSize = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 2)
        self.scrollView = s
    }
    
    var model: ModelWorkDetail?
    //MARK: --------------------request-------------------
    func requestData(){
//        evaluateItemId  267 userid  212
        
        let param:ParamWorkDetail = ParamWorkDetail.init()
        param.userId = CommonTool.getUserId()
        param.evaluateItemId = self.workId//"267"
        CourseTool.workDetail(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.model = res.data as! ModelWorkDetail
                self.setupViews()
                
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
        
    }
    
    
    func baseConfiguration() -> Void {
        self.title = "子任务"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
    
    
    func kToImage(){
        let vc = UIImagePickerController.init()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        self.present(vc, animated: true) {
        }
    }
    func kToVideo(){
        let vc = UIImagePickerController.init()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.mediaTypes = [kUTTypeMovie as String]
        self.present(vc, animated: true) {
        }
    }
    
    var documentPicker :UIDocumentPickerViewController?
    func ktoFile(){
        let documentTypes:[String] = ["public.content", "public.text", "public.source-code ",  "public.image",  "public.audiovisual-content",  "com.adobe.pdf",  "com.apple.keynote.key",  "com.microsoft.word.doc",  "com.microsoft.excel.xls",  "com.microsoft.powerpoint.ppt"];
        let vc = UIDocumentPickerViewController.init(documentTypes: documentTypes, in: .open)
        self.documentPicker = vc
        self.present(vc, animated: true, completion: nil)
        vc.delegate = self

        
    }
    
    func kSheetChooseFile(){
        // 文件 图片 视频
        let arr :[String] = ["文件","图片","视频"];
        let vc = UIAlertController.init()
        let actionFile = UIAlertAction.init(title: arr[0], style: .default) { ( action) in
            self.ktoFile()
        }
        vc.addAction(actionFile)
        let actionPic = UIAlertAction.init(title: arr[1], style: .default) { (action) in
            self.kToImage()
        }
        vc.addAction(actionPic)
        let actionVideo = UIAlertAction.init(title: arr[2], style: .default) { (action) in
            self.kToVideo()
        }
        vc.addAction(actionVideo)
        
        let actionQuit = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            
        }
        vc.addAction(actionQuit)
        self.present(vc, animated: true) {
        }
        
    }
    //MARK: --------------------action-------------------
    @objc func btnActionSubmit(){
        
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }

}
extension WorkDetailViewController:WorkDetailMyWorksViewDelegate{
    func WorkDetailMyWorksViewDelegateAdd() {
        
        
        self.kSheetChooseFile()
        
        
        
        return;
        
        // ui
        var rect = self.myWorksView?.frame
        rect?.size.height += 91
        self.myWorksView?.frame = rect!
        
        self.scrollView.contentSize = CGSize.init(width: SCREEN_WIDTH, height: self.myWorksView!.frame.maxY + 100)
         
        //data
         self.myWorksView?.addOne()
    }
    func WorkDetailMyWorksViewDelegateDelete(m: NSObject) {
        // ui
        
        
        var rect = self.myWorksView?.frame
        rect?.size.height -= 91
        self.myWorksView?.frame = rect!
        self.scrollView.contentSize = CGSize.init(width: SCREEN_WIDTH, height: self.myWorksView!.frame.maxY + 100)
        

        //data
        self.myWorksView?.deleteOne(m: m)
    }
}
extension WorkDetailViewController:UIImagePickerControllerDelegate{
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let type:String = info[.mediaType] as! String
        if type == (kUTTypeImage as String) {// 选择图片
            let img = info[.originalImage]
            
            
        }else if type == (kUTTypeVideo as String){// 选择视频
            let path = info[.mediaURL]
        }
        
    }
    
}
extension WorkDetailViewController:UINavigationControllerDelegate{
    
}
extension WorkDetailViewController:UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
         
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
    }
}
