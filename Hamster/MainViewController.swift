//
//  ViewController.swift
//  Hamster
//
//  Created by Frank Cheng on 2019/5/15.
//  Copyright © 2019 Frank Cheng. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var records: [Record]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        records = [Record(host: "v2ex.com", url: "v2ex.com/detail")]
        tableView.register(RecordCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 1)))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecordCell
        let record = records[indexPath.row]
        cell.textLabel?.text = record.host
        cell.detailTextLabel?.text = record.url
        let imageSize = CGRect(origin: .zero, size: CGSize(width: cell.bounds.height, height: cell.bounds.height)).insetBy(dx: 8, dy: 8).size
        cell.imageView?.image = record.capitalImage(on: imageSize)
        return cell
    }
    
    
}

