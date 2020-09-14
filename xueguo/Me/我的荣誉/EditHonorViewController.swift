//
//  EditHonorViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/23.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class EditHonorViewController: UIViewController {
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
    var viewNav: CommonNavView = CommonNavView.init()
    var viewTop:UIView = UIView.init()
    var viewInfo:AddHonorTopView = AddHonorTopView()
    var collectionView:UICollectionView?
    
    let CellId:String = "AddHonorCollectionViewCellId"
    func setupViews() {
        setupViewNav()
        setupViewTop()
        setupViewInfo()
        setupCollectionView()
        setupViewDown()
    }
    func setupViewDown(){
        let h:CGFloat = 50.0
        let btn:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - h, width: SCREEN_WIDTH, height: h))
        self.view.addSubview(btn)
    
        btn.setTitle("撤销", for: .normal)
        
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        CommonTool.addGradientColo(btn.layer, btn.frame.size, ["#99CCFC","#5797F7"])
        
        btn.addTarget(self, action: #selector(btnActionBackOut), for: .touchUpInside)
        
    }
    
    func setupCollectionView(){
        let flowlayout = UICollectionViewFlowLayout.init()
        
        let width:CGFloat = SCREEN_WIDTH / 4.0
        let height:CGFloat = width + 20.0
        flowlayout.itemSize = CGSize(width: width, height: height)
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.scrollDirection = .vertical
        flowlayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        let y:CGFloat = self.viewInfo.frame.maxY
        let h:CGFloat = 200
        let  collectionView :UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h), collectionViewLayout: flowlayout)
        self.view.addSubview(collectionView)
        self.collectionView = collectionView
        collectionView.delegate = self 
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        // 注册cell
        collectionView.register(UINib.init(nibName: "AddHonorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:CellId )
    }
    
    func setupViewInfo(){
        let v = UINib.init(nibName: "AddHonorTopView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! AddHonorTopView
        v.frame = CGRect.init(x: 0, y: self.viewTop.frame.maxY, width: SCREEN_WIDTH, height: 305+40)
        self.viewInfo = v
        self.view.addSubview(v)
    }
    
    func setupViewTop(){
        let h:CGFloat = 40.0
        let v: UIView = UIView.init(frame: CGRect.init(x: 0, y: self.viewNav.frame.maxY, width: SCREEN_WIDTH, height: h))
        self.view.addSubview(v)
        self.viewTop = v
        
        let downView:UIView = UIView.init(frame: CGRect.init(x: 0, y: 35, width: SCREEN_WIDTH, height: 5))
        v.addSubview(downView)
        downView.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        
        let font:UIFont = UIFont.systemFont(ofSize: 15)
        let color:UIColor = UIColor.colorWithHex(hexStr: "#909091")
        
        let labTitle:UILabel = UILabel.init(frame: CGRect.init(x: 16, y: 0, width: 100, height: 35))
        v.addSubview(labTitle)
        labTitle.font = font
        labTitle.textColor = color
        labTitle.text = "状态：审核中"
        
        let labTime:UILabel = UILabel.init(frame: CGRect.init(x: labTitle.frame.maxX, y: 0, width: SCREEN_WIDTH - labTitle.frame.maxX - 16.0, height: 35))
        v.addSubview(labTime)
        labTime.textAlignment = NSTextAlignment.right
        labTime.font = font
        labTime.textColor = color
        let strTime:String = "2019-06-27 12:30"
        labTime.text = "提交时间:" + strTime
    }
    func setupViewNav(){
        let v = UINib.init(nibName: "CommonNavView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CommonNavView
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 83)
        self.viewNav = v
        self.view.addSubview(v)
        v.title = "编辑荣誉"
        v.blockBack = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    func requestData(){
        
    }
    
    //MARK: --------------------action-------------------
    @objc func btnActionBackOut(){
        
    }

}

extension EditHonorViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
extension EditHonorViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:AddHonorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath) as! AddHonorCollectionViewCell
        cell.isLast = indexPath.row == 2 ? true : false ;
        return cell
    }
}




