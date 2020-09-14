//
//  AddHonorCollectionViewCell.swift
//  xueguo
//
//  Created by CityMedia on 2019/7/20.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit
protocol AddHonorCollectionViewCellDelegate:NSObjectProtocol {
    func AddHonorCollectionViewCellDelegateDel(indexP :IndexPath);
}

class AddHonorCollectionViewCell: UICollectionViewCell {

    var indexP:IndexPath?
    var delegate : AddHonorCollectionViewCellDelegate?
    @IBOutlet weak var btnDel: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var labTitle: UILabel!
    
    var isLast:Bool?{
        didSet{
            if isLast!{
                btnDel.isHidden = true
                labTitle.isHidden = true
                img.image = UIImage.init(named: "honor_uolpad")
            }else{
                btnDel.isHidden = false
                labTitle.isHidden = false
                img.image = UIImage.init(named: "defalut")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnActionDel(_ sender: Any) {
        if (delegate != nil) && delegate?.responds(to: Selector(("AddHonorCollectionViewCellDelegateDel"))) != nil {
            delegate?.AddHonorCollectionViewCellDelegateDel(indexP: self.indexP!);
        }
        
    }
}
