//
//  UIView+Extensions.swift
//  Test App
//
//  Created by Matajar on 14/09/21.
//

import UIKit
extension UIView {
    
    func setRoundedCorners(){
        cornerRadius = frame.height / 2
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundTopCorners(radius: CGFloat = 10) {
       
          self.clipsToBounds = true
          self.layer.cornerRadius = radius
          if #available(iOS 11.0, *) {
              self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
          } else {
              self.roundCorners(corners: [.topLeft, .topRight], radius: radius)
          }
      }

    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor:layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat{
        get {
            return layer.shadowRadius
        }
        set {
            if(shadowRadius != 0)
            {
                layer.masksToBounds = false
                layer.shadowColor = shadowColor
                layer.shadowOffset = shadowOffset
                layer.shadowOpacity = shadowOpacity
                layer.shadowRadius = newValue
            }
        }
    }
    
    @IBInspectable
    var shadowColor: CGColor{
        get {
            return UIColor(red:0.11, green:0.12, blue:0.17, alpha:1.0).cgColor
        }
        set {
            if(shadowOpacity != 0)
            {
                layer.shadowColor = newValue
            }
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float{
        get {
            return 0.3
        }
        set {
            if(shadowOpacity != 0)
            {
                layer.shadowOpacity = newValue
            }
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize{
        get {
            return CGSize.init(width: 0, height: 3)
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    
    var X: CGFloat{
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var Y: CGFloat{
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
}
struct Line {
    let strokeWidth: Float
    let color: UIColor
    var points: [CGPoint]
}

class Canvas: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView?
    
    private var lineArray: [[CGPoint]] = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scrollView?.isScrollEnabled = false
        
        // 2
        guard let touch = touches.first else { return }
        let firstPoint = touch.location(in: self)
        
        // 3
        lineArray.append([CGPoint]())
        lineArray[lineArray.count - 1].append(firstPoint)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        scrollView?.isScrollEnabled = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 4
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)
        lineArray[lineArray.count - 1].append(currentPoint)
        setNeedsDisplay()
    }
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        draw(inContext: context)
    }
    
    func draw(inContext context: CGContext) {
        
        // 2
        context.setLineWidth(5)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineCap(.round)
        
        // 3
        for line in lineArray {
            
            // 4
            guard let firstPoint = line.first else { continue }
            context.beginPath()
            context.move(to: firstPoint)
            
            // 5
            for point in line.dropFirst() {
                context.addLine(to: point)
            }
            context.strokePath()
        }
    }
    
    func resetDrawing() {

        // 1
        lineArray = []
        setNeedsDisplay()
    }

    func exportDrawing() -> UIImage? {

        // 2
        UIGraphicsBeginImageContext(frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // 3
        draw(inContext: context)
        
        // 4
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
