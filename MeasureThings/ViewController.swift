//
//  ViewController.swift
//  MeasureThings
//
//  Created by Charles Konkol on 2015-11-15.
//  Copyright © 2015 Chuck Konkol. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var rows: UITextField!
   
    @IBOutlet weak var btnLock: UIButton!
    @IBOutlet weak var txtDepth: UITextField!
    
    @IBOutlet weak var txtDistance: UITextField!
    
    
    @IBOutlet weak var paintCanvas: UIImageView!
     var stillImageOutput: AVCaptureStillImageOutput?
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    var count:Int = 0
    
    @IBAction func btnLock(sender: UIButton) {
       
        if  blnRun == false
        {
            btnLock.setTitle("UnFreeze", forState: .Normal)
            blnRun = true
        }
        else
        {
            btnLock.setTitle("Freeze", forState: .Normal)

            blnRun = false
        }
    }
    
     @IBOutlet var viewdb: PhotoView?
    
    @IBOutlet weak var ViewCopy: UIView!
    
    
    @IBOutlet weak var top: UILabel!
   // @IBOutlet weak var vdb: UIView!
    @IBOutlet weak var slider: UISlider!
     var bgImage: UIImageView?
    
    @IBOutlet weak var TrailerLength: UITextField!
    
    var slidevalue:CGFloat!
    
    @IBAction func slider(sender: UISlider) {
        // Do any additional setup after loading the view, typically from a nib.
        let tl:Float = 65
        slider.maximumValue = tl
        var currentValue = Float(sender.value)
        var y:CGFloat!
        
        var length:Float = Float(TrailerLength.text!)!
        var distance:Float?
        
        
       
           length  =  length / tl
        
        currentValue = currentValue * length
        
        distance = currentValue / Float(txtDepth.text!)!
        
        rows.text = ("\(Int(distance!))")
        txtDistance.text = "\(Int(currentValue))"
        
        
        
        if (slidevalue == 0)
        {
            
             slidevalue = bgImage!.frame.origin.y - (CGFloat(sender.value) * 0.1)
              self.bgImage!.frame = CGRect(x: bgImage!.frame.origin.x, y: slidevalue, width: 49, height: 40)
             print(slidevalue)
        
        }
        else
        {
             y = slidevalue - (CGFloat(sender.value) * 3.80)
              self.bgImage!.frame = CGRect(x: bgImage!.frame.origin.x, y: y, width: 49, height: 40)
             print(y)
        }
        
        
     
       
       
    }
    override func viewWillAppear(animated: Bool) {
      
     
    }
    
    @IBOutlet weak var Scrollview: UIScrollView!
    
   override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    TrailerLength.endEditing(true)
    txtDepth.endEditing(true)
    txtDistance.endEditing(true)
   }

    func DismissKeyboard(){
        //forces resign first responder and hides keyboard
        TrailerLength.endEditing(true)
        txtDepth.endEditing(true)
        txtDistance.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       blnRun=false
        //ViewCopy = viewdb
        slidevalue = 0
        // Do any additional setup after loading the view, typically from a nib.
        let tl:Float = 65 //Float(TrailerLength.text!)
        slider.maximumValue = tl
       //marker.
        // CGPointMake(0, btnBack.frame.origin.y)
        let orgY = self.top.frame.origin.y
        let orgx = (self.top.frame.width - 49)  / 2
        
        let image: UIImage = UIImage(named: "arrow.png")!
        bgImage = UIImageView(image: image)
        bgImage!.frame = CGRectMake(orgx,orgY,49,40)
      //  bgImage!.center = self.view.center
        self.view.addSubview(bgImage!)
        
         let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")

       self.view.center = self.view.center
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(CGImage: image.CGImage!)
    }
}

