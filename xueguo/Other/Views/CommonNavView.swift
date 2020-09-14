//
//  CommonNavView.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/15.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class CommonNavView: UIView {

    var title:String? {
        didSet{
            self.labTitle.text = title
        }
    }
    var isHiddenLine:Bool? {
        didSet{
            if isHiddenLine! {
                self.viewLine.isHidden = true
            }
        }
    }
    @IBOutlet weak var viewLine: UIView!
    
    @IBOutlet weak var labTitle: UILabel!
    
    var blockBack:BaseBlockSuccess?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        
    }
    
    @IBAction func btnActionBack(_ sender: Any) {
        if let _ = blockBack{
            blockBack!()
        }
    }
    
}
