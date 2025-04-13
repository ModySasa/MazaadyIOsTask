//
//  StringSize.swift
//  MazaadyIOsTask
//
//  Created by Moha on 4/13/25.
//

import UIKit

extension String {
    func size(with font: UIFont) -> CGSize {
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttribute)
        return size
    }
}
