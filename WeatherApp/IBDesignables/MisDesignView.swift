//
//  MisDesignView.swift
//  WeatherApp
//
//  Created by Debhora D Souza on 17/11/20.
//


import UIKit



@IBDesignable class MisDesignView: UIView {
    private var gradient: CAGradientLayer?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        installGradient()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        installGradient()
    }
    
    override var frame: CGRect {
        didSet {
            updateGradient()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // this is crucial when constraints are used in superviews
        updateGradient()
    }
    
    
    
    private func createGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        return gradient
    }
    
    private func installGradient() {
        // if there's already a gradient installed on the layer, remove it
        if let gradient = self.gradient {
            gradient.removeFromSuperlayer()
        }
        let gradient = createGradient()
        self.layer.addSublayer(gradient)
        self.gradient = gradient
    }
    
    
    
    
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var clipBounds: Bool = false {
        didSet {
            self.clipsToBounds = clipBounds
        
        }
    }
    
    @IBInspectable var maskBounds: Bool = false {
        didSet {
            self.layer.masksToBounds = maskBounds

        }
    }
    
    
    
    
        @IBInspectable var borderWidth: CGFloat = 0.0 {
            didSet {
                layer.borderWidth = borderWidth
            }
        }
    
        @IBInspectable var borderColor: UIColor = UIColor.clear {
            didSet {
                layer.borderColor = borderColor.cgColor
            }
        }
    
        @IBInspectable var shadowColor: UIColor = UIColor.clear{
            didSet {
                layer.shadowColor = shadowColor.cgColor
            }
        }
    
        @IBInspectable var shadowOpacity: CGFloat = 0 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
            }
        }
    
        @IBInspectable var shadowRadius: CGFloat = 0.0 {
            didSet {
                layer.shadowRadius = shadowRadius
            }
        }
    
        @IBInspectable var shadowOffset: CGSize = CGSize() {
            didSet {
                layer.shadowOffset = shadowOffset
            }
        }
    
    
    
        @IBInspectable var startColor: UIColor = UIColor.clear {
            didSet {
                updateGradient()
            }
        }
        @IBInspectable var endColor: UIColor = UIColor.clear {
            didSet {
                updateGradient()
            }
        }



        @IBInspectable var isHorizontal: Bool = true {
            didSet {
                updateGradient()
            }
        }
//
//
        private func updateGradient(){

            let colors:Array = [startColor.cgColor, endColor.cgColor]
            gradient?.colors = colors
            
            
                
            if (isHorizontal){
                gradient?.endPoint = CGPoint(x: 1, y: 0)
            }else{
                gradient?.endPoint = CGPoint(x: 0, y: 1)
            }
            
            gradient?.frame = self.bounds


            
            
//            self.setNeedsDisplay()
            
        }
    
  


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
