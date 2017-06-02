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
            let title = NSMutableAttributedString(string: "Fluent") {
                    return TextAttributes().backgroundColor(.black)
                }
                .append("Swift") {
                    return TextAttributes().foregroundColor(.grey40)
                }
                .append("API") {
                    return TextAttributes().font(.mega)
                }
            
            $0.frame = CGRect(x: 100, y: 100, width: 40, height: 100)
            $0.attributedText = title
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
        
//        let x = NSMutableAttributedString(string: "blah")
//            .append("blon") {
//                return TextAttributes().backgroundColor(.green)
//            }
//            .append("blah") { () -> TextAttributes in
//                return TextAttributes().foregroundColor(.blue)
//            }
//        
        Async.background {
//            self.view.frame = .zero
//            print("background frame - \(self.view.frame)")
            
            self.view.sizeThatFits(.zero)
        }
        
    }
    
    @objc fileprivate func handleTap() {
        print(Device.name)
        print(Device.languageCode)
    }

}
