//
//  HTLDetailCell.swift
//  HotTopLine
//
//  Created by avazuholding on 2017/8/26.
//  Copyright © 2017年 bert. All rights reserved.
//

import UIKit
import LTMorphingLabel
import CoreMotion

class HTLDetailCell: UICollectionViewCell {
    var bgView: UIView!
    var dayLab:LTMorphingLabel!
    var monthLab:LTMorphingLabel!
    var weekLab:LTMorphingLabel!
    var dateView:UIView!
    var descripLab:UILabel!
    var bgImageView:UIImageView!
    var mManager:CMMotionManager!
    var isScaleToReduce: Bool = false
    typealias DidSelectBlock = (_ isSelect:Bool)-> Void
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
        self.stratUpdateAccelermetreResult()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSelectItemCell(_ didSelectBlock:DidSelectBlock) {
        isScaleToReduce = !isScaleToReduce
        UIView.animate(withDuration: 0.8) {
            if self.isScaleToReduce == true {
                self.descripLab.isHidden = true
                self.dateView.snp.removeConstraints()
                self.bgImageView.snp.updateConstraints { (make) in
                    make.center.equalTo(self.bgView)
                    make.size.equalTo(CGSize.init(width: kScreenWidth-64, height: kScreenHeight-64*2))
                }
                self.dateView.snp.removeConstraints()
                self.dateView.snp.makeConstraints { (make) in
                    make.top.equalTo(64)
                    make.left.equalTo(64-20)
                    make.height.equalTo(75)
                    make.width.equalTo(kScreenWidth-64*2)
                }
            }else{
                self.descripLab.isHidden = false
                self.bgImageView.snp.removeConstraints()
                self.dateView.snp.removeConstraints()
                self.bgImageView.snp.makeConstraints { (make) in
                    make.center.equalTo(self.bgView)
                    make.size.equalTo(CGSize.init(width: kScreenWidth, height: kScreenHeight))
                    
                }
                
                self.dateView.snp.makeConstraints { (make) in
                    make.top.equalTo(0)
                    make.height.equalTo(75)
                    make.trailing.leading.equalTo(self.bgView)
                }
            }
        }
        didSelectBlock(self.isScaleToReduce)
        
        
    }
    
    func configeSubview(rootDataModel: HTLRootDataModel) {
        
        let dateArr = HTLProjectHelper.dateSubscrip(dateStr: rootDataModel.pub_time as String)
        dayLab.morphingEffect = LTMorphingEffect.sparkle
        
        descripLab.text = rootDataModel.Description
        bgImageView.kf.setImage(with: URL.init(string: kImageBaseURL.appending(rootDataModel.image_url)))
        dayLab.text = "00"
        
        UIView.animate(withDuration: 1) {
            self.dayLab.morphingEffect = LTMorphingEffect.scale
            self.dayLab.text = dateArr[1] as? String
            self.monthLab.text = dateArr[0] as? String
            self.weekLab.text = dateArr[2] as? String
        }
        
    }
    
    func stratUpdateAccelermetreResult() {
        
        //        if self.mManager.isAccelerometerAvailable {
        //            self.mManager.accelerometerUpdateInterval = 10
        //            mManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { (data:CMAccelerometerData, error:Error) in
        //                print(data)
        //            } as! CMAccelerometerHandler)
        //        }else{
        //
        //        }
        
    }
    
    func initSubviews() {
        
        mManager = CMMotionManager.init()
        
        
        bgView = ({ () -> UIView in
            let view =  UIView.init()
            self.contentView.addSubview(view)
            view.backgroundColor = UIColor.lightGray
            return view
            }())
        bgImageView = ({ () -> UIImageView in
            let img =  UIImageView.init()
            bgView.addSubview(img)
            
            img.contentMode = UIViewContentMode.scaleAspectFill
            img.autoresizesSubviews = true
            //            img.autoresizingMask = UIViewAutoresizing.flexibleLeftMargin.union(UIViewAutoresizing.flexibleTopMargin).union(UIViewAutoresizing.flexibleHeight).union(UIViewAutoresizing.flexibleWidth)
            
            img.autoresizingMask = UIViewAutoresizing.flexibleLeftMargin.union(UIViewAutoresizing.flexibleTopMargin).union(UIViewAutoresizing.flexibleHeight).union(UIViewAutoresizing.flexibleWidth).union(UIViewAutoresizing.flexibleBottomMargin).union(UIViewAutoresizing.flexibleRightMargin)
            img.layer.masksToBounds = true
            
            return img
            }())
        dateView = ({ () -> UIView in
            let view =  UIView.init()
            bgView.addSubview(view)
            return view
            }())
        
        
        dayLab = ({ () -> LTMorphingLabel in
            let lab =  LTMorphingLabel.init()
            dateView.addSubview(lab)
            lab.font = UIFont.systemFont(ofSize: 50)
            lab.textColor = UIColor.white
            lab.morphingEffect = LTMorphingEffect.scale
            return lab
            }())
        monthLab = ({ () -> LTMorphingLabel in
            let lab =  LTMorphingLabel.init()
            dateView.addSubview(lab)
            lab.font = UIFont.systemFont(ofSize: 15)
            lab.textColor = UIColor.white
            return lab
            }())
        weekLab = ({ () -> LTMorphingLabel in
            let lab =  LTMorphingLabel.init()
            dateView.addSubview(lab)
            lab.font = UIFont.systemFont(ofSize: 15)
            lab.textColor = UIColor.white
            return lab
            }())
        
        descripLab = ({ () -> UILabel in
            let lab =  UILabel.init()
            bgView.addSubview(lab)
            lab.textColor = UIColor.white
            lab.font = UIFont.systemFont(ofSize: 15)
            lab.numberOfLines = 0
            lab.lineBreakMode = NSLineBreakMode.byWordWrapping
            return lab
            }() )
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        bgImageView.snp.makeConstraints { (make) in
            //            make.edges.equalTo(bgView)
            make.center.equalTo(bgView)
            make.size.equalTo(CGSize.init(width: kScreenWidth, height: kScreenHeight))
        }
        
        dateView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.height.equalTo(75)
            make.trailing.leading.equalTo(bgView)
        }
        
        dayLab.snp.makeConstraints { (make) in
            make.left.top.equalTo(20)
            make.right.equalTo(monthLab.snp.left).offset(-5)
        }
        monthLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(dayLab.snp.centerY)
            make.left.equalTo(dayLab.snp.right).offset(5)
        }
        weekLab.snp.makeConstraints { (make) in
            make.top.equalTo(dayLab.snp.centerY)
            make.left.equalTo(dayLab.snp.right).offset(5)
        }
        
        
        descripLab.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgView)
            make.width.equalTo(kScreenWidth-40)
            make.top.equalTo(dateView.snp.bottom).offset(5)
        }
    }
    
    
    
}
