//
//  EditRecordViewController.swift
//  Hamster
//
//  Created by Frank Cheng on 2019/5/21.
//  Copyright © 2019 Frank Cheng. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class EditRecordViewController: UITableViewController {
    
    var record: Record!
    lazy var realm: Realm = {
       return try! Realm()
    }()
    
    @IBOutlet weak var usernameField: EditRecordCell!
    @IBOutlet weak var passwordField: EditRecordCell!
    @IBOutlet weak var hostLabel: UILabel!
    
    override func viewDidLoad() {
        if isInitial() {
            record = (try! Realm()).objects(Record.self).first!
        }
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = record.simpleHost
        navigationItem.rightBarButtonItem = editButtonItem
        navigationController?.isToolbarHidden = true
        tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 1, height: 1)))
        view.backgroundColor = .groupTableViewBackground
        
        usernameField.editText = record.username
        passwordField.editText = record.password
        hostLabel.text = record.host
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.visibleCells.forEach {
            if let recordCell = $0 as? EditRecordCell {
                recordCell.showEditField = editing
            }
        }
        
        if !editing {
            saveChanges()
        }
    }
    
    func saveChanges() {
        guard let username = usernameField.editField.text, let password = passwordField.editField.text else {
            return
        }
        
        try! realm.write {
            self.record.username = username
            self.record.password = password
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cell = tableView.cellForRow(at: indexPath) as! EditRecordCell
            cell.showShareDialog()
        } else {
            super.tableView(tableView, didSelectRowAt: indexPath)
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        } else {
            return true
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && editingStyle == .delete {
            try! realm.write {
                realm.delete(record)
            }
            navigationController?.popViewController(animated: true)
        }
    }
}
