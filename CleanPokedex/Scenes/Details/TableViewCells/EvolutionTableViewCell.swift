//
//  EvolutionTableViewCell.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 07/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

final class EvolutionTableViewCell: UITableViewCell {
    // MARK: Abstract data
    private final class PokemonView: UIView {
        // MARK: View properties
        let codeLabel: UILabel = UILabel()
        let nameLabel: UILabel = UILabel()
        let pokemonImageView: UIImageView = UIImageView()
        let pokeballImageView: UIImageView = UIImageView()
        
        // MARK: Initialization methods
        override init(frame: CGRect) {
            super.init(frame: frame)
            initialConfiguration()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: Public methods
        func setup(pokemon: Details.SelectTab.ViewModel.Evolution.Pokemon) {
            codeLabel.text = pokemon.code
            nameLabel.text = pokemon.name
            pokemonImageView.kf.setImage(with: URL(string: pokemon.imageURL)!)
        }
        
        // MARK: Configuration methods
        private func initialConfiguration() {
            pokeballImageViewConfiguration()
            pokemonImageViewConfiguration()
            codeLabelConfiguration()
            nameLabelConfiguration()
        }
        
        private func pokeballImageViewConfiguration() {
            addSubview(pokeballImageView)
            pokeballImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                pokeballImageView.topAnchor.constraint(equalTo: topAnchor),
                pokeballImageView.widthAnchor.constraint(equalToConstant: 100),
                pokeballImageView.heightAnchor.constraint(equalToConstant: 100),
                pokeballImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                pokeballImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
            
            pokeballImageView.image = UIImage(named: "backgroundPokeball")
        }
        
        private func pokemonImageViewConfiguration() {
            pokeballImageView.addSubview(pokemonImageView)
            pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                pokemonImageView.widthAnchor.constraint(equalToConstant: 75),
                pokemonImageView.heightAnchor.constraint(equalToConstant: 75),
                pokemonImageView.centerYAnchor.constraint(equalTo: pokeballImageView.centerYAnchor),
                pokemonImageView.centerXAnchor.constraint(equalTo: pokeballImageView.centerXAnchor)
            ])
        }
        
        private func codeLabelConfiguration() {
            addSubview(codeLabel)
            codeLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                codeLabel.topAnchor.constraint(equalTo: pokeballImageView.bottomAnchor),
                codeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                codeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
            
            codeLabel.textAlignment = .center
            codeLabel.font = UIFont.boldSystemFont(ofSize: 12)
            codeLabel.textColor = UIColor(red: 176/255, green: 176/255, blue: 178/255, alpha: 1)
        }
        
        private func nameLabelConfiguration() {
            addSubview(nameLabel)
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                nameLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor)
            ])
            
            nameLabel.numberOfLines = 2
            nameLabel.textAlignment = .center
            nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
            nameLabel.textColor = UIColor(red: 23/255, green: 23/255, blue: 27/255, alpha: 1)
        }
    }
    
    // MARK: View properties
    private let reasonLabel: UILabel = UILabel()
    private let vectorImageView: UIImageView = UIImageView()
    private let evolveToStackView: UIStackView = UIStackView()
    private let initialPokemonView: PokemonView = PokemonView()
    private let evolvedPokemonView: PokemonView = PokemonView()
    
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
extension EvolutionTableViewCell {
    func setup(_ data: Details.SelectTab.ViewModel.Evolution.Data) {
        reasonLabel.text = data.reason
        initialPokemonView.setup(pokemon: data.initial)
        evolvedPokemonView.setup(pokemon: data.evolved)
    }
}

// MARK: Configuration methods
private extension EvolutionTableViewCell {
    func initialConfiguration() {
        cellConfiguration()
        initialPokemonViewConfiguration()
        evolvedPokemonViewConfiguration()
        evolveToStackViewConfiguration()
        vectorImageViewConfiguration()
        reasonLabelConfiguration()
    }
    
    func cellConfiguration() {
        selectionStyle = .none
    }
    
    func initialPokemonViewConfiguration() {
        contentView.addSubview(initialPokemonView)
        initialPokemonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            initialPokemonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            initialPokemonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            initialPokemonView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
    
    func evolvedPokemonViewConfiguration() {
        contentView.addSubview(evolvedPokemonView)
        evolvedPokemonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            evolvedPokemonView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            evolvedPokemonView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            evolvedPokemonView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    func evolveToStackViewConfiguration() {
        contentView.addSubview(evolveToStackView)
        evolveToStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            evolveToStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            evolveToStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            evolveToStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        evolveToStackView.spacing = 5
        evolveToStackView.axis = .vertical
        evolveToStackView.alignment = .center
    }
    
    func vectorImageViewConfiguration() {
        evolveToStackView.addArrangedSubview(vectorImageView)
        
        NSLayoutConstraint.activate([
            vectorImageView.widthAnchor.constraint(equalToConstant: 20),
            vectorImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        vectorImageView.image = UIImage(named: "vector")
    }
    
    func reasonLabelConfiguration() {
        evolveToStackView.addArrangedSubview(reasonLabel)
        
        reasonLabel.font = UIFont.boldSystemFont(ofSize: 12)
        reasonLabel.textColor = UIColor(red: 23/255, green: 23/255, blue: 27/255, alpha: 1)
    }
}

