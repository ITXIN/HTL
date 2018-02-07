//
//  HTLRootCell.swift
//  HotTopLine
//
//  Created by avazuholding on 2017/8/25.
//  Copyright © 2017年 bert. All rights reserved.
//

import UIKit
import LTMorphingLabel
class HTLRootCell: UITableViewCell {

    var bgView: UIView!
    var contentLab: LTMorphingLabel!
    var bgImageView:UIImageView!
    var userIcon:UIImageView!
    
    var dayLab:LTMorphingLabel!
    var monthLab:LTMorphingLabel!
    var weekLab:LTMorphingLabel!
    var dateView:UIView!
    
    var descripLab:UILabel!
//    var updateTimeLab:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configeSubview(rootDataModel: HTLRootDataModel) {
        
        let dateArr = HTLProjectHelper.dateSubscrip(dateStr: rootDataModel.pub_time as String)
        dayLab.text = dateArr[1] as? String
        monthLab.text = dateArr[0] as? String
        weekLab.text = dateArr[2] as? String
        descripLab.text = rootDataModel.Description
        bgImageView.kf.setImage(with: URL.init(string: kImageBaseURL.appending(rootDataModel.image_url)))
    }
    
    
    func initSubviews() {
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
        
        userIcon = ({ () -> UIImageView in
            let img =  UIImageView.init()
            bgView.addSubview(img)
            return img
            }())
        
//        <#name#> = ({ () -> UILabel in
//            let lab =  UILabel.init()
//            <#superview#>.addSubview(lab)
//            lab.textColor = <#color#>
//            lab.font = UIFont.<#font#>
//            return lab
//            }())
        
//        contentLab = LTMorphingLabel.init()
//        bgView.addSubview(contentLab)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(bgView)
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
