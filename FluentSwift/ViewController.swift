//
//  ViewController.swift
//  FluentSwift
//
//  Created by Thanh Dang on 5/25/17.
//  Copyright © 2017 Thanh Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel().then {
            $0.frame = CGRect(x: 100, y: 100, width: 40, height: 100)
            $0.text = "Fluent Swift API"
            $0.sizeToFit()
            $0.backgroundColor = .green
            $0.border(sides: .bottom)
            $0.corner(radius: 8, sides: .all)
        }
        
        let testView = UIView().then {
            $0.frame = CGRect(x: 150, y: 150, width: 60, height: 100)
            $0.backgroundColor = .black
            $0.corner(radius: 8, sides: .all)
        }
        
        view.addSubview(label)
        view.addSubview(testView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc fileprivate func handleTap() {
        print(Device.name)
        print(Device.languageCode)
    }

}
