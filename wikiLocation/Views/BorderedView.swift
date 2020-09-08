//
//  BorderedView.swift
//  Rabo
//
//  Created by Kostiantyn Gorbunov on 25/10/2019.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

class BorderedView: UIView {

    override class var layerClass: AnyClass {
        return BorderLayer.self
    }

    var borderSides: BorderLayer.Side {
        get {
            return borderLayer.sides
        }
        set {
            borderLayer.sides = newValue
        }
    }

    var borderColor: CGColor? {
        get {
            return borderLayer.borderColor
        }
        set {
            borderLayer.borderColor = newValue
            borderLayer.setNeedsDisplay()
        }
    }

    private var borderLayer: BorderLayer {
        return self.layer as! BorderLayer
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()

        if let window = window {
            borderLayer.contentsScale = window.screen.scale
            borderLayer.setNeedsDisplay()
        }
    }
}
