//
//  SPHMainViewController.swift
//  PokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//  
//

import UIKit
import SwiftUI

final class SPHMainViewController: UIViewController {
    
    let model = SPHDemoModel()

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "TexasPokerHands"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let v = SPHMainView()
        let childView = UIHostingController(rootView: v.environmentObject(model))
        addChild(childView)
        childView.view.frame = view.bounds
        view.addConstrained(subview: childView.view)
        childView.didMove(toParent: self)
    }
}

extension UIView {
    func addConstrained(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
