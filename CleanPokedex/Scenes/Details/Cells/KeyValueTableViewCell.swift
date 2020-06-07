//
//  BasicTableViewCell.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 07/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

final class KeyValueTableViewCell: UITableViewCell {
    // MARK: View properties
    let keyLabel: UILabel = UILabel()
    let valueLabel: UILabel = UILabel()
    
    // MARK: Initialization methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public methods
extension KeyValueTableViewCell {
    func setup(data: (String, String)) {
        keyLabel.text = data.0
        valueLabel.text = data.1
    }
}

// MARK: Configuration methods
private extension KeyValueTableViewCell {
    func initialConfiguration() {
        cellConfiguration()
        keyLabelConfiguration()
        valueLabelConfiguration()
    }
    
    func cellConfiguration() {
        selectionStyle = .none
    }
    
    func keyLabelConfiguration() {
        contentView.addSubview(keyLabel)
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            keyLabel.widthAnchor.constraint(equalToConstant: 85),
            keyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            keyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            keyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        
        keyLabel.font = UIFont.boldSystemFont(ofSize: 12)
        keyLabel.textColor = UIColor(red: 23/255, green: 23/255, blue: 27/255, alpha: 1)
    }
    
    func valueLabelConfiguration() {
        contentView.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            valueLabel.leadingAnchor.constraint(equalTo: keyLabel.trailingAnchor, constant: 8),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20)
        ])
        
        valueLabel.font = UIFont.systemFont(ofSize: 14)
        valueLabel.textColor = UIColor(red: 176/255, green: 176/255, blue: 178/255, alpha: 1)
    }
}
