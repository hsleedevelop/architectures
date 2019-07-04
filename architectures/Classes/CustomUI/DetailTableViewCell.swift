//
//  DetailTableViewCell.swift
//  architectures
//
//  Created by HS Lee on 04/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import Foundation
import UIKit

final class DetailTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var detailLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = UIColor.darkText
            
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            self.contentView.addSubview($0)
            $0.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 20).isActive = true
        }
        
        detailLabel = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: 13)
            $0.textColor = UIColor.gray
            $0.numberOfLines = 0
            $0.lineBreakMode = .byTruncatingTail
            
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            self.contentView.addSubview($0)
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        }
    }
}
