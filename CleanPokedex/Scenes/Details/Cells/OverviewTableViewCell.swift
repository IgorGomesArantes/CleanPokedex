//
//  DescriptionTableViewCell.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 07/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

final class OverviewTableViewCell: UITableViewCell {
    // MARK: View properties
    let overviewLabel: UILabel = UILabel()
    
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
extension OverviewTableViewCell {
    func setup(overview: String) {
        overviewLabel.text = overview
    }
}

// MARK: Configuration methods
private extension OverviewTableViewCell {
    func initialConfiguration() {
        cellConfiguration()
        overviewLabelConfiguration()
    }
    
    func cellConfiguration() {
        selectionStyle = .none
    }
    
    func overviewLabelConfiguration() {
        contentView.addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
        
        overviewLabel.numberOfLines = 0
        overviewLabel.font = UIFont.systemFont(ofSize: 14)
        overviewLabel.textColor = UIColor(red: 176/255, green: 176/255, blue: 178/255, alpha: 1)
    }
}
