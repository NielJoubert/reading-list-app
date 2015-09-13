//
//  ShareViewController.swift
//  Share to Read
//
//  Created by Niel Joubert on 2015/09/12.
//  Copyright © 2015 ios-developers.io. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
	
	override func isContentValid() -> Bool {
		// Do validation of contentText and/or NSExtensionContext attachments here
		return true
	}
	
	override func didSelectPost() {
		// This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
		
		// Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
		
		for item: AnyObject in self.extensionContext!.inputItems {
			
			let inputItem = item as! NSExtensionItem
			
			for provider: AnyObject in inputItem.attachments! {
				
				let itemProvider = provider as! NSItemProvider

				if itemProvider.hasItemConformingToTypeIdentifier(kUTTypePropertyList as String) {
	
						itemProvider.loadItemForTypeIdentifier(kUTTypeItem as String, options: nil, completionHandler: { (data, error) in
	
//							if let dataDict = data as NSDictionary,
//								let a = dataDict!.objectForKey(NSExtensionJavaScriptPreprocessingResultsKey) as! NSDictionary {
//									
////									print("\(a.objec)")
//									
//							}
							
							
							
							
//							let jsDictionary = dataDict[NSExtensionJavaScriptPreprocessingResultsKey] as? [[NSObject:AnyObject]]// NSDictionary
							
	
	
	//						NSOperationQueue.mainQueue().addOperationWithBlock {
	//							if let strongImageView = weakImageView {
	//								strongImageView.image = image as? UIImage
	//							}
	//						}
						})
					}
				}
		}
	}
	
	override func configurationItems() -> [AnyObject]! {
		// To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
		return []
	}
	
}
