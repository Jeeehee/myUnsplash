//
//  UIView + Extension.swift
//  myUnsplash
//
//  Created by Jihee hwang on 2022/12/09.
//

import UIKit

extension UIView {
    func addTopBorder(with color: UIColor?, _ borderWidth: CGFloat) {
        let border = UIView()
        
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.width, height: borderWidth)
        
        addSubview(border)
    }
}
