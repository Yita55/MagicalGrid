//
//  ViewController.swift
//  MagicalGrid
//
//  Created by James Rochabrun on 4/17/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class MagicGridVC: UIViewController {
    
    let numberOfColumsPerRow: Int = 15
    var widthOfCell: CGFloat {
        return view.frame.size.width / CGFloat(numberOfColumsPerRow)
    }
    var cells = [String: UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        for y in 0...30 {
            for x in 0...numberOfColumsPerRow  {
                
                let cellView = UIView()
                cellView.layer.borderColor = randomColor().cgColor
                cellView.layer.borderWidth = 1.0
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: CGFloat(x) * widthOfCell, y: CGFloat(y) * widthOfCell , width: widthOfCell, height: widthOfCell)
                view.addSubview(cellView)
                
                let key = "\(x)|\(y)"
                cells[key] = cellView
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    func handlePan(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)

        //get the column and row location
        let x = Int(location.x / widthOfCell)
        let y = Int(location.y / widthOfCell)
        
        let key = "\(x)|\(y)"

        let cellView = cells[key]
        cellView?.backgroundColor = .white
       
        //MARK: ineficient way to do
        /*
        for subview in view.subviews {
            if subview.frame.contains(location) {
                subview.backgroundColor = .black
            }
        }
         */
    }
    
    func randomColor() -> UIColor {
        
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
        
    }
}
