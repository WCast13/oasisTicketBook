//
//  TicketEntry.swift
//  oasisTicketBook
//
//  Created by William Castellano on 1/12/19.
//  Copyright © 2019 WCTech. All rights reserved.
//

import Foundation
import RealmSwift

class TicketEntry: Object {
	
	@objc dynamic var date: Date!
	@objc dynamic var ticketType: String!
	@objc dynamic var name: String!
	@objc dynamic var startNumber = 0
	@objc dynamic var endNumber = 0
	@objc dynamic var numberOfTickets = 0
	@objc dynamic var filledBy: String!
	
}
