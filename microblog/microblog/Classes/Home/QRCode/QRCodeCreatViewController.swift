//
//  QRCodeCreatViewController.swift
//  microblog
//
//  Created by QHC on 6/17/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit

class QRCodeCreatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的名片"
        view.backgroundColor = UIColor.purpleColor()
        
        view.addSubview(imageV)
        
        creatQRCode()
        
    }
    
    private func creatQRCode() {
        
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        filter.setDefaults()
        
        let data = "我的名片".dataUsingEncoding(NSUTF8StringEncoding)
        filter.setValue(data, forKey: "inputMessage")
        let ciImage = filter.outputImage!
        
        imageV.image = createNonInterpolatedUIImageFormCIImage(ciImage, size: 300)
    
    }
    
    /**
     生成高清二维码
     
     - parameter image: 需要生成原始图片
     - parameter size:  生成的二维码的宽高
     */
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = CGRectIntegral(image.extent)
        let scale: CGFloat = min(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent))
        
        // 1.创建bitmap;
        let width = CGRectGetWidth(extent) * scale
        let height = CGRectGetHeight(extent) * scale
        let cs: CGColorSpaceRef = CGColorSpaceCreateDeviceGray()!
        let bitmapRef = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImageRef = context.createCGImage(image, fromRect: extent)
        
        CGContextSetInterpolationQuality(bitmapRef,  CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        // 2.保存bitmap到图片
        let scaledImage: CGImageRef = CGBitmapContextCreateImage(bitmapRef)!
        
        return UIImage(CGImage: scaledImage)
    }
    
    
    // MARK: -----  懒加载
    private lazy var imageV: UIImageView = {
        let imageV = UIImageView()
        imageV.bounds.size.width = 300
        imageV.bounds.size.height = 300
        imageV.center = self.view.center
        
        return imageV
    }()
    
    
    

}
