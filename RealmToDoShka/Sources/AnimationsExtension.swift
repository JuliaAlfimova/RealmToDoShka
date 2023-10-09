//
//  AnimationsExtension.swift
//  RealmToDoShka
//
//  Created by juliemoorled on 09.10.2023.
//

import UIKit

extension UIView {

    func createAnimation(scale: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scale, y: scale)
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.6,
                       options: .curveEaseInOut,
                       animations: { self.transform = CGAffineTransform.identity },
                       completion: nil)
    }


}
