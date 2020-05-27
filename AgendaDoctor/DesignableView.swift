//
//  DesignableView.swift
//  AgendaDoctor
//
//  Created by TecNM on 06/03/20.
//  Copyright © 2020 TecNM. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView{
    @IBInspectable var shadowColor: UIColor = UIColor.clear{
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
        
    }
    @IBInspectable var shadowRadious: CGFloat = 0 {
        didSet{
            layer.shadowRadius = shadowRadious
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat = 0{
        didSet{
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable var shadowOffsetY: CGFloat = 0{
        didSet{
            layer.shadowOffset.height = shadowOffsetY
        }
    }
}
