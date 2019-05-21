//
//  EditRecordViewController.swift
//  Hamster
//
//  Created by Frank Cheng on 2019/5/21.
//  Copyright © 2019 Frank Cheng. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class EditRecordCell: UITableViewCell {
    @IBInspectable var title: String!
    lazy var stackView: UIStackView = {
        let view = UIStackView().useAutolayout()
        view.axis = .horizontal
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel().useAutolayout()
        view.text = self.title
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 120)])
        return view
    }()

    override func awakeFromNib() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
        
        stackView.addArrangedSubview(titleLabel)
    }
}

class EditRecordViewController: UITableViewController {
    
    var record: Record!
    
    override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = record.simpleHost
    }
}

