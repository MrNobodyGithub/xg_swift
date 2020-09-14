//
//  CusObject.swift
//  xueguo
//
//  Created by CityMedia on 2019/8/11.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
import MJRefresh

class CusObject: NSObject {

}

class ZUIButton: UIButton {
    var cusData:Any?
    var cusType:String = ""
    var cusSel :Bool = false
    var cusIndex:NSInteger = 0
    
}



class ZRefreshGif: MJRefreshGifHeader {
    override func prepare() {
         super.prepare()
        
//        下拉部分_00022
        var arrPull:[UIImage] = []
        for i in 0 ..< 23 {
            var stra = "下拉部分_000"
            var strb = String(i)
            if strb.count == 1{
                strb = "0" + strb
            }
            stra = stra + strb
            let img = UIImage.init(named: stra)!
            arrPull.append(img)
        }
        
        
        var arrIdle:[UIImage] = []
//        合成 1_00010
        for i in 0..<11 {
            var stra:String = "合成 1_000"
            var strb:String = String(i)
            if strb.count == 1{
                strb = "0" + strb
            }
            stra = stra + strb
            let img: UIImage = UIImage.init(named: stra)!
            arrIdle.append(img)
            
        }
//        self.setImages(arrIdle, for: MJRefreshState.pulling)
        self.setImages(arrIdle, for: MJRefreshState.idle)
        
        var arrIng:[UIImage] = []
//        shuaxin_00014
        for i in 0 ..< 15{
            var stra = "shuaxin_000"
            var strb = String(i)
            if strb.count == 1{
                strb  = "0" + strb
            }
            stra = stra + strb
            let img = UIImage.init(named: stra)!
            arrIng.append(img)
        }
        self.setImages(arrIng, for: MJRefreshState.refreshing)
        
        //隐藏 刷新时间
        self.lastUpdatedTimeLabel.isHidden = true
        self.stateLabel.isHidden = true;
        
    }
}
