//
//  HTLDetailViewController.swift
//  HotTopLine
//
//  Created by avazuholding on 2017/8/26.
//  Copyright © 2017年 bert. All rights reserved.
//

import UIKit
import Photos
import PMAlertController
class HTLDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,HTLDetailBottomViewDelegate {
    
    var collectionView:UICollectionView!
    var dataArr:NSMutableArray!
    let reuseID = "reuseIDCell"
    var backBtn:UIButton!
    var scrooToIndex:IndexPath!
    var bottomView:HTLDetailBottomView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.scrollToItem(at: scrooToIndex, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        collectionView.reloadData()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.coinfigSubviews()
    }
    
    func coinfigSubviews() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        //        dataArr = NSMutableArray.init()
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.itemSize = CGSize.init(width: kScreenWidth, height: kScreenHeight)
        flowLayout.minimumLineSpacing = 0.0
        
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HTLDetailCell.self, forCellWithReuseIdentifier: reuseID)
        collectionView.isPagingEnabled = true
        collectionView.backgroundView = HTLRootView.init()
        
        self.view.addSubview(collectionView)
        
        
        backBtn = ({ () -> UIButton in
            let btn =  UIButton.init()
            self.view.addSubview(btn)
            btn.addTarget(self, action:#selector(self.backRootVC), for: UIControlEvents.touchUpInside)
            //            btn.setTitle("back", for: UIControlState.normal)
            btn.setImage(UIImage.init(named: "menu_detail"), for: UIControlState.normal)
            btn.snp.makeConstraints({ (make) in
                make.top.equalTo(30)
                make.right.equalTo(-20)
                
            })
            return btn
            }())
    }
    
    func backRootVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //detailBottomViewDelegate
    func bottomAction(bottomActionType: BottomActionType) {
        switch bottomActionType {
        case .SaveImage:
            HTLog("SaveImage")
            let arr =  collectionView.visibleCells;
            let cell = arr[0] as!HTLDetailCell;
            let image = cell.bgImageView.image
            //                print(scrooToIndex.row,arr,cell)
            DispatchQueue.main.async { // Correct
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image!)
                    
//                    PHAssetChangeRequest.creationRequestForAsset(from: HTLProjectHelper().cutImageWithImage(image: image!))
                    
                    
                    //                let img =  HTLProjectHelper().getScreenShot
                    //                    PHAssetChangeRequest.creationRequestForAsset(from: img())
                    
                }, completionHandler: { (bol:Bool, error:Error?) in
                    self.showAlert(bol:bol)
                    
                })
            }
            
            break
        case .Beautiful:
            HTLog("Beautiful")
            break
        case .Other:
            HTLog("Other")
            break
            
        default:
            break
        }
    }
    func showAlert(bol:Bool) {
        let alertVC = PMAlertController.init(title:"保存图片", description: (bol ?"保存成功":"保存失败"), image: nil, style: PMAlertControllerStyle.alert)
        alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
            print("Capture action OK")
        }))
        self.present(alertVC, animated: true, completion: nil)
        
        
        //                    FFToast.show(withTitle: "保存图片", message: (bol ?"保存成功":"保存失败"), iconImage: nil, duration: 0.5, toastType: FFToastType.default)
        
        
    }
    
    //UICollectionDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HTLDetailCell
        cell.setupSelectItemCell { (didSeleted) in
            if didSeleted{
                self.collectionView.isScrollEnabled = false
                self.backBtn.isHidden = true
                self.bottomView = HTLDetailBottomView.init(frame: CGRect.init(x: 0, y: kScreenHeight/3*2, width: kScreenWidth, height: kScreenHeight/3))
                self.bottomView.detailBottomViewDelegate = self
                self.view.addSubview(self.bottomView)
                
            }else{
                self.collectionView.isScrollEnabled = true
                self.backBtn.isHidden = false
                self.bottomView.removeFromSuperview()
                self.bottomView = nil
            }
        }
        
    }
    
    //DFSF
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as! HTLDetailCell
        cell.configeSubview(rootDataModel: dataArr[indexPath.row] as! HTLRootDataModel )
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
