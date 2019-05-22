//
//  RecordCell.swift
//  Hamster
//
//  Created by Frank Cheng on 2019/5/16.
//  Copyright © 2019 Frank Cheng. All rights reserved.
//

import UIKit
import RealmSwift

class Record: Object {
    @objc dynamic var host: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var password: String = ""

    var simpleHost: String {
        return host.replacingOccurrences(of: #"(.+\.)?(.+\..+)"#, with: "$2", options: .regularExpression)
    }
    
    func capitalImage(on size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer.init(size: size).image { context in
            let path = UIBezierPath(rect: CGRect(origin: .zero, size: size))
            UIColor.gray.setFill()
            path.fill()

            let label = UILabel(frame: CGRect(origin: .zero, size: size))
            label.text = capitalCharacter
            label.textColor = .white
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.layer.render(in: context.cgContext)
        }
    }
    
    var capitalCharacter: String {
        if let first = host.first {
            return String([first])
        } else {
            return ""
        }
    }
}

class RecordCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        imageView?.layer.cornerRadius = 4
        imageView?.clipsToBounds = true        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        backgroundColor = selected ? UIColor.lightGray : .clear
    }

}
