//
//  NewFeaturesViewController.swift
//  microblog
//
//  Created by QHC on 6/25/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit


class NewFeaturesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // 图片数量
    let imageCount: Int = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    // MARK: -----  UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCount
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("newFeaturesCell", forIndexPath: indexPath) as! NewFeaturesCollectionCell
        
        cell.index = indexPath.item
        
        cell.accessBtn.hidden = true
        
        return cell
    }
    
    // MARK: ----- UICollectionViewDelegate
    // cell完全显示时调用
    // 返回的indexPath是当前显示cell上一个cell的indexPath
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        // 获取当前显示cell的indexPath
        let currentIndex = collectionView.indexPathsForVisibleItems().last!
        
        // 获取当前cell
        let cell = collectionView.cellForItemAtIndexPath(currentIndex) as! NewFeaturesCollectionCell
        
        // 判断是否是最后一个
        if currentIndex.item == imageCount - 1 {
            
            cell.accessBtn.hidden = false
            cell.accessBtn.userInteractionEnabled = false
            cell.accessBtn.transform = CGAffineTransformMakeScale(0.0, 0.0)
            
            // usingSpringWithDamping 的范围为 0.0f 到 1.0f ，数值越小「弹簧」的振动效果越明显。
            // initialSpringVelocity 则表示初始的速度，数值越大一开始移动越快, 值得注意的是，初始速度取值较高而时间较短时，也会出现反弹情况。
            UIView.animateWithDuration(2.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10.0, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                    cell.accessBtn.transform = CGAffineTransformIdentity
                }, completion: { (_) -> Void in
                    cell.accessBtn.userInteractionEnabled = true
            })

        }
        
    }

}

// MARK: ----- UICollectionViewCell
class NewFeaturesCollectionCell: UICollectionViewCell {

    var index: Int = 0
        {
        didSet{
            iconImageView.image = UIImage(named: "new_feature_\(index + 1)")
        }
    }
    
    // MARK: -----  懒加载
    private lazy var iconImageView = UIImageView()
   
    private lazy var accessBtn: UIButton = {
        
        let btn = UIButton(backgroundImageName: "new_feature_button")
        btn.addTarget(self, action: #selector(NewFeaturesCollectionCell.accessClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }

    private func setupSubviews() {
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(accessBtn)
        
        iconImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        accessBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom).offset(-200)
        }
        
    }
    
    @objc private func accessClick() {
    
        QHCLog("点击进入微博")
    
    }
    

}


// MARK: ----- UICollectionViewFlowLayout
class NewFeaturesFlowLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        super.prepareLayout()
        
        itemSize = collectionView!.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
        
    }
    
    
    
}