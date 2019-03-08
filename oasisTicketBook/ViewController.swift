//
//  ViewController.swift
//  oasisTicketBook
//
//  Created by William Castellano on 1/12/19.
//  Copyright © 2019 WCTech. All rights reserved.
//

import UIKit
import RealmSwift

let realm = try! Realm()
let dateFormatter = DateFormatter()

var entries: Results<TicketEntry>!

let ticketTypesArray = ["", "GAD- Grounds", "Grounds- Friday", "Grounds- Saturday", "Grounds- Saturday", "GAD- 16th Green", "Cambria- Friday", "Cambria- Saturday", "Cambria- Sunday", "VIP Parking - Friday", "VIP Parking - Saturday", "VIP Parking - Sunday", "Clubhouse Parking"]

class ViewController: UIViewController {

	@IBOutlet weak var ticketType: UITextField!
	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var startNumber: UITextField!
	@IBOutlet weak var endNumber: UITextField!
	@IBOutlet weak var filledBy: UITextField!
	@IBOutlet weak var filterTableTextField: UITextField!
	
	@IBOutlet weak var ticketsTable: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		entries = realm.objects(TicketEntry.self)
		
		let ticketTypePicker = UIPickerView()
		let ticketTypePickerForTable = UIPickerView()
		
		ticketTypePicker.delegate = self
		ticketTypePickerForTable.delegate = self
		
		ticketTypePicker.tag = 1
		ticketTypePickerForTable.tag = 2
		
		ticketType.inputView = ticketTypePicker
		filterTableTextField.inputView = ticketTypePickerForTable
		
		ticketsTable.register(UINib(nibName: "TicketEntryTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
		
		dateFormatter.dateStyle = .short
		dateFormatter.timeStyle = .none
		
		let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
		view.addGestureRecognizer(tap)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	@IBAction func addEntry(_ sender: Any) {
		
		guard let ticketType = ticketType.text, ticketType != "" else { return }
		guard let name = name.text, name != "" else { return }
		guard let startNumber = Int(startNumber.text ?? ""), startNumber != 0 else { return }
		guard let endNumber = Int(endNumber.text ?? ""),endNumber != 0 else { return }
		guard let filledBy = filledBy.text, filledBy != "" else { return }
		
		let newEntry = TicketEntry()
		
		newEntry.date = Date()
		newEntry.ticketType = ticketType
		newEntry.name = name
		newEntry.startNumber = startNumber
		newEntry.endNumber = endNumber
		newEntry.numberOfTickets = endNumber - startNumber + 1
		newEntry.filledBy = filledBy
	
		do {
			try realm.write {
				realm.add(newEntry)
			}
		} catch {}
		
		print("Entry added")
		ticketsTable.reloadData()
	}

	@IBAction func filterTable(_ sender: Any) {
		guard let ticketType = filterTableTextField.text, ticketType != "" else { return }
		
		entries = realm.objects(TicketEntry.self).filter("ticketType == %@", ticketType).sorted(byKeyPath: "date")
		
		ticketsTable.reloadData()
	}
}

// MARK: - Table View Methods

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return entries.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TicketEntryTableViewCell
		
		if indexPath.row % 2 == 0 {
			cell.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
		} else {
			cell.backgroundColor = UIColor.white.withAlphaComponent(0.5)
		}
		
		let currentEntry: TicketEntry!
		currentEntry = entries[indexPath.row]
		
		let formattedDate = dateFormatter.string(from: currentEntry.date)
		
		cell.ticketType.text = currentEntry.ticketType
		cell.date.text = formattedDate
		cell.name.text = currentEntry.name
		cell.ticketNumber.text = "\(currentEntry.startNumber) - \(currentEntry.endNumber)"
		cell.quantity.text = "\(currentEntry.numberOfTickets)"
		cell.filledBy.text = currentEntry.filledBy
		
		return cell
	}
	
}

// MARK: - Picker View Methods

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return ticketTypesArray.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return ticketTypesArray[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
		if pickerView.tag == 1 {
			ticketType.text = ticketTypesArray[row]
		} else {
			filterTableTextField.text = ticketTypesArray[row]
		}
	}
}

// MARK: - Picker View Methods

