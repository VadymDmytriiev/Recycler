//
//  RCLTakenCell.swift
//  Recycler
//
//  Created by Ostin Ostwald on 3/13/18.
//  Copyright © 2018 softserve.university. All rights reserved.
//

import UIKit

class RCLTakenCell: UITableViewCell {
   
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    
      var trashCan = TrashCan()
    
    func configureCell(forCan: TrashCan) {
        colorsSetup()
       self.trashCan = forCan
        switch trashCan.isFull {
        case true:
            viewContainer.backgroundColor = UIColor.Backgrounds.GrayLighter
            self.isUserInteractionEnabled = true
        case false:
            viewContainer.backgroundColor = UIColor.Backgrounds.GrayLight
            isUserInteractionEnabled = false
        }
        switch trashCan.type {
        case "plastic" :
            self.icon.image = #imageLiteral(resourceName: "trash_plastic")
        case "metal" :
            self.icon.image = #imageLiteral(resourceName: "trash_metal")
        case "organic" :
            self.icon.image = #imageLiteral(resourceName: "trash_organic")
        case "battaries" :
            self.icon.image = #imageLiteral(resourceName: "battery")
        default:
            self.icon.image = #imageLiteral(resourceName: "trash_other")
        }
        self.name.text = forCan.type
        self.location.text = forCan.address
        //        self.size.text = forCan.size
    }
    func colorsSetup() {
        name.textColor = UIColor.Font.White
        location.textColor = UIColor.Font.Gray
        size.textColor = UIColor.Font.White
        viewContainer.layer.cornerRadius = CGFloat.Design.CornerRadius
        
        backgroundColor = UIColor.Backgrounds.GrayDark
    }
    
}
