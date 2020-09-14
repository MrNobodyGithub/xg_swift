//
//  SeeFileViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/8/12.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import WebKit
import AVKit

enum z_fileType{
    case video,img,other
}


class SeeFileViewController: UIViewController {
    //--------------------- in -------------------------------
    var filePath:String?
    
    //----------------------------------------------------
    var fileType:z_fileType?
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
        self.view.backgroundColor = .white
        if self.filePath?.count == 0 {
            return;
        }
        
        self.title = "文件查看"
        
        let fileType = filePath?.components(separatedBy: ".").last ?? ""
        let videoArr: [String] = ["mp4"] // .avi 无法播放 分享三方平台吧
        let imgArr : [String] = ["png","jpeg"]
        if  videoArr.contains(fileType){
            self.setupViewVideo()
            self.fileType = .video
        }else if imgArr.contains(fileType){
            self.setupViewImg()
            self.fileType = .img
        }else
        {
            self.setupViewOther()
            self.fileType = .other
        }
    
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
    @objc  func back(){
        self.navigationController?.popViewController(animated:true)
    }
    
    var viewTop:UIView?
    
    func setupViews() {
        
    }
    var playerVc:AVPlayerViewController?
    var playerItem:AVPlayerItem?
    
    func setupViewVideo(){
        let v = UIView.init(frame: CGRect.init(x: 31, y: 14 + NAV_HEIGHT_FUll, width: SCREEN_WIDTH - CGFloat(62), height: 151))
        self.view.addSubview(v)
        self.viewTop = v
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        
        let vcPlayer = AVPlayerViewController.init()
        self.playerVc = vcPlayer
        let url = URL.init(fileURLWithPath: self.filePath ?? "")
        let item = AVPlayerItem.init(url: url)
        self.playerItem = item
        vcPlayer.player = AVPlayer.init(playerItem: item)
        
        vcPlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        vcPlayer.view.frame = v.bounds
        v.addSubview(vcPlayer.view)
        
        
        addObserver()
    }
    func setupViewImg(){
        let v = UIView.init(frame: CGRect.init(x: 31, y: 14 + NAV_HEIGHT_FUll, width: SCREEN_WIDTH - CGFloat(62), height: 151))
        self.view.addSubview(v)
        self.viewTop = v
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        
        let img = UIImageView.init(frame: v.bounds)
        v.addSubview(img)
        img.image = UIImage.init(contentsOfFile: self.filePath ?? "")
        img.contentMode = .scaleAspectFit
        
    }
    func setupViewOther(){
        let v = UIView.init(frame: CGRect.init(x: 31, y: 14 + NAV_HEIGHT_FUll, width: SCREEN_WIDTH - CGFloat(62), height: 151))
        self.view.addSubview(v)
        self.viewTop = v
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(actionTap))
        v.addGestureRecognizer(tap)

        let lab = UILabel.init(frame: v.bounds)
        v.addSubview(lab)
        lab.text = "点击查看详情"
        lab.textAlignment = .center
        lab.textColor = .black
        lab.font = UIFont.systemFont(ofSize: 26)
    }
     
    func requestData(){
    }
    
    //MARK: --------------------action-------------------
    var document_a:UIDocumentInteractionController?
    @objc func actionTap(){
        let url = URL.init(fileURLWithPath: self.filePath ?? "")
        let document = UIDocumentInteractionController.init(url: url)
        self.document_a = document // 必须强引用
        document.url = url
        document.delegate = self;
        document.presentPreview(animated: true)
//        document.presentOpenInMenu(from: self.view.bounds, in: self.view, animated: true)
    }
    
    //MARK: --------------------other-------------------
    // add observer
    func addObserver() {
        // 监听loadedTimeRanges属性来监听缓冲进度更新
        self.playerItem!.addObserver(self,
                                forKeyPath: "loadedTimeRanges",
                                options: .new,
                                context: nil)
        // 监听status属性进行播放
        self.playerItem!.addObserver(self,
                                forKeyPath: "status",
                                options: .new,
                                context: nil)
    }
    
    func removeObserver() {
        self.playerItem?.removeObserver(self, forKeyPath: "status")
        self.playerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
    }
    
    deinit {
        removeObserver()
    }
     
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        guard let object = object as? AVPlayerItem  else { return }
        guard let keyPath = keyPath else { return }
        if keyPath == "status" {
            if object.status == .readyToPlay { //当资源准备好播放，那么开始播放视频
                self.playerVc?.player?.play()
                print("正在播放...，视频总长度:\(formatPlayTime(seconds: CMTimeGetSeconds(object.duration)))")
            } else if object.status == .failed || object.status == .unknown {
                print("播放出错")
            }
        } else if keyPath == "loadedTimeRanges" {
            let loadedTime = availableDurationWithplayerItem()
            print("当前加载进度\(loadedTime)")
        }
    }
    // 将秒转成时间字符串的方法，因为我们将得到秒。
    func formatPlayTime(seconds: Float64) -> String {
        let min = Int(seconds / 60)
        let sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", min, sec)
    }
    
    // 计算当前的缓冲进度
    func availableDurationWithplayerItem() -> TimeInterval {
        
        guard let loadedTimeRanges = self.playerVc?.player?.currentItem?.loadedTimeRanges,
            let first = loadedTimeRanges.first else {
                fatalError()
        }
        let timeRange = first.timeRangeValue
        let startSeconds = CMTimeGetSeconds(timeRange.start) // 本次缓冲起始时间
        let durationSecound = CMTimeGetSeconds(timeRange.duration)// 缓冲时间
        let result = startSeconds + durationSecound// 缓冲总长度
        return result
    }
    
}
extension SeeFileViewController:UIDocumentInteractionControllerDelegate{
    func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return self.view.bounds
    }
    func documentInteractionControllerViewForPreview(_ controller: UIDocumentInteractionController) -> UIView? {
        return self.view
    }
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}


