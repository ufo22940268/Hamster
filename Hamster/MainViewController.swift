//
//  ViewController.swift
//  Hamster
//
//  Created by Frank Cheng on 2019/5/15.
//  Copyright © 2019 Frank Cheng. All rights reserved.
//

import UIKit
import AuthenticationServices
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var recordMap: Dictionary<String, [Record]>!
    var records: Results<Record>! {
        didSet {
            recordMap = Dictionary(grouping: records, by: {$0.capitalCharacter})
        }
    }
    
    lazy var addButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAdd))
        return item
    }()
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        print("editing: \(editing)")
        if editing {
            navigationItem.leftBarButtonItem = nil
        } else {
            navigationItem.leftBarButtonItem = addButtonItem
        }
        tableView.setEditing(editing, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Hamster"
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = addButtonItem

        tableView.register(RecordCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 1)))
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        let realm = try! Realm()
        records = realm.objects(Record.self)
        tableView.reloadData()
    }
    
    @objc func onAdd() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "add") else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        navigationController?.view.semanticContentAttribute = .forceLeftToRight
//        navigationController?.pushViewController(vc, animated: true)
        present(vc, animated: true, completion: nil)
//        navigationController?.present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recordMap = recordMap else { return 0 }
        let title = sectionTitles[section]
        return recordMap[title]!.count
    }
    
    func getRecord(indexPath: IndexPath) -> Record {
        let title = sectionTitles[indexPath.section]
        return recordMap[title]![indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecordCell
        let record = getRecord(indexPath: indexPath)
        cell.textLabel?.text = record.host
        cell.detailTextLabel?.text = record.url
        let imageSize = CGRect(origin: .zero, size: CGSize(width: cell.bounds.height, height: cell.bounds.height)).insetBy(dx: 8, dy: 8).size
        cell.imageView?.image = record.capitalImage(on: imageSize)
        return cell
    }
    
    var sectionTitles: [String] {
        guard let records = records else { return [] }
        return Array(Set(records.map { $0.capitalCharacter })).sorted()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}

