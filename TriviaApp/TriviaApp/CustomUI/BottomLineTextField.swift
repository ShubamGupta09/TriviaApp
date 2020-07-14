//
//  BottomLineTextField.swift
//  Ewaah
//
//  Created by Shubam Gupta on 21/06/20.
//  Copyright © 2020 Shubam Gupta. All rights reserved.
//

import UIKit

class BottomLineTextField: UITextField {
    
    var lineView = UIView()
    var activeColorInternal: UIColor = .gray
    
    @IBInspectable
    var inactiveColor: UIColor = .lightGray {
        didSet {
            if !isFirstResponder {
                lineView.backgroundColor = inactiveColor
            }
        }
    }

    @IBInspectable
    var activeColor: UIColor = .gray {
        didSet {
            activeColorInternal = activeColor
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        lineView.backgroundColor = activeColorInternal
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        lineView.backgroundColor = inactiveColor
        return super.resignFirstResponder()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        lineView.frame = CGRect(x: CGFloat(0), y: self.frame.size.height-2, width: self.frame.size.width, height: CGFloat(1.0))
        
        lineView.backgroundColor = self.isFirstResponder ? activeColorInternal : inactiveColor
        
        self.addSubview(lineView)
    }
}
