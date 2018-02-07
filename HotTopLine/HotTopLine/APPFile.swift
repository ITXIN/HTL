//
//  APPFile.swift
//  HotTopLine
//
//  Created by avazuholding on 2017/8/25.
//  Copyright © 2017年 bert. All rights reserved.
//

import Foundation

import UIKit
import SnapKit
import LTMorphingLabel
import Alamofire
import Kingfisher
import PMAlertController
//import PullToBounce
let kImageBaseURL:String = "http://wpstatic.zuimeia.com/"
let kRequestBaseURL:String = "http://lab.zuimeia.com/wallpaper/category/2/?openUDID=17f287310326cc35eb4fd81c189faae896874629&appVersion=2.1.0&time=0&platform=iphone&systemVersion=10.3.2&resolution=%7B750%2C%201334%7D&page_size=20"

/*
 * 增加宏定义NSLog输出函数
 */
func HTLog<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):(\(lineNum))-\(messsage)")
    #else  //发布阶段
        print(...)
    #endif

    
}


let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

func RGBA(_ R:CGFloat/*红*/, G:CGFloat/*绿*/, B:CGFloat/*蓝*/, A:CGFloat/*透明*/)->UIColor {
    return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
}
