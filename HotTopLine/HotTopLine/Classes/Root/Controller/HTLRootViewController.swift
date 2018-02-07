//
//  HTLRootViewController.swift
//  HotTopLine
//
//  Created by avazuholding on 2017/8/25.
//  Copyright © 2017年 bert. All rights reserved.
//

import UIKit

class HTLRootViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var rootView  = HTLRootView.init()
    var tableView : UITableView!
    var dataArr = NSMutableArray.init()
    let reuseID = "reuseRootCell"
    let testStr = "test"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.coinfigSubviews()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.trailing.leading.equalTo(self.view)
        }
    }
    func coinfigSubviews() {
        //        let tapAction = UITapGestureRecognizer.init(target: self, action:#selector(self.tapAction))
        //        rootView.addGestureRecognizer(tapAction)
        self.view.addSubview(rootView)
        tableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.plain)
        self.view.addSubview(tableView)
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HTLRootCell.self, forCellReuseIdentifier: reuseID)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        extendedLayoutIncludesOpaqueBars = true;
        
        /*
         http://lab.zuimeia.com/wallpaper/category/2/?openUDID=17f287310326cc35eb4fd81c189faae896874629&appVersion=2.1.0&time=0&platform=iphone&systemVersion=10.3.2&resolution=%7B750%2C%201334%7D&page_size=20
         
         http://wpstatic.zuimeia.com/images/bee16b7454f45ec96df04044f1e5ea0a_2875x2556.jpeg
         */
        
        self.requestData()
    }
    
    func tapAction() {
        rootView.changeMorPhingEffect()
    }
    
    func requestData() {
        HTLRequestManager.shared.getDataWithUrlStr(kRequestBaseURL, parameters: NSDictionary.init(), succeedHandler: { (AnyObject) in
            let dic = AnyObject as! NSDictionary
            let dataDic = dic["data"] as! NSDictionary
            let imagesArr = dataDic["images"] as! NSArray
            
            for dic in imagesArr{
                let rootModel = HTLRootDataModel.init(Dictionary: dic as! [String : AnyObject])
                self.dataArr.add(rootModel)
            }
            
            self.tableView.reloadData()
            
        }) { (NSError) in
            
        }
    }
    
    
    //UITableviewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kScreenWidth
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = HTLDetailViewController()
        detailVC.dataArr = dataArr
        detailVC.scrooToIndex = indexPath
        self.present(detailVC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! HTLRootCell
        cell.configeSubview(rootDataModel: dataArr[indexPath.row] as! HTLRootDataModel)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
