//
//  CourseDetailMidTeacherView.swift
//  xueguo
//
//  Created by CityMedia on 2019/9/22.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
protocol CourseDetailMidTeacherViewDelegate:NSObjectProtocol {
    func CourseDetailMidTeacherViewDelegateDidSel(index:Int ,m:ModelTeacher,section:Int)
}

class CourseDetailMidTeacherView: UIView {

     
    var arrModel:[ModelTeacher]?{
        didSet{
            self.dataArr = arrModel!
            self.collectionView!.reloadData()
        }
    }
    var sectionIndex:Int!
    //MARK: --------------------pro-------------------
    var delegate:CourseDetailMidTeacherViewDelegate?
    var dataArr:[ModelTeacher] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseConfiguration()
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
     
    
    
    var viewTeacher:UIView = UIView.init()
    var collectionView:UICollectionView?
    //MARK: --------------------views-------------------
    func setupViews(){
        setupViewShadow()
        setupViewTeacher()
    }
    var UnidId :String = "CourseDetailMidTeacherViewCollectionViewCellId"
    func setupViewTeacher(){
        // 45 209
        let h1:CGFloat = 45
        let h2:CGFloat = 209
        let h:CGFloat = h1 + h2
        
        let v = UIView.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: h))
        v.backgroundColor = .red
        self.addSubview(v)
        self.viewTeacher = v
        
        UIView.animate(withDuration: 0.5, animations: {
            v.frame  = CGRect.init(x: 0, y: self.frame.height - h, width: SCREEN_WIDTH, height: h)
        }) { (a) in
        }
        
        // topview
        let v1 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: h1))
        v.addSubview(v1)
        v1.backgroundColor = .white
        CommonTool.addCornerRadius(size: v1.frame.size, layer: v1.layer, cornerSize: CGSize.init(width: 10, height: 10), arr: [UIRectCorner.topLeft,UIRectCorner.topRight])
        let lab1 = UILabel.init(frame: CGRect.init(x: 25, y: 0, width: 80, height: h1))
        v1.addSubview(lab1)
        lab1.text = "选择教师"
        lab1.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.medium)
        lab1.textColor = UIColor.colorWithHex(hexStr: "#454545")
        //arrow_down_b
        let btn1 = UIButton.init(frame: CGRect.init(x: SCREEN_WIDTH - 40, y: 0, width: 40, height: h1))
        v1.addSubview(btn1)
        btn1.imageView?.image = UIImage.init(named: "arrow_down_b")
        btn1.addTarget(self, action: #selector(btnActionDownArrow), for: .touchUpInside)
        
        //v2 collectionview
        
        let flowLayout = UICollectionViewFlowLayout.init()
        let itemW :CGFloat = CGFloat(ceilf(Float(SCREEN_WIDTH / 4)) - 3)
        flowLayout.itemSize = CGSize.init(width: itemW, height: itemW + 30)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let v2 = UICollectionView.init(frame: CGRect.init(x: 0, y: h1, width: SCREEN_WIDTH, height: h2), collectionViewLayout: flowLayout)
        v.addSubview(v2)
        self.collectionView = v2
        v2.backgroundColor = UIColor.colorWithHex(hexStr: "F8F9FA")
        
        v2.delegate = self as UICollectionViewDelegate
        v2.dataSource = self as UICollectionViewDataSource
        
        v2.register(UINib.init(nibName: "CourseDetailMidTeacherViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: UnidId)
        
        
        
        
        
    }
    func setupViewShadow(){
        let v:UIView = UIView.init(frame: self.bounds)
        self.addSubview(v)
        v.backgroundColor = UIColor.RGBAColor(r: 0, g: 0, b: 0, a: 0.3)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(btnActionDownArrow))
        v.addGestureRecognizer(tap)
    }
    
    
    //MARK: --------------------action-------------------
    @objc func btnActionDownArrow(){
        UIView.animate(withDuration: 0.3, animations: {
            self.viewTeacher.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: self.viewTeacher.frame.height)
        }) { (a) in
            self.removeFromSuperview()
        }
    }
}

extension CourseDetailMidTeacherView:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.btnActionDownArrow()
        if (delegate != nil) && delegate?.responds(to: Selector(("CourseDetailMidTeacherViewDelegateDidSel:"))) != nil {
            let m:ModelTeacher =  self.dataArr[indexPath.row]
            delegate?.CourseDetailMidTeacherViewDelegateDidSel(index: indexPath.row, m: m,section: self.sectionIndex)
        }
        
    }
}
extension CourseDetailMidTeacherView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell:CourseDetailMidTeacherViewCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.UnidId, for: indexPath) as! CourseDetailMidTeacherViewCollectionViewCell
        cell.model = self.dataArr[indexPath.row]
        
        return cell
    }
}

