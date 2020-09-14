//
//  HonorSectionView.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/13.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

protocol HonorSectionViewDelegate :NSObjectProtocol{
    func HonorSectionViewDelegateIndex(index:NSInteger)
}

class HonorSectionView: UIView {

    var delegate:HonorSectionViewDelegate?
    var dataArr:Array<String>?{
        didSet{
            self.addSectionViewWith(arr: dataArr! )
        }
    }
    
    var selIndex:NSInteger?{
        didSet{
            self.dealSelIndex(index: selIndex!)
        }
    }
    //----------------------------------------------------
    
    var flagLine:UIView?
    var flagBtn:ZUIButton?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func addSectionViewWith(arr:Array<String>){
        let w:CGFloat = SCREEN_WIDTH / CGFloat(arr.count);
        let h:CGFloat = self.frame.size.height;
        
        var x :CGFloat = 0
        let line_w :CGFloat = 25
        let line_h :CGFloat = 2
        for  (index,str) in (dataArr?.enumerated())! {
            let btn:ZUIButton = ZUIButton.init(frame: CGRect.init(x: x, y: 0, width: w, height: h-line_h))
            self.addSubview(btn)
            btn.setTitle(str, for: .normal)
            btn.cusIndex = 100 + index
            btn.tag = 1000 + index
            btn.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpInside)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            btn.setTitleColor(UIColor.colorWithHex(hexStr: "#484848"), for: .selected)
            btn.setTitleColor(UIColor.colorWithHex(hexStr: "#9B9B9B"), for: .normal)
            x += w
            
            if index == 0{
                btn.isSelected = true;
                flagBtn = btn
                let line:UIView = UIView.init(frame: CGRect.init(x: w/2 - line_w/2, y: h-line_h, width: line_w, height: line_h))
                self.addSubview(line)
                CommonTool.addGradientColo(line.layer, line.frame.size, ["#92DE8A","#59C97B"])
                line.layer.cornerRadius = line_h/2;
                line.layer.masksToBounds = true
                flagLine = line
            }
            
        }
    }
    
    func dealSelIndex(index:NSInteger){
        let btn:ZUIButton = self.viewWithTag(1000+index) as! ZUIButton
        if btn == flagBtn {
            return
        }
        
        btn.isSelected = true;
        flagBtn?.isSelected = false;
        flagBtn = btn;
        
        UIView.animate(withDuration: 0.6) {
            self.flagLine?.center.x = btn.center.x
        }
        
    }
    @objc func btnAction(btn:ZUIButton){
        
        if btn == flagBtn {
            return;
        }
        btn.isSelected = true;
        flagBtn?.isSelected = false;
        flagBtn = btn;
        
        
        let index:NSInteger = btn.cusIndex - 100
        let count :Int = dataArr!.count
        let w:CGFloat = self.frame.size.width / CGFloat(count)
        
//         btn.center.x
        UIView.animate(withDuration: 0.6) {
            self.flagLine?.center.x = btn.center.x
        }
        
        if (delegate != nil) && delegate?.responds(to: Selector(("HonorSectionViewDelegateIndex:"))) != nil {
            delegate?.HonorSectionViewDelegateIndex(index: index)
        }
        
        
    }
    
}
