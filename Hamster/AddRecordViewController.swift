//
//  AddRecordViewController.swift
//  Hamster
//
//  Created by Frank Cheng on 2019/5/16.
//  Copyright © 2019 Frank Cheng. All rights reserved.
//

import UIKit
import AuthenticationServices
import RealmSwift

class AddRecordViewController: UITableViewController {
    
    lazy var doneBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone))
        return item
    }()
    
    lazy var cancelBarButtonItem: UIBarButtonItem = {
        var item = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancel))
        return item
    }()
    
    @IBOutlet weak var hostField: URLAddField!
    @IBOutlet weak var usernameField: NormalAddField!
    @IBOutlet weak var passwordField: NormalAddField!
    var validators: [Validator] {
        return [hostField, usernameField, passwordField]
    }
    
    var isFillAll: Bool! {
        didSet {
            doneBarButtonItem.isEnabled = isFillAll
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.isToolbarHidden = false
        self.clearsSelectionOnViewWillAppear = true
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let footerView = UIView()
        view.backgroundColor = .groupTableViewBackground
        tableView.tableFooterView = footerView
        isEditing = false
        isFillAll = false
        
        self.navigationItem.rightBarButtonItem = doneBarButtonItem
        self.navigationItem.leftBarButtonItem = cancelBarButtonItem
    }
    
    
    @objc func onDone() {
        guard let host = hostField.text, let password = passwordField.text, let username = usernameField.text else { return }
        let serviceIdentifier = ASCredentialServiceIdentifier(identifier: hostField.text!, type: .domain)
        let passwordIdentifier = ASPasswordCredentialIdentity(serviceIdentifier: serviceIdentifier, user: usernameField.text!, recordIdentifier: passwordField.text)
        ASCredentialIdentityStore.shared.saveCredentialIdentities([passwordIdentifier]) {
            (_, _) in
            print("dismiss")
            let record = Record()
            record.host = host
            record.url = host
            record.username = username
            record.password = password
            let realm = try! Realm()
            try! realm.write {
                realm.add(record)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func onCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onEditFieldChanged(_ sender: Any) {
        isFillAll = validators.allSatisfy { $0.validate() }
    }
}


