//
//  HTLRootDataModel.swift
//  HotTopLine
//
//  Created by avazuholding on 2017/8/26.
//  Copyright © 2017年 bert. All rights reserved.
//

import UIKit

class HTLRootDataModel: NSObject {
    var pub_time = String()
    var Description  = String()
    var image_url  = String()
    var ID  = String()
    
    init(Dictionary dic: [String : AnyObject]) {
        super.init()
        self.setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?,forUndefinedKey key: String)
    {
    
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if (key == "description") {
            self.setValue(value, forUndefinedKey: "Description")
        }
        if (key == "id") {
            self.setValue(value, forUndefinedKey: "ID")
        }
        
        if( value is NSNumber)
        {
            let str = String(describing: value)
            super.setValue(str, forKey: key)
        }else
        {
            super.setValue(value, forKey: key)
        }
        
    }
}
