//
//  Util.swift
//  WayTrackerApp
//
//  Created by Anna Zharkova on 10.04.2021.
//

import Foundation
import UIKit 
extension UIView {
    
    
    func prepare(type: AnyClass) {
        let nibName = String(describing: type)
        let view = loadFromNib(type: type, nibName: nibName)
        
        view.frame = bounds
        
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addSubview(view)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func prepare(type: AnyClass, nibName: String) {
        
        let view = loadFromNib(type: type, nibName: nibName)
        
        view.frame = bounds
        
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addSubview(view)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    private  func loadFromNib(type: AnyClass,  nibName: String ) -> UIView {
        
        let bundle = Bundle(for:type)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
}

