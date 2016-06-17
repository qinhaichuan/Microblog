//
//  QRCodeViewController.swift
//  microblog
//
//  Created by QHC on 6/17/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {

    @IBOutlet var customContainView: UIView!
    @IBOutlet weak var customTabBar: UITabBar!
    @IBOutlet weak var scanView: UIImageView!
    @IBOutlet weak var customViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scanViewTopLayout: NSLayoutConstraint!
    @IBOutlet weak var resultLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customTabBar.selectedItem = customTabBar.items![0]
        customTabBar.delegate = self
        
        // 开始扫描动画
        startAnimaton()
        
        // 开始扫描
        startScan()
        
    }
    
    private func startAnimaton() {
    
        scanViewTopLayout.constant = -customViewHeight.constant
        view.layoutIfNeeded()
        
        UIView.animateWithDuration(1.0) { () -> Void in
            
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanViewTopLayout.constant = self.customViewHeight.constant
            self.view.layoutIfNeeded()
            
        }
    
    }
    
    private func startScan() {
        
        if !session.canAddInput(input) {
            return
        }
        if !session.canAddOutput(output) {
            return
        }
        session.addInput(input)
        session.addOutput(output)
        
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        
        session.startRunning()
        
    
    }
    
    
    // MARK: -----  懒加载
   
    /// 创建输入
    private lazy var input: AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let deviceInput = try? AVCaptureDeviceInput(device: device)
        return deviceInput
    }()
    /// 创建输出
    private lazy var output: AVCaptureMetadataOutput = {
        
        let output = AVCaptureMetadataOutput()
        // 该属性接收的不是坐标, 而是比例
        // 该属性并不是以竖屏的左上角作为参照, 而是以横屏的左上角作为参照
        // 所以计算时, x就变成了y, y就变成了x, width就变成了height, height就变成了width
        //        out.rectOfInterest = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
        let rect = self.view.frame

        let containerRect = self.customContainView.frame
        output.rectOfInterest = CGRect(x: containerRect.origin.y / rect.size.height, y: containerRect.origin.x / rect.size.width , width: containerRect.size.height / rect.size.height , height: containerRect.size.width / rect.size.width)
        
        return output
   
    }()
    /// 创建会话
    private lazy var session: AVCaptureSession = AVCaptureSession()
    /// 创建预览图层
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
        previewLayer.frame = self.view.bounds
        return previewLayer
    }()
    /// 创建保存二维码连线的图层
    private lazy var drawLayer: CALayer = {
        let drawLayer = CALayer()
        drawLayer.frame = self.view.bounds
        return drawLayer
    }()
    
    // MARK: -----  点击
    @IBAction func closeClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // 打开相册
    @IBAction func openPickerVc(sender: UIBarButtonItem) {
        
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) else {
            return
        }
        
        let imagePickerVc = UIImagePickerController()
        imagePickerVc.delegate = self
        presentViewController(imagePickerVc, animated: true, completion: nil)
        
    }
   
    // 创建我的名片
    @IBAction func creatMyQRCode(sender: UIButton) {
        
        navigationController?.pushViewController(QRCodeCreatViewController(), animated: true)
        
    }
    
    

}

// MARK: ------ UIImagePickerControllerDelegate
extension QRCodeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // 只要选中一张图片就会调用此方法
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        let ciImage = CIImage(image: image)!
        let dict = [CIDetectorAccuracy:CIDetectorAccuracyHigh]
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: dict)
        let features = detector.featuresInImage(ciImage)
        
        for objc in features {
            resultLbl.text = (objc as! CIQRCodeFeature).messageString
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }


}


// MARK: ------ AVCaptureMetadataOutputObjectsDelegate
extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        // ?? 如果前面的不为nil, 就不执行后面的语句; 如果前面为nil, 就返回后面的值
        resultLbl.text = metadataObjects.last?.stringValue ?? "将二维码/条形码放入框中进行扫描"
        
        // 清空描线
        clearLines()
        
        // 处理结果
        for objc in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            // 转换坐标
            let result = previewLayer.transformedMetadataObjectForMetadataObject(objc)
            drawLines(result as! AVMetadataMachineReadableCodeObject)
            
        }
        
        
        
        // 跳转到二维码控制器
        //        metadataObjects.last ? 跳转 : 不跳转
//        let isPush = (metadataObjects.last != nil) ? true : false
        let isPush = true
        if isPush {
            QRResultViewController().resultString = resultLbl.text!
            navigationController?.pushViewController(QRResultViewController(), animated: true)
        }
        
    }
    
    // 描线
    private func drawLines(cornerObjc: AVMetadataMachineReadableCodeObject) {
        
        guard let corners = cornerObjc.corners else {
            return
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.blueColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 3
        
        let path = UIBezierPath()
        var point = CGPoint.zero
        var index = 0
        
        CGPointMakeWithDictionaryRepresentation((corners[index++] as! CFDictionary), &point)
        path.moveToPoint(point)
        
        while index < corners.count {
            CGPointMakeWithDictionaryRepresentation(corners[index++] as! CFDictionary, &point)
            path.addLineToPoint(point)
        }
        
        path.closePath()
        shapeLayer.path = path.CGPath
        
        drawLayer.addSublayer(shapeLayer)
    
    }
    
    private func clearLines() {
        
        guard let subLayers = drawLayer.sublayers else {
            return
        }
        
        for layer in subLayers {
            layer.removeFromSuperlayer()
        }
    
    }
    

}

// MARK: ------ UITabBarDelegate
extension QRCodeViewController: UITabBarDelegate {

    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
       
        customViewHeight.constant = item.tag == 0 ? 300 : 150
        
        scanView.layer.removeAllAnimations()
        startAnimaton()
        
    }

}