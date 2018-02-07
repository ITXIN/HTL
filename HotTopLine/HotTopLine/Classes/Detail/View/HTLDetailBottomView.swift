//
//  HTLDetailBottomView.swift
//  HotTopLine
//
//  Created by avazuholding on 2017/8/28.
//  Copyright © 2017年 bert. All rights reserved.
//

import UIKit
enum BottomActionType:NSInteger {
    case SaveImage = 1000,Beautiful,Share,ThirdShare,Other
}
protocol HTLDetailBottomViewDelegate:NSObjectProtocol {
    func bottomAction(bottomActionType:BottomActionType)
}
class HTLDetailBottomView: UIView {
    
    var bgView:UIView!
    var btnArr:NSMutableArray = NSMutableArray.init()
    var detailBottomViewDelegate:HTLDetailBottomViewDelegate!
    
    let margin = (kScreenWidth-45*6)/6
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initSubviews() {
        
        bgView = ({ () -> UIView in
            let view =  UIView.init()
            self.addSubview(view)
            view.backgroundColor = UIColor.clear
            return view
            }())
        let itemsArr = NSArray.init(objects: "保存","美化","敬请期待","敬请期待","敬请期待")
        
        for  index in 0...4 {
            
            let tempBtn = ({ () -> UIButton in
                let btn =  UIButton.init()
                bgView.addSubview(btn)
                btn.tag = 1000 + index
                btn.backgroundColor = RGBA(255, G: 255, B: 255, A: 0.5)
                btn.layer.masksToBounds = true
                btn.layer.cornerRadius = 45/2
                btn.setTitle(NSString.init(format: "%@", itemsArr[index] as! String) as String, for: UIControlState.normal)
                btn.addTarget(self, action: #selector(self.clickAction(sender: )), for: UIControlEvents.touchUpInside)
                return btn
                }())
            
            btnArr.add(tempBtn)
        }
        
        
    }
    
    func clickAction(sender:UIButton) {
    
        if detailBottomViewDelegate != nil {
            detailBottomViewDelegate.bottomAction(bottomActionType: BottomActionType(rawValue: sender.tag)!)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        for  index in 0...4{
            let  btn  = self.btnArr[index] as! UIButton
            btn.snp.makeConstraints({ (make) in
                make.top.equalTo(20)
                make.left.equalTo(index*45+(1+index)*25)
                make.size.equalTo(CGSize.init(width: 45, height: 45))
            })
        }
        
    }
    
}
