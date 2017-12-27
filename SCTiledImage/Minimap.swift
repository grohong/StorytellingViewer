//
//  Minimap.swift
//  SCTiledImage
//
//  Created by Seong ho Hong on 2017. 12. 26..
//  Copyright © 2017년 siclo. All rights reserved.
//

import Foundation
import UIKit

class Minimap {
    var scrollView: SCTiledImageScrollView?
    
    var imageViewWidth: NSLayoutConstraint?
    var imageViewHeight: NSLayoutConstraint?
    
    var backgroundView: UIView?
    var backgroundImage: UIImage?
    var imageView: UIImageView?
    var viewPanGestureRecognizer: UIPanGestureRecognizer?
    
    private var currnetView: UIView?
    private var ratio: Double = 0.0
    
    init(imageViewWidth: NSLayoutConstraint, imageViewHeight: NSLayoutConstraint, backgroundView: UIView, backgroundImage: UIImage ,imageView: UIImageView, viewPanGestureRecognizer: UIPanGestureRecognizer, scrollView: SCTiledImageScrollView) {
        self.imageViewWidth = imageViewWidth
        self.imageViewHeight = imageViewHeight
        self.backgroundView = backgroundView
        self.backgroundImage = backgroundImage
        self.imageView = imageView
        self.viewPanGestureRecognizer = viewPanGestureRecognizer
        self.scrollView = scrollView
    }
}
