//
//  EditRecordViewController.swift
//  Hamster
//
//  Created by Frank Cheng on 2019/5/21.
//  Copyright © 2019 Frank Cheng. All rights reserved.
//

import Foundation
import UIKit

class EditRecordViewController: UITableViewController {
    
    var record: Record!
    
    override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = record.simpleHost
        navigationItem.rightBarButtonItem = editButtonItem
        navigationController?.isToolbarHidden = true
        tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 1, height: 1)))
        view.backgroundColor = .groupTableViewBackground
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.visibleCells.forEach {
            if let recordCell = $0 as? EditRecordCell {
                recordCell.showEditField = editing
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EditRecordCell
        cell.showShareDialog()
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
