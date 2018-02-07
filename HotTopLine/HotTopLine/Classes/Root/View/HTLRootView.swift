//
//  HTLRootView.swift
//  HotTopLine
//
//  Created by avazuholding on 2017/8/25.
//  Copyright © 2017年 bert. All rights reserved.
//

import UIKit
import LTMorphingLabel
class HTLRootView: UIView {
    

    var bgView = UIView.init()
    var bgImageView = UIImageView.init()
    var contentLab: LTMorphingLabel!
   
    
    
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
            view.backgroundColor = UIColor.lightGray
            return view
        }())
        
        let blurEffect  = UIBlurEffect.init(style: .light)
        
//        let vibrancyEffect = UIVibrancyEffect.init(blurEffect: blurEffect)
        let blurView = UIVisualEffectView.init(effect: blurEffect)
        
        bgImageView.image = UIImage.init(named: "root_bg_01")

        bgView.addSubview(bgImageView)
        bgView.addSubview(blurView)
        blurView.snp.makeConstraints { (make) in
            make.edges.equalTo(bgView)
        }
        
        
        contentLab = LTMorphingLabel.init()
        contentLab.text = "Welcome"
        contentLab.morphingEffect = .evaporate
//        contentLab.font = UIFont.fontNames(forFamilyName: ["Helvetica-Bold"])
        contentLab.font = UIFont.systemFont(ofSize: 40, weight: 10)
        contentLab.textColor = UIColor.white
        bgView.addSubview(contentLab)
        
        
    }

    func changeMorPhingEffect() {
        contentLab.morphingEffect = .sparkle
        let index = arc4random()%6
        switch index {
        case 0:
            contentLab.morphingEffect = .scale
        case 1:
            contentLab.morphingEffect = .evaporate
        case 2:
            contentLab.morphingEffect = .fall
        case 3:
            contentLab.morphingEffect = .pixelate
        case 4:
            contentLab.morphingEffect = .burn
        case 5:
            contentLab.morphingEffect = .anvil
        
        default:
            contentLab.morphingEffect = .scale
            
        }
        
        contentLab.text = "Test".appendingFormat("iPhone %d",index)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(bgView)
        }
        
        contentLab.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
            
        }
    }
}
