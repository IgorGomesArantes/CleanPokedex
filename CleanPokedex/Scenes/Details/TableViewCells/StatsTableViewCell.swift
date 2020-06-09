//
//  StatsTableViewCell.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 07/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

final class StatsTableViewCell: UITableViewCell {
    // MARK: View properties
    let titleLabel: UILabel = UILabel()
    let valueLabel: UILabel = UILabel()
    let valueProgressView: UIProgressView = UIProgressView()
    
    // MARK: Initialization methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Overrided methods
extension StatsTableViewCell {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        valueProgressView.layer.cornerRadius = 2
    }
}

// MARK: Public methods
extension StatsTableViewCell {
    func setup(_ data: Details.SelectTab.ViewModel.Stats.Data) {
        titleLabel.text = data.key
        valueLabel.text = data.value
        valueProgressView.progress = data.valuePercent
        valueProgressView.progressTintColor = data.barColor
    }
}

// MARK: Configuration methods
private extension StatsTableViewCell {
    func initialConfiguration() {
        cellConfiguration()
        keyLabelConfiguration()
        valueLabelConfiguration()
        valueProgressViewConfiguration()
    }
    
    func cellConfiguration() {
        selectionStyle = .none
    }
    
    func keyLabelConfiguration() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 50),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 11)
        titleLabel.textColor = UIColor(red: 23/255, green: 23/255, blue: 27/255, alpha: 1)
    }
    
    func valueLabelConfiguration() {
        contentView.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueLabel.widthAnchor.constraint(equalToConstant: 30),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10)
        ])
        
        valueLabel.font = UIFont.systemFont(ofSize: 14)
        valueLabel.textColor = UIColor(red: 116/255, green: 116/255, blue: 118/255, alpha: 1)
    }
    
    func valueProgressViewConfiguration() {
        contentView.addSubview(valueProgressView)
        valueProgressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueProgressView.heightAnchor.constraint(equalToConstant: 4),
            valueProgressView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueProgressView.leadingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 10),
            valueProgressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
        
        valueProgressView.clipsToBounds = true
        valueProgressView.trackTintColor = .clear
    }
}

