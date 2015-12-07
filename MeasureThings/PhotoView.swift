//
//  PhotoView.swift
//  MeasureThings
//
//  Created by Charles Konkol on 2015-12-05.
//  Copyright © 2015 Chuck Konkol. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoView: UIView {
     var timer:NSTimer?
    // AVFoundation properties
    var captureDeviceFormat: AVCaptureDeviceFormat!
    var cameraLayer: AVCaptureVideoPreviewLayer!
    var captureDevice: AVCaptureDevice!
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCamera()
    }
    
  
    
    func initCamera() {
        captureSession = AVCaptureSession()
        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        captureDevice = backCamera
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if error == nil && captureSession!.canAddInput(input) {
            captureSession!.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput!.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            if captureSession!.canAddOutput(stillImageOutput) {
                captureSession!.addOutput(stillImageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
                previewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
                self.layer.addSublayer(previewLayer!)
                previewLayer!.frame = self.bounds
                captureSession!.startRunning()
            }
             timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "stopcamera", userInfo: nil, repeats: true)
        }
        
    }
    func setFocusWithLensPosition(pos: CFloat) {
        let error: NSErrorPointer = nil
        do {
            try captureDevice!.lockForConfiguration()
        } catch let error1 as NSError {
            error.memory = error1
        }
        captureDevice!.setFocusModeLockedWithLensPosition(pos, completionHandler: nil)
        captureDevice!.unlockForConfiguration()
    }
    
    // return the camera device for a position
    func cameraDeviceForPosition(position:AVCaptureDevicePosition) -> AVCaptureDevice?
    {
        for device:AnyObject in AVCaptureDevice.devices() {
            if (device.position == position) {
                return device as? AVCaptureDevice;
            }
        }
        
        return nil
    }
    
    func stopcamera()
    {
        if  blnRun == true
        {
             captureSession!.stopRunning()
        }
        else
        {
             captureSession!.startRunning()
        }
        
    }



}
