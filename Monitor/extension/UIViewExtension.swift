//
//  UIViewExtension.swift
//  Monitor
//
//  Created by gaof on 2018/6/15.
//  Copyright © 2018年 gaof. All rights reserved.
//

import UIKit
import YetAnotherAnimationLibrary
import IBAnimatable
protocol TouchAnimProtocol {
    var tapAnimation: Bool { get set }
    func touchAnim(_ touches:Set<UITouch>)
    func touchAnimFinish()
}

class TouchAnimationView:AnimatableView,TouchAnimProtocol {
    open var tapAnimation = true

    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchAnim(touches)
    }
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        touchAnim(touches)
    }
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if tapAnimation {
            touchAnimFinish()
        }
    }
    open override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        super.touchesCancelled(touches!, with: event)
        if tapAnimation {
            touchAnimFinish()
        }
    }
    func touchAnimFinish() {
        yaal.scale.animateTo(1.0, stiffness: 150, damping: 7)
        yaal.rotationX.animateTo(0, stiffness: 150, damping: 7)
        yaal.rotationY.animateTo(0, stiffness: 150, damping: 7)
    }
    func touchAnim(_ touches:Set<UITouch>) {
        if let touch = touches.first, tapAnimation {
            var loc = touch.location(in: self)
            loc = CGPoint(x: loc.x.clamp(0, bounds.width), y: loc.y.clamp(0, bounds.height))
            loc = loc - bounds.center
            let rotation = CGPoint(x: -loc.y / bounds.height, y: loc.x / bounds.width)
            if #available(iOS 9.0, *) {
                let force = touch.maximumPossibleForce == 0 ? 1 : touch.force
                let rotation = rotation * (0.21 + force * 0.04)
                yaal.scale.animateTo(0.95 - force*0.01)
                yaal.rotationX.animateTo(rotation.x)
                yaal.rotationY.animateTo(rotation.y)
            } else {
                let rotation = rotation * 0.25
                yaal.scale.animateTo(0.94)
                yaal.rotationX.animateTo(rotation.x)
                yaal.rotationY.animateTo(rotation.y)
            }
        }
    }
}


