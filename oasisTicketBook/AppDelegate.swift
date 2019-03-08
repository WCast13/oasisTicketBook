//
//  AppDelegate.swift
//  oasisTicketBook
//
//  Created by William Castellano on 1/12/19.
//  Copyright © 2019 WCTech. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		 print(Realm.Configuration.defaultConfiguration.fileURL!)
		
		return true
	}

	class func getAppDelegate() -> AppDelegate {
		return UIApplication.shared.delegate as! AppDelegate
	}
	
	func getDocDir() -> String {
		return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
	}
}

