//
//  WorkDetailMyWorksView.swift
//  xueguo
//
//  Created by CityMedia on 2019/6/19.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

protocol WorkDetailMyWorksViewDelegate:NSObjectProtocol {
    func WorkDetailMyWorksViewDelegateAdd()
    func WorkDetailMyWorksViewDelegateDelete(m:NSObject)
}

class WorkDetailMyWorksView: UIView {
// 80 + 91 * n
    
    var delegate:WorkDetailMyWorksViewDelegate?
    
    var array:Array<Any>?{
        didSet{
            setupSubViewsWith(number: array!.count)
        }
    }
    
    @IBOutlet weak var viewCon: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.colorWithHex(hexStr: "#F8F9FA")
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void { 
    }
    var number = 0;
    
    func setupViews(){
    }
    
    func setupSubViewsWith(number: NSInteger){
    
        self.number = number;
        for v in self.viewCon!.subviews{
            v.removeFromSuperview()
        }
        
        var y:CGFloat = 0
        let h:CGFloat = 91
        if number > 0 {
            for i in 1...number{
                let v1:WorkDetailCellView = WorkDetailCellView.init(frame: CGRect.init(x: 0, y: y, width: SCREEN_WIDTH, height: h))
                self.viewCon.addSubview(v1)
                v1.labTitle.text = v1.labTitle.text! + String.init(i)
                y += h
                v1.delegate = self as WorkDetailCellViewDelegate
            }
        }
       
        // 底部 添加作业 // 添加底部约束
        let y_down = self.frame.height - 80 - h;
        
        let v_down:WorkDetailCellViewAdd = WorkDetailCellViewAdd.init(frame: CGRect.init(x: 0, y: y_down , width: SCREEN_WIDTH, height: h))
        self.viewCon.addSubview(v_down)
        v_down.delegate = self
        
    }
    // 添加一条数据
    func addOne(){
        setupSubViewsWith(number: (self.number + 1))
    }
    func deleteOne(m:NSObject){
        setupSubViewsWith(number: (self.number - 1))
    }
}
extension WorkDetailMyWorksView:WorkDetailCellViewDelegate{
    func WorkDetailCellViewDelegateDelete(m: NSObject) {
        if (delegate != nil) && delegate?.responds(to: Selector(("WorkDetailMyWorksViewDelegateDelete(:)"))) != nil {
            delegate?.WorkDetailMyWorksViewDelegateDelete(m: NSObject.init())
        }
        
    }
}
extension WorkDetailMyWorksView:WorkDetailCellViewAddDelegate{
    func WorkDetailCellViewAddDelegateTap() {
        if (delegate != nil) && delegate?.responds(to: Selector(("WorkDetailMyWorksViewDelegateAdd"))) != nil {
            delegate?.WorkDetailMyWorksViewDelegateAdd()
        }
    }
}
