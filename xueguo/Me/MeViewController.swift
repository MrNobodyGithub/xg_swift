//
//  MeViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/4/23.
//  Copyright © 2019年 free. All rights reserved.
//

import UIKit
import ObjectMapper



class MeViewController: UIViewController {
    
    var scrollView:UIScrollView?
    var topView:MeTopView?
    var viewA : MeView_a?
    var viewB : MeView_b?
    var viewC : MeView_c?
    var scoreLevelView: HomeScoreLevelView?
    var scoreStatisticsView: HomeScoreStatisticsView?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        self.topView?.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        baseConfiguration()
        setupViews()
    }
    func setupViews(){
        setupScrollView()
        setupTopView()
        setupView_a()
        setupView_b()
        setupView_c()
        
        
        let scoreH :CGFloat = 280;
        let distributeH :CGFloat = 280;
        let levelH : CGFloat = 280;
        
        //         2 HomeScoreStatisticsView 学分统计
        let scoreStatisticsView :HomeScoreStatisticsView = UINib.init(nibName: "HomeScoreStatisticsView", bundle: nil).instantiate(withOwner: self, options: nil).last as! HomeScoreStatisticsView
        self.scrollView!.addSubview(scoreStatisticsView)
        
        scoreStatisticsView.frame = CGRect.init(x: 0, y: self.viewC!.frame.maxY + 20, width: SCREEN_WIDTH, height: scoreH)
        
        //         3 HomeScoreDistributeView 学分分布
        let distributeView :HomeScoreDistributeView = UINib.init(nibName: "HomeScoreDistributeView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! HomeScoreDistributeView
        self.scrollView!.addSubview(distributeView)
//        scoreDistributeView = distributeView
        distributeView.frame = CGRect.init(x: 0, y: scoreStatisticsView.frame.maxY, width: SCREEN_WIDTH, height: distributeH)
        //        4  HomeScoreLevelView 课程成绩档次统计
        let levelView :HomeScoreLevelView = UINib.init(nibName: "HomeScoreLevelView", bundle: nil).instantiate(withOwner: nil, options: nil).last as! HomeScoreLevelView
        scoreLevelView = levelView
        self.scrollView!.addSubview(levelView)
        levelView.frame = CGRect.init(x: 0, y: distributeView.frame.maxY, width: SCREEN_WIDTH, height: levelH)
        
//
//        setupView_b()
//        setupView_c()
        setupDownBgView()
    }
    func setupScrollView(){
        
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: -STATUS_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT+STATUS_HEIGHT))
        self.view.addSubview(scrollView!)
        scrollView?.contentSize = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    }
    func setupView_a(){
        let height:CGFloat = 77
        
        let v = UINib.init(nibName: "MeView_a", bundle: nil).instantiate(withOwner: nil, options: nil).first as! MeView_a
        v.frame = CGRect.init(x: 0, y: self.topView!.maxY() - 20, width: SCREEN_WIDTH, height: height)
        scrollView!.addSubview(v)
        self.viewA = v
        v.backgroundColor = .clear
        
        v.delegate = self
        
    }
    func setupView_b(){
        let height:CGFloat = 106
        
        let v = UINib.init(nibName: "MeView_b", bundle: nil).instantiate(withOwner: nil, options: nil).first as! MeView_b
        v.frame = CGRect.init(x: 0, y: self.viewA!.maxY() + 10, width: SCREEN_WIDTH, height: height)
//        v.frame = CGRect.init(x: 0, y: self.scoreLevelView!.maxY() + 10, width: SCREEN_WIDTH, height: height)
        scrollView!.addSubview(v)
        self.viewB = v
        v.progress = 0.5
         
    }
    func setupView_c(){
        
        let height:CGFloat = 261
        
        let v = UINib.init(nibName: "MeView_c", bundle: nil).instantiate(withOwner: nil, options: nil).first as! MeView_c
        v.frame = CGRect.init(x: 0, y: self.viewB!.maxY(), width: SCREEN_WIDTH, height: height)
        scrollView!.addSubview(v)
        self.viewC = v
        
    }
    func setupTopView(){
        let height:CGFloat  = 165
        let v = UINib.init(nibName: "MeTopView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! MeTopView
        self.topView = v
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: height)
//        self.view.addSubview(v)
        scrollView!.addSubview(v)
        v.delegate = self
    }
    func setupDownBgView(){
        let height :CGFloat = 60
        let v = UIView.init(frame: CGRect.init(x: 0, y: (self.scoreLevelView?.maxY())!+10, width: SCREEN_WIDTH, height: height))
        scrollView!.addSubview(v)
        
        let imgv = UIImageView.init(frame: v.bounds)
        v.addSubview(imgv)
        imgv.image = UIImage.init(named: "logo_gray")
        imgv.contentMode = .scaleAspectFit
        
        scrollView?.contentSize = CGSize.init(width: SCREEN_WIDTH, height: v.maxY() + 20)
        
    }
    
    func baseConfiguration() -> Void {
        self.view.backgroundColor = UIColor.colorWithHex(hexStr: "F8F9FA")
        
        
        
    }
 
}
extension MeViewController: MeView_aDelegate{
    func MeView_aDelegateHononer() {
        let vc = MyHonorViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func MeView_aDelegateSetting() {
        let vc = MeSettingViewController() 
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func MeView_aDelegateColl() {
        let vc = MyCollViewController() 
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func MeView_aDelegateRegister() {
//      let vc = UIViewController.init(nibName: "MyRegisterViewController", bundle: nil)
        let vc = MyRegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension MeViewController: MeTopViewDelegate{
    func MeTopViewDelegateShare() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func MeTopViewDelegatePhoto() {
        
        let vc = UIAlertController.init(title: "请选择", message: nil, preferredStyle: .actionSheet)
 
        let actionCam = UIAlertAction.init(title: "camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let ipc = UIImagePickerController.init()
                ipc.sourceType = .camera
                ipc.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
                self.present(ipc, animated: true, completion: {})
            }
        }
        vc.addAction(actionCam)
        let actionPhoto = UIAlertAction.init(title: "photo", style: .default) { (action) in
            //选择图片
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let ipc = UIImagePickerController.init()
                ipc.sourceType = .photoLibrary
                ipc.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
                self.present(ipc, animated: true, completion: {
                    
                })
            }
           
        }
        vc.addAction(actionPhoto)
        
        let actionAlbum = UIAlertAction.init(title: "album", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                let ipc = UIImagePickerController.init()
                ipc.sourceType = .savedPhotosAlbum
                ipc.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
                self.present(ipc, animated: true, completion: {})
            }
        }
        vc.addAction(actionAlbum)
        let quit = UIAlertAction.init(title: "quit", style: .cancel) { (action) in
            
        }
        vc.addAction(quit)
        self.present(vc, animated: true) {
            
        }
        
    }
}

extension MeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) {
        }
        
        let image = info[.originalImage]
        self.topView?.imgUser.image = (image as! UIImage)
//        UIImage *pickerImage = info[UIImagePickerControllerOriginalImage];
//        //    self.topView.imgIcon.image = pickerImage;
//
//        [picker dismissViewControllerAnimated:YES completion:^{
//
//            }];
        
        
        
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            
        }
    }
}
