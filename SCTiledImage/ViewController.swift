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
    
    @IBOutlet weak var minimapImageView: UIImageView!
    @IBOutlet var tiledImageScrollView: SCTiledImageScrollView!
    private var dataSource: ExampleTiledImageDataSource?
    var tiledImageScrollViewPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(scrollViewPanAction(_ :)))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTiledImageScrollView()
        tiledImageScrollViewPanGestureRecognizer.delegate = self
    }
    
    @objc func scrollViewPanAction (_ sender : UIPanGestureRecognizer){
        let velocity = sender.velocity(in: tiledImageScrollView)
        if abs(velocity.x) > abs(velocity.y) {
            velocity.x < 0 ? print("left") :  print("right")
        }
        else if abs(velocity.y) > abs(velocity.x) {
            velocity.y < 0 ? print("up") :  print("down")
        }
    }
    
    private func setupTiledImageScrollView() {
        let imageSize = CGSize(width: 9112, height: 4677)
        let tileSize = CGSize(width: 256, height: 256)
        let zoomLevels = 4
        
        dataSource = ExampleTiledImageDataSource(imageSize: imageSize, tileSize: tileSize, zoomLevels: zoomLevels)
        tiledImageScrollView.set(dataSource: dataSource!)
        dataSource?.requestBackgroundImage(completionHandler: { backgroundImage in
            self.minimapImageViewHeight.constant = (backgroundImage?.size.height)!/4
            self.minimapImageViewWidth.constant = (backgroundImage?.size.width)!/4
            self.minimapImageView.image = backgroundImage
            
            var currentView = UIView(frame: CGRect(x: 0, y: 0, width: (backgroundImage?.size.width)!/4, height: (backgroundImage?.size.height)!/4))
            currentView.layer.borderWidth = 2
            currentView.layer.borderColor = UIColor.yellow.cgColor
            
            self.minimapImageView.addSubview(currentView)
            self.tiledImageScrollView.addGestureRecognizer(self.tiledImageScrollViewPanGestureRecognizer)
        })
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
}
