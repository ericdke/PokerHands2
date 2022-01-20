//
//  SPHSceneDelegate.swift
//  PokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//  
//

import UIKit

class SPHSceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = scene as? UIWindowScene else {
			fatalError("Expected scene of type UIWindowScene but got an unexpected type")
		}
		window = UIWindow(windowScene: windowScene)
		
		if let window = window {
			window.rootViewController = SPHMainViewController()
			
#if targetEnvironment(macCatalyst)
            windowScene.sizeRestrictions?.minimumSize = CGSize(width: 800, height: 640)
            
			let toolbar = NSToolbar(identifier: NSToolbar.Identifier("SPHSceneDelegate.Toolbar"))
			toolbar.delegate = self
			toolbar.displayMode = .iconOnly
			toolbar.allowsUserCustomization = false
			
			windowScene.titlebar?.toolbar = toolbar
			windowScene.titlebar?.toolbarStyle = .unified
            

			
#endif
			
			window.makeKeyAndVisible()
		}
	}
}
