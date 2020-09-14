//
//  BaseStruct.swift
//  xueguo
//
//  Created by CityMedia on 2019/5/27.
//  Copyright © 2019 free. All rights reserved.
//

import UIKit

class BaseStruct: NSObject {

}
struct BaseError: Error {
    var desc = ""
    var localizedDescription: String{
        return  desc
    }
    init(_ desc:String) {
        self.desc = desc
    }
}
