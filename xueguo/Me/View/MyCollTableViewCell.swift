//
//  MyCollTableViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/24.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
enum FileType:Int{
    case exe = 0
    case ppt
    case mp4
    case word
    case pdf
    case excel
}


class MyCollTableViewCell: UITableViewCell {

    var model:ModelCollection?{
        didSet{
            self.labTitle.text = model!.resourceSrc.title
            self.labType.text = model!.resourceSrc.srcFormat
            self.labNumber.text = model!.resourceSrc.views + "次浏览"
            let type :String = model!.resourceSrc.srcFormat
            
            if type == "png" ||  type == "exx"{
                self.labSize.text = "大小:" + self.getFileSize(size: model!.resourceSrc.srcSize)
            }else if type == "mp4"{
                self.labSize.text = "时长:" + self.getFileLTime(time: model!.resourceSrc.srcLength)
            }else
            {
                self.labSize.text = "页数:" + model!.resourceSrc.srcNotes + "页"
            }
            
            
        }
    }
    @IBOutlet weak var labType: UILabel!
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var labNumber: UILabel!
    @IBOutlet weak var labSize: UILabel!
    @IBOutlet weak var labTitle: UILabel!
 
    func getFileLTime(time:String) -> String{
        let number :Int = time.toInt()
        let second = number % 60
        let minute = number / 60
        
        return String(minute) + ":" + String(second)
    }
    func getFileSize(size:String) -> String{
        let kb = (size.toInt()) / 1000
        if kb > 1000 {
            let m = kb / 1000
            return String(m) + "m"
        }else
        {
            return String(kb) + "kb"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        baseConfiguration()
        setupViews()
    }
    func baseConfiguration() -> Void {
        viewColor.backgroundColor = getColorWithFileType(FileType(rawValue: getArc(4))!)
    }
    func getArc(_ i:Int) -> Int{
        return Int(arc4random()) % i
    }
    func getColorWithFileType(_ type:FileType) -> UIColor{
        let arr :[String] = ["#FF54B6F1","#FFEFB872","#FF99CF59","#FF54B6F1","#FF7B88AA","#FFF1A09E"]
        let hex:String = arr[type.rawValue]
        return UIColor.colorWithHex(hexStr: hex)
    }
    func setupViews(){
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
    
 
    
}
