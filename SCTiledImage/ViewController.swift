//
//  ViewController.swift
//  SCTiledImage
//
//  Created by Maxime POUWELS on 03/02/2017.
//  Copyright © 2017 siclo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var minimapImageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var minimapImageViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var minimapBackgroundView: UIView!
    @IBOutlet weak var minimapImageView: UIImageView!
    @IBOutlet var tiledImageScrollView: SCTiledImageScrollView!
    private var dataSource: ExampleTiledImageDataSource?
    private var tiledImageScrollViewPanGestureRecognizer: UIPanGestureRecognizer?
    
    private var currentView: UIView?
    private var minimapRatio: Double = 0.0
    
    private var minimap:Minimap?

    override func viewDidLoad() {
        super.viewDidLoad()
        tiledImageScrollViewPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(scollViewPanAction(_ :)))
        tiledImageScrollViewPanGestureRecognizer?.delegate = self
        setupTiledImageScrollView()
    }
    
    @objc func scollViewPanAction (_ sender : UIPanGestureRecognizer){
        minimapBackgroundView.isHidden = false
        var height = Double(tiledImageScrollView.visibleRect.height) / minimapRatio
        var width = Double(tiledImageScrollView.visibleRect.width) / minimapRatio
        let x = Double(tiledImageScrollView.visibleRect.origin.x) / minimapRatio
        let y = Double(tiledImageScrollView.visibleRect.origin.y) / minimapRatio
        
        if Double(minimapBackgroundView.frame.height) < height {
            height = Double(minimapBackgroundView.frame.height)
        }
        if Double(minimapBackgroundView.frame.width) < width {
            width = Double(minimapBackgroundView.frame.width)
        }
        
        if Double(tiledImageScrollView.visibleRect.origin.x) <= 0.0 && Double(tiledImageScrollView.visibleRect.origin.y) <= 0.0{
            currentView?.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        } else if Double(tiledImageScrollView.visibleRect.origin.x) > 0.0 && Double(tiledImageScrollView.visibleRect.origin.y) > 0.0 {
            currentView?.frame = CGRect(x: x, y: y, width: width, height: height)
        } else if Double(tiledImageScrollView.visibleRect.origin.x) > 0.0 && Double(tiledImageScrollView.visibleRect.origin.y) <= 0.0 {
            currentView?.frame = CGRect(x: x, y: 0.0, width: width, height: height)
        } else if Double(tiledImageScrollView.visibleRect.origin.x) <= 0.0 && Double(tiledImageScrollView.visibleRect.origin.y) > 0.0 {
            currentView?.frame = CGRect(x: 0.0, y: y, width: width, height: height)
        }
        
        if tiledImageScrollView.isTracking == false {
            minimapBackgroundView.isHidden = true
        }
        
        print(tiledImageScrollView.zoomScale)
    }
    
    private func setupTiledImageScrollView() {
        let imageSize = CGSize(width: 9112, height: 4677)
        let tileSize = CGSize(width: 256, height: 256)
        let zoomLevels = 2
        
        dataSource = ExampleTiledImageDataSource(imageSize: imageSize, tileSize: tileSize, zoomLevels: zoomLevels)
        tiledImageScrollView.set(dataSource: dataSource!)
        dataSource?.requestBackgroundImage(completionHandler: { backgroundImage in
            self.minimapImageViewHeight.constant = (backgroundImage?.size.height)!/4
            self.minimapImageViewWidth.constant = (backgroundImage?.size.width)!/4
            self.minimapImageView.image = backgroundImage
            
            self.currentView = UIView(frame: CGRect(x: 0, y: 0, width: (backgroundImage?.size.width)!/4, height: (backgroundImage?.size.height)!/4))
            self.currentView?.layer.borderWidth = 2
            self.currentView?.layer.borderColor = UIColor.yellow.cgColor
            
            self.minimapRatio = Double(imageSize.height / ((self.currentView?.bounds.height)!))
            
            self.minimapBackgroundView.addSubview(self.currentView!)
            self.tiledImageScrollView.addGestureRecognizer(self.tiledImageScrollViewPanGestureRecognizer!)
        })
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
    
        return true
    }
}
