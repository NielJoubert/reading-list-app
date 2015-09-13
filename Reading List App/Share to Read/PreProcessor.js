//
//  PreProcessor.js
//  Reed Action NoUI
//
//  Created by Niel Joubert on 2015/09/13.
//  Copyright © 2015 ios-developers.io. All rights reserved.
//

var PreProcessor = function() {};

PreProcessor.prototype = {
	
	run: function(arguments) {
		arguments.completionFunction({ "url" : document.URL, "title" : document.title });
//		arguments.completionFunction({"URL": document.URL, "pageSource": document.documentElement.outerHTML, "title": document.title, "selection": window.getSelection().toString()});
	},
		
	finalize: function(arguments) {
		// This method is run after the native code completes.
		
	}
		
	};

var ExtensionPreprocessingJS = new PreProcessor
