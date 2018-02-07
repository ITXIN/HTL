//
//  HTLRequestManager.swift
//  HotTopLine
//
//  Created by avazuholding on 2017/8/25.
//  Copyright © 2017年 bert. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class HTLRequestManager: NSObject {
    
    typealias succeedHandlerBlock = (_ responseObject:AnyObject)-> Void
    typealias failedHandlerBlock = (_ error:NSError)-> Void
    
    struct Inner {
        static var instance:HTLRequestManager?
        static var token:Int = 0
        
    }
    
    fileprivate static var __once:() = {
        Inner.instance = HTLRequestManager()
    }()
    
    class var shared: HTLRequestManager {
        _ = HTLRequestManager.__once
        return Inner.instance!
    }
    
    
    func getDataWithUrlStr(_ urlStr:String , parameters parame:NSDictionary,succeedHandler: succeedHandlerBlock!, failedHandler: failedHandlerBlock!) {
        
        Alamofire.request(urlStr).responseJSON { (DataResponse) in
            if  (DataResponse.result.value != nil){
//                print("Json:\(Json) ")
                // NSData->NSDictonary
                let dic = try? JSONSerialization.jsonObject(with: DataResponse.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [NSString: Any]
//                print(dic )
                succeedHandler(dic as AnyObject)
//                let status = dic? ["status"]
//                print(dic )
            }else{
                failedHandler(DataResponse.result.error! as NSError)
            }
        }
        
    }
    
    
}
