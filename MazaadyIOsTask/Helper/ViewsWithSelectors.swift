//
//  ViewsWithSelectors.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/12/25.
//

import UIKit

public class ViewsWithSelectors{
    public var view :UIView = .init()
    public var action = Selector.init(stringLiteral: "")
    
    public init(_ v: UIView ,_ a: Selector) {
        view = v
        action = a
    }
    
}

extension UIView {
    func setViewsWithSelectors(_ views:[ViewsWithSelectors]) {
        for v in views {
            let singleTap = UITapGestureRecognizer(target: self, action: v.action)
            
            v.view.isUserInteractionEnabled = true
            v.view.addGestureRecognizer(singleTap)
        }
    }
}

extension UIViewController {
    func setViewsWithSelectors(_ views:[ViewsWithSelectors]) {
        for v in views {
            let singleTap = UITapGestureRecognizer(target: self, action: v.action)
            
            v.view.isUserInteractionEnabled = true
            v.view.addGestureRecognizer(singleTap)
        }
    }
}

