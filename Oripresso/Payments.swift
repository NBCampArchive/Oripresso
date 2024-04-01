//
//  Payments.swift
//  Oripresso
//
//  Created by 이시안 on 4/1/24.
//

import Foundation
import UIKit

class Payments: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myImage = UIImage(named: "영수증")
        myImage?.layer.shadowColor = UIColor.black.cgColor
        myImage?.layer.shadowOpacity = 1
        myImage?.layer.shadowOffset = CGSize.zero
        myImage?.layer.shadowRadius = 10
        myImage?.layer.shadowPath = UIBezierPath(rect: myImage?.bounds ?? CGRect.zero).cgPath
        myImage?.layer.shouldRasterize = false
        myImage?.layer.cornerRadius = 10
        myImage?.clipsToBounds = true
    }
}
