//
//  AddHonorViewController.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/15.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class AddHonorViewController: UIViewController {

    //views
    var scrollView:UIScrollView?
    var btnDown:UIButton?
    var viewNav:CommonNavView?
    var viewTop:AddHonorTopView?
    var collectionView:UICollectionView?
    let CellId:String = "AddHonorCollectionViewCellId"
    
    //data
    
    var dataArr:Array = Array.init(repeating: 2, count: 4)
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
    func setupViews() {
        setupViewNav()
        setupDownView()
        setupScrollView()
        setupViewTop()
        setupCollectionView()
    }
    func setupDownView(){
        let h:CGFloat = 50;
        let btn:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT - h, width: SCREEN_WIDTH, height: h))
        self.view.addSubview(btn)
        CommonTool.addGradientColo(btn.layer, btn.frame.size, ["#99CCFC","#5797F7"])
        self.btnDown = btn
        btn.setTitle("提交审核", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(btnActionUpload), for: .touchUpInside)
    }
    func setupScrollView(){
        let sc:UIScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: (self.viewNav?.frame.maxY)!, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - (self.viewNav?.frame.maxY)! - self.btnDown!.frame.height) )
        self.view.addSubview(sc)
        self.scrollView = sc
        sc.contentSize = CGSize.init(width: SCREEN_WIDTH, height: sc.frame.height);
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
        
        let y:CGFloat = (self.viewTop?.frame.maxY)!
        let h:CGFloat = self.scrollView!.frame.height - y
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
    
    func setupViewTop(){
        let v = UINib.init(nibName: "AddHonorTopView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! AddHonorTopView
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 305+40)
        self.viewTop = v
        self.scrollView!.addSubview(v)
    }
    func setupViewNav(){
        let v = UINib.init(nibName: "CommonNavView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! CommonNavView
        v.frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 81);
        self.viewNav = v
        v.title = "添加新荣誉"
        v.blockBack = {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        self.view.addSubview(v)
    }
    
    func requestData(){
        
    }
    
    
    //MARK: --------------------other-------------------
    @objc func btnActionUpload(){
        let vc = HonorUploadSucViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateUI(){
        let width:CGFloat = SCREEN_WIDTH / 4.0
        let height:CGFloat = width + 20.0
        
        let  lines = self.dataArr.count / 4
        let dif:CGFloat = CGFloat(lines) * height
        self.scrollView?.contentSize = CGSize.init(width: SCREEN_WIDTH, height: (SCREEN_HEIGHT-self.viewNav!.frame.maxY) + dif)
        self.scrollView?.setContentOffset(CGPoint.init(x: 0, y: dif), animated: true)
        
        self.collectionView?.frame = CGRect.init(x: 0, y: self.viewTop!.frame.maxY, width: SCREEN_WIDTH, height: self.scrollView!.frame.height - self.viewTop!.frame.height + dif)
        
    }
 
}
extension AddHonorViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == dataArr.count {
//            self.dataArr?.append(ModelHonor.init())
            self.dataArr.append(2);
            self.collectionView?.reloadData()
            
            // update ui
            updateUI()
      
            
        }else{
            
        }
    }
}
extension AddHonorViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AddHonorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath) as! AddHonorCollectionViewCell
        cell.delegate = self
        cell.isLast = indexPath.row == dataArr.count ? true : false
        cell.indexP = indexPath ;
        return cell
    }
}
extension AddHonorViewController:AddHonorCollectionViewCellDelegate{
    func AddHonorCollectionViewCellDelegateDel(indexP: IndexPath) {
        self.dataArr.removeFirst()
        self.collectionView?.reloadData()
        updateUI()
    }
}
