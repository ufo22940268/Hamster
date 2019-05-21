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
    @IBInspectable var editText: String!
    
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
    
    override var isEditing: Bool {
        didSet {
            if isEditing {
                label.isHidden = true
                editField.isHidden = false
            } else {
                label.isHidden = false
                editField.isHidden = true
            }
        }
    }
    
    lazy var rightContainer: UIView = {
        let view = UIView().useAutolayout()
        return view
    }()
    
    lazy var editField: UITextField = {
        let view = UITextField().useAutolayout()
        view.textAlignment = .right
        view.placeholder = editText
        view.text = editText
        return view
    }()
    
    lazy var label: UILabel = {
        let view = UILabel().useAutolayout()
        view.textColor = UIColor.lightGray
        view.textAlignment = .right
        view.text = editText
        return view
    }()

    override func awakeFromNib() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(rightContainer)
        
        rightContainer.addSubview(editField)
        editField.sameSizeAsParent()
        rightContainer.addSubview(label)
        label.sameSizeAsParent()
        
        isEditing = false
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func showShareDialog() {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.setTargetRect(CGRect(origin: CGPoint(x: center.x, y: 0), size: .zero), in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return ["copy:", "_share:"].contains(action.description)
    }
    
    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        board.string = editField.text
    }
    
}

class EditRecordViewController: UITableViewController {
    
    var record: Record!
    
    override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = record.simpleHost
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! EditRecordCell
        cell.showShareDialog()
    }
}

