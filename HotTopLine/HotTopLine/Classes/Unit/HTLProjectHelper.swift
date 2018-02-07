//
//  HTLProjectHelper.swift
//  HotTopLine
//
//  Created by avazuholding on 2017/8/26.
//  Copyright © 2017年 bert. All rights reserved.
//

import UIKit

class HTLProjectHelper: NSObject {
    
  class  func dateSubscrip(dateStr:String) -> NSArray {
        let subArr = dateStr.components(separatedBy: "-")
        
        let monthStr = subArr[1]
        
        let dayStr = subArr[2]
        
        var mothStrEn:NSString!
    
        
        /*
         一月：January 简写Jan.
         二月：February 简写Feb.
         三月：March 简写Mar.
         四月：April 简写Apr.
         五月：May 简写May.
         六月：June 简写Jun.
         七月：July 简写Jul.
         八月：August 简写Aug.
         九月：September 简写Sep. / Sept.
         十月：October 简写Oct.
         十一月：November 简写Nov.
         十二月：December 简写Dec.*/
        
        switch  Int(monthStr) {
        case 1?:
            mothStrEn = "January"
            break
        case 2?:
            mothStrEn = "February"
            break
        case 3?:
            mothStrEn = "March"
            break
        case 4?:
            mothStrEn = "April"
            break
        case 5?:
            mothStrEn = "May"
            break
        case 6?:
            mothStrEn = "June"
            break
        case 7?:
            mothStrEn = "July"
            break
        case 8?:
            mothStrEn = "August"
            break
        case 9?:
            mothStrEn = "September"
            break
        case 10?:
            mothStrEn = "October"
            break
        case 11?:
            mothStrEn = "November"
            break
        case 12?:
            mothStrEn = "December"
            break
        default:
            mothStrEn = "December"
            break
        }
        
        
        
        let weekDays = [NSNull.init(),"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"] as [Any]
        
        let calendar = NSCalendar.init(calendarIdentifier: .gregorian)
        let timeZone = NSTimeZone.init(name: "Asia/Shanghai")
        calendar?.timeZone = timeZone! as TimeZone
        
        let calendarUnit = NSCalendar.Unit.weekday
        
        
        let dateFormatter = DateFormatter.init()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        let theComponents = calendar?.components(calendarUnit, from:      dateFormatter.date(from: dateStr as String)!)
        
        let weekstr = weekDays[(theComponents?.weekday)!] as! String
        
        
        let  dataArr = NSArray.init(objects: mothStrEn,dayStr,weekstr)
        
        return dataArr
        
    }
    
    //    func getWeekDay(dateTime:String)->Int{
    //        let dateFmt = DateFormatter()
    //        dateFmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //        let date = dateFmt.date(from: dateTime) date?.description
    //        let interval = Int(date!.timeIntervalSince1970) + NSTimeZone.localTimeZone.secondsFromGMT
    //        let days = Int(interval/86400) // 24*60*60
    //        let weekday = ((days + 4)%7+7)%7
    //        return weekday == 0 ? 7 : weekday
    //    }
    //    func dayOfWeek() -> Int {
    //        let date = NSDate.
    //
    //        var interval = self.timeIntervalSince1970;
    //        var days = Int(interval / 86400);
    //        　return (days - 3) % 7;
    //        　}
    
    func cutImageWithImage(image:UIImage) -> UIImage {
  
    //获取图片
    //获取图片的大小
    let  size = image.size;
    //设置需要剪切的部分(按照原图片的大小进行)
        let  rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
    //转化为CGImageRef
    let  sourceImageRef = image.cgImage;
    //进行裁剪
    let  newImageRef = sourceImageRef!.cropping(to: rect);
    //转化为UIImage
//    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationRight];
        
        let newImage = UIImage.init(cgImage: newImageRef!)
        
    //释放内存
//    CGImageRelease(newImageRef!);
    return newImage;
    
    }
    
    
     func getScreenShot() -> UIImage{
        
        let windown = UIApplication.shared.keyWindow
        
        // 01 开启图片上下文
        UIGraphicsBeginImageContextWithOptions((windown?.bounds.size)!, true, UIScreen.main.scale)
        
//        =================**方法一**==================
        let context = UIGraphicsGetCurrentContext()// 02 获取图片上下文
        windown?.layer.render(in: context!)// 03 将 layer 渲染到图片上下文中
//        ===============**方法一**====================
        
//        ===============**方法二**====================
        windown?.drawHierarchy(in: (windown?.bounds)!, afterScreenUpdates: false)
        //afterScreenUpdates如果是true, 则是addSubview之后,  如果是false,则是addSubview之前
        //自iOS7开始，UIView类提供了一个方法-drawViewHierarchyInRect:afterScreenUpdates:
//        ===============**方法二**====================
        
        // 获取图片
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        // 关闭图片上下文
        UIGraphicsEndImageContext()
        
        //  将图片存储到本地
//        UIImagePNGRepresentation(img!)?.writeToFile("/Users/a/Desktop/w.png", atomically: true)
        
        return img!
        
    }
    
}
