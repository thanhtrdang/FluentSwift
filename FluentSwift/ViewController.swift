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
        }
        
        view.addSubview(label)
        
    }

}
