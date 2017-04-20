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
    var selectedCell: UIView?

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

        guard let cellView = cells[key] else { return }
        view.bringSubview(toFront: cellView)
        
        //1 - check if the selected cell is no longer the cell touched
        if selectedCell != cellView {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            })
        }
        
        //2 - set the selected cell with the cellView
        selectedCell = cellView
        
        //3 perform zoom
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        })
        
        //4 perform action when gesture end
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cellView.layer.transform = CATransform3DIdentity
            })
        }
        
       
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
