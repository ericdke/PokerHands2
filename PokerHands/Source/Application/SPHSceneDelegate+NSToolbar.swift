//
//  SPHSceneDelegate+NSToolbar.swift
//  PokerHands
//
//  Created by Eric Dejonckheere on 19/01/2022.
//  
//

import UIKit

#if targetEnvironment(macCatalyst)
import AppKit

extension SPHSceneDelegate: NSToolbarDelegate {
    
	func toolbarItems() -> [NSToolbarItem.Identifier] {
		return [] // [.toggleSidebar]
	}
	
	func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarItems()
	}
	
	func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
		return toolbarItems()
	}
	
	func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
		return NSToolbarItem(itemIdentifier: itemIdentifier)
	}
}
#endif
