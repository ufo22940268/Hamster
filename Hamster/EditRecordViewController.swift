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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EditRecordCell
        cell.showShareDialog()
    }
}

