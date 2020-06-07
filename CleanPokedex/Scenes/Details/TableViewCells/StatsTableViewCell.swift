//
//  StatsTableViewCell.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 07/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {
    // MARK: View properties
    let keyLabel: UILabel = UILabel()
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
    func setup(stats: Details.ShowTabInformations.ViewModel.Stats) {
        keyLabel.text = stats.key
        valueLabel.text = stats.value
        valueProgressView.progress = stats.valuePercent
        valueProgressView.progressTintColor = UIColor.getPokemonColor(withType: stats.mainType)
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
        contentView.addSubview(keyLabel)
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            keyLabel.widthAnchor.constraint(equalToConstant: 50),
            keyLabel.heightAnchor.constraint(equalToConstant: 25),
            keyLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            keyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            keyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        
        keyLabel.font = UIFont.systemFont(ofSize: 11)
        keyLabel.textColor = UIColor(red: 23/255, green: 23/255, blue: 27/255, alpha: 1)
    }
    
    func valueLabelConfiguration() {
        contentView.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueLabel.widthAnchor.constraint(equalToConstant: 30),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: keyLabel.trailingAnchor, constant: 10)
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

