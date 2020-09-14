//
//  HonorDetailViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/20.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class HonorDetailViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
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
    }
    
    var viewNav: CommonNavView?
    var viewInfo:HonorDetailInfoView?
    func setupViews() {
        setupViewsNav()
        setupViewScrollView()
        setupViewInfo()
        setupCollectionView()
    }
    var scrollView:UIScrollView?
    func setupViewScrollView(){
        let sc:UIScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: self.viewNav!.frame.height, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-self.viewNav!.frame.maxY))
        self.view.addSubview(sc)
        self.scrollView = sc
        sc.isScrollEnabled = false;
        sc.contentSize = CGSize.init(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    }
    
    var collectionView:UICollectionView?
    let CellId:String = "AddHonorCollectionViewCellId"
    func setupCollectionView(){
        let flowlayout = UICollectionViewFlowLayout.init()
        
        let width:CGFloat = SCREEN_WIDTH / 4.0
        let height:CGFloat = width + 20.0
        flowlayout.itemSize = CGSize(width: width, height: height)
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.scrollDirection = .vertical
        flowlayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
//
        let y:CGFloat = (self.viewInfo?.frame.maxY)!
        let h:CGFloat = 200
        let  collectionView :UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h), collectionViewLayout: flowlayout)
        self.scrollView!.addSubview(collectionView)
        self.collectionView = collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        // 注册cell
        collectionView.register(UINib.init(nibName: "AddHonorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:CellId )
    }

    func setupViewInfo(){
        let h:CGFloat = 370
        let v = UINib.init(nibName: "HonorDetailInfoView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! HonorDetailInfoView
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: h)
        self.scrollView!.addSubview(v)
        self.viewInfo = v;
    }
    func setupViewsNav(){
        
        let v = UINib.init(nibName: "CommonNavView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CommonNavView
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 83)
        self.view.addSubview(v)
        self.viewNav = v;
        v.title = "荣誉详情"
        v.isHiddenLine = true;
        v.blockBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    func requestData(){
        
    }
}
extension HonorDetailViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
extension HonorDetailViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:AddHonorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath) as! AddHonorCollectionViewCell
        cell.btnDel.isHidden = true
        return cell
    }
}

