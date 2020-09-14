//
//  QANullView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/27.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class QANullView: UIView {

    @IBOutlet weak var labText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
        let rect = CGRect.init(x: 0, y: 0, width: 233, height: 33)
 
        
        let path:UIBezierPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: [UIRectCorner.bottomLeft,.topRight], cornerRadii: CGSize.init(width: 10, height: 10))
        
        let layer = CAShapeLayer.init()
        layer.path = path.cgPath
        layer.frame = rect
        labText.layer.mask = layer
        
    }
    func setupViews(){
        
    }


}
