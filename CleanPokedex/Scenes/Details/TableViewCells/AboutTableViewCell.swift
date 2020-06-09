//
//  BasicTableViewCell.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 07/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

final class AboutTableViewCell: UITableViewCell {
    // MARK: View properties
    private let valueLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    
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
extension AboutTableViewCell {
    func setup(_ data: Details.SelectTab.ViewModel.About.Data) {
        valueLabel.text = data.text
        titleLabel.text = data.title
    }
}

// MARK: Configuration methods
private extension AboutTableViewCell {
    func initialConfiguration() {
        cellConfiguration()
        keyLabelConfiguration()
        valueLabelConfiguration()
    }
    
    func cellConfiguration() {
        selectionStyle = .none
    }
    
    func keyLabelConfiguration() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 85),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        titleLabel.textColor = UIColor(red: 23/255, green: 23/255, blue: 27/255, alpha: 1)
    }
    
    func valueLabelConfiguration() {
        contentView.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20)
        ])
        
        valueLabel.font = UIFont.systemFont(ofSize: 14)
        valueLabel.textColor = UIColor(red: 176/255, green: 176/255, blue: 178/255, alpha: 1)
    }
}
