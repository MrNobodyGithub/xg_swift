//
//  HomeCoursewareViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class HomeCoursewareViewController: UIViewController {

    
    var collectionView : UICollectionView?
    
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
    }
    
    
    
    var dataArr:[ModelLearnRes] = []
    //MARK: --------------------requestData-------------------
    func requestData(){
        let param:BaseParam = BaseParam.init()
        HomeTool.learnRes(params: param.toJSON()!, success: { ( res) in
            if res.success{
                self.dataArr = res.arr as! [ModelLearnRes]
                self.collectionView?.reloadData()
            }else{
                CommonTool.showFail(view: self.view, text: res.message)
            }
        }, fail: {(err) in
            CommonTool.showFail(view: self.view, text: MESSAGE_NETWORK_FAIL)
        })
    }
    
    func setupViews(){
        let flowlayout = UICollectionViewFlowLayout.init()

        flowlayout.itemSize = CGSize(width: (SCREEN_WIDTH - 43)/2, height: 88)
        flowlayout.minimumLineSpacing = 25
        flowlayout.minimumInteritemSpacing = 11
        flowlayout.scrollDirection = .vertical
        flowlayout.sectionInset = UIEdgeInsets.init(top: 17, left: 16, bottom: 0, right: 16)
        
        collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: flowlayout)
        view.addSubview(collectionView!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        // 注册cell
        collectionView?.register(UINib.init(nibName: "HomeCoursewareCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCoursewareCollectionViewCellId")
     
    }
    
    func baseConfiguration() -> Void {
        self.title  = "学习资源"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "arrow_left_black")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
        self.view.backgroundColor = .white
    }

    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }

 
}
extension HomeCoursewareViewController: UICollectionViewDelegate{
    
}
extension HomeCoursewareViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeCoursewareCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCoursewareCollectionViewCellId", for: indexPath) as!  HomeCoursewareCollectionViewCell
        cell.backgroundColor = .white
        cell.model = self.dataArr[indexPath.row]
        cell.indexP = indexPath
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeResListViewController()
        
        let model :ModelLearnRes = self.dataArr[indexPath.row]
        vc.courseId = model.courseId
        vc.courseTitle = model.courseName;
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
