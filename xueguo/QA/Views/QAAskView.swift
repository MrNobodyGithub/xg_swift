//
//  QAAskView.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/27.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class QAAskView: UIView {

    var blockKeyboardApper:BaseBlock?
    var blockKeyboardDisapper:BaseBlock?
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var labNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        
    }
    func setupViews(){
        textView.layer.cornerRadius = 5
        textView.layer.masksToBounds = true
        textView.delegate = self
        textView.addPlaceHolder(placeText: "填写追问内容")
        
        let toolbar = CommonTool.inputAccessoryView(self, #selector(keyboardDissappear))
        textView.inputAccessoryView = toolbar
    }
    @objc func keyboardDissappear(){
        self.endEditing(true)
    }
}

extension QAAskView:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if let _ = blockKeyboardApper{
            blockKeyboardApper!("")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let _ = blockKeyboardDisapper{
            blockKeyboardDisapper!("")
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        let count = textView.text.count
        let str = textView.text
        let threshould : Int = 500
        if count > threshould {
            let stra:String = String(str!.prefix(threshould))
            textView.text = stra
            return
        }
        labNumber?.text = "(\(count)/500)"
        
    }
}
