//
//  AddHonorTopView.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/15.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class AddHonorTopView: UIView {
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldTime: UITextField!
    
    @IBOutlet weak var labType: UILabel!
    
    @IBOutlet weak var labProperty: UILabel!
    
    @IBOutlet weak var textView: UITextView!
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
    
    //MARK: --------------------action-------------------
    
    @IBAction func btnActionType(_ sender: Any) {
    }
    @IBAction func btnActionProperty(_ sender: Any) {
    }
}
