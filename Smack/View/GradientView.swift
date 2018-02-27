//
//  GradientView.swift
//  Smack
//
//  Created by Shameiz Rangwala on 2018-02-26.
//  Copyright © 2018 CodeSchool. All rights reserved.
//

import UIKit
@IBDesignable
class GradientView: UIView {
    @IBInspectable var topColor: UIColor = UIColor.blue{
        didSet{
            self.setNeedsLayout()
        }
    }
    @IBInspectable var bottomColor: UIColor = UIColor.green{
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientlayer =  CAGradientLayer()
        gradientlayer.colors = [topColor.cgColor,bottomColor.cgColor]
        gradientlayer.startPoint = CGPoint(x: 0, y: 0)
        gradientlayer.endPoint = CGPoint(x:1,y:1)
        gradientlayer.frame=self.bounds
        self.layer.insertSublayer(gradientlayer, at: 0)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
