//
//  ViewController.swift
//  MeasureThings
//
//  Created by Charles Konkol on 2015-11-15.
//  Copyright © 2015 Chuck Konkol. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

extension UIImageView {
    var rotation: Double {
        let radians = self.layer.valueForKeyPath("transform.rotation.z") as! Double
        return radians
    }
    
    var scale: Double {
        let scale = self.layer.valueForKeyPath("transform.scale.x") as! Double
        return scale
    }
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var slider: UISlider!
     var bgImage: UIImageView?
    @IBOutlet weak var txtDistance: UITextField!
    @IBOutlet weak var marker: UIImageView!
    @IBOutlet weak var TrailerLength: UITextField!
    var slidevalue:CGFloat!
    
    @IBAction func slider(sender: UISlider) {
        // Do any additional setup after loading the view, typically from a nib.
        let tl = Float(TrailerLength.text!)
        slider.maximumValue = tl!
        var currentValue = Int(sender.value)
        var y:CGFloat!
        txtDistance.text = "\(currentValue)"
        
        if (slidevalue == 0)
        {
            
             slidevalue = bgImage!.frame.origin.y - (CGFloat(sender.value) * 0.25)
              self.bgImage!.frame = CGRect(x: bgImage!.frame.origin.x, y: slidevalue, width: 49, height: 40)
             print(slidevalue)
        
        }
        else
        {
             y = slidevalue - (CGFloat(sender.value) * 1.9)
              self.bgImage!.frame = CGRect(x: bgImage!.frame.origin.x, y: y, width: 49, height: 40)
             print(y)
        }
        
        
     
       
       
    }
    override func viewWillAppear(animated: Bool) {
      
     
    }
   
    @IBAction func btnChange(sender: UIButton) {
        
        print("Take picture")
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            self.displayImageSelectionUIWithSourceType(UIImagePickerControllerSourceType.Camera)
        } else {
            self.displayImageSelectionUIWithSourceType(UIImagePickerControllerSourceType.PhotoLibrary)
        }
        // self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func displayImageSelectionUIWithSourceType(sourceType: UIImagePickerControllerSourceType) {
        let imageSelectionUI = UIImagePickerController()
        imageSelectionUI.delegate = self
        imageSelectionUI.sourceType = sourceType
        imageSelectionUI.mediaTypes = [kUTTypeImage as String]
        imageSelectionUI.allowsEditing = false
        
        self.presentViewController(imageSelectionUI, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var viewdb: UIView!
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        print("Image selected")
        takephoto.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker:UIImagePickerController)
    {
        print("No image selected")
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func HandlePinch(sender: UIPinchGestureRecognizer) {
        takephoto.transform = CGAffineTransformScale(self.takephoto.transform, sender.scale, sender.scale)
        sender.scale = 1
    }
    
    @IBAction func HandleRotation(sender: UIRotationGestureRecognizer) {
        
//        if sender.state == UIGestureRecognizerState.Began {
//            setAnchorPointToCenterOfGestureRecognizer(sender)
//        }
//        
//        takephoto.transform = CGAffineTransformRotate(takephoto.transform, sender.rotation)
//        sender.rotation = 0
        
    }
    
    @IBAction func HandlePan(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(viewdb)
        if let view = viewdb {
            viewdb.center = CGPoint(x:viewdb.center.x + translation.x,
                y:viewdb.center.y + translation.y)
        }
        sender.setTranslation(CGPointZero, inView: viewdb)
    }
    @IBOutlet weak var takephoto: UIImageView!

    @IBOutlet weak var layouts: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        slidevalue = 0
        // Do any additional setup after loading the view, typically from a nib.
        let tl = Float(TrailerLength.text!)
        slider.maximumValue = tl!
       //marker.
        let orgY = CGRectGetMaxY(viewdb.frame)
        let orgx = self.takephoto.center.x
        //self.marker.center.y -= view.bounds.height
        //marker.center.y = orgY
        //marker.center.x = orgx
        
        let image: UIImage = UIImage(named: "arrow.png")!
        bgImage = UIImageView(image: image)
        bgImage!.frame = CGRectMake(orgx,orgY,49,40)
        self.view.addSubview(bgImage!)

       
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setAnchorPointToCenterOfGestureRecognizer(recognizer: UIGestureRecognizer) {
        let rView = viewdb
        let locationInView = recognizer.locationInView(rView)
        _ = recognizer.locationInView(rView.superview)
        
        rView.layer.anchorPoint = CGPoint(x: locationInView.x / rView.bounds.width, y: locationInView.y / rView.bounds.height)
        
        //        rView.center = locationInSuperview
        
    }

}

