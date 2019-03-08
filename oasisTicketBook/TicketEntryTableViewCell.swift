//
//  TicketEntryTableViewCell.swift
//  oasisTicketBook
//
//  Created by William Castellano on 1/12/19.
//  Copyright © 2019 WCTech. All rights reserved.
//

import UIKit

class TicketEntryTableViewCell: UITableViewCell {

	@IBOutlet weak var ticketType: UILabel!
	@IBOutlet weak var date: UILabel!
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var ticketNumber: UILabel!
	@IBOutlet weak var quantity: UILabel!
	@IBOutlet weak var filledBy: UILabel!
	
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
