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
		
		for item: AnyObject in self.extensionContext!.inputItems {
			
			let inputItem = item as! NSExtensionItem
			
			for provider: AnyObject in inputItem.attachments! {
				
				let itemProvider = provider as! NSItemProvider
				
				if itemProvider.hasItemConformingToTypeIdentifier(kUTTypePropertyList as String) {
					
					itemProvider.loadItemForTypeIdentifier(kUTTypeItem as String, options: nil, completionHandler: { (data, error) in
						
						if let dataDict = data as! NSDictionary? {
							
							if let jsValueDict = dataDict[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary? {

								// Article url
								let urlString = jsValueDict["url"] as! String
								// Article title
								let titleString = jsValueDict["title"] as! String
								// User entered text in share dialog
								let userText = self.contentText
								// Favicon
								var faviconData: NSData = NSData()
								
								// Set default image
								if let image = UIImage(named: "favicon"),
									let data = UIImagePNGRepresentation(image) {
										faviconData = data
								}
								
								print("URL       = \(urlString)")
								print("Title     = \(titleString)")
								print("UserText  = \(userText)")
								
								
								if let url = NSURL(string: urlString),
									let domain = url.host,
									let faviconURL = NSURL(string: "https://www.google.com/s2/favicons?domain=\(domain)") {
										
										dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
											
											if let data = NSData(contentsOfURL: faviconURL) {
												faviconData = data
											}
											
											print("ImageData = \(faviconData)")
											
										}
										
										/*********************************************

										Perform parse call to save article to backend

										**********************************************/
										
										
										/*
										let session = NSURLSession.sharedSession()
										
										let dataTask = session.dataTaskWithURL(faviconURL, completionHandler: { (data, response, error) -> Void in

											if (error != nil) {
												print(data)
											}
										})
										
										dataTask.resume()
										*/
										
										
								}
								self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
							}
							
						}
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
