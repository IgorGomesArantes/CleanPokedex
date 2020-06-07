//
//  PokemonTableViewCell.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 04/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit
import Kingfisher

final class PokemonTableViewCell: UITableViewCell {
    // MARK: View properties
    private let codeLabel: UILabel = UILabel()
    private let nameLabel: UILabel = UILabel()
    private let containerView: UIView = UIView()
    private let tagsStackView: UIStackView = UIStackView()
    private let pokemonImageView: UIImageView = UIImageView()
    private let pokeballImageView: UIImageView = UIImageView()
    private let backgroundDetailImageView: UIImageView = UIImageView()
 
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
extension PokemonTableViewCell {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        roundContainerCorners()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeTags()
    }
}

// MARK: Public methods
extension PokemonTableViewCell {
    func setup(pokemon: Home.FetchPokemons.ViewModel.DisplayedPokemon) {
        setupTags(pokemon.types)
        codeLabel.text = pokemon.code
        nameLabel.text = pokemon.name
        pokemonImageView.kf.setImage(with: URL(string: pokemon.imageURL)!)
        containerView.backgroundColor = UIColor.getPokemonBackgroundColor(withType: pokemon.mainType)
    }
}

// MARK: Configuration methods
private extension PokemonTableViewCell {
    func initialConfiguration() {
        cellConfiguration()
        containerViewConfiguration()
        pokeballImageViewConfiguration()
        pokemonImageViewConfiguration()
        codeLabelConfiguration()
        nameLabelConfiguration()
        backgroundDetailImageViewConfiguration()
        tagsStackViewConfiguration()
    }
    
    func cellConfiguration() {
        selectionStyle = .none
    }
    
    func containerViewConfiguration() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 115),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
    }
    
    func pokeballImageViewConfiguration() {
        containerView.addSubview(pokeballImageView)
        pokeballImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokeballImageView.widthAnchor.constraint(equalToConstant: 130),
            pokeballImageView.heightAnchor.constraint(equalToConstant: 115),
            pokeballImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            pokeballImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        pokeballImageView.image = UIImage(named: "pokeball")
    }
    
    func pokemonImageViewConfiguration() {
        containerView.addSubview(pokemonImageView)
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonImageView.widthAnchor.constraint(equalToConstant: 130),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 130),
            pokemonImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            pokemonImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }
    
    func codeLabelConfiguration() {
        containerView.addSubview(codeLabel)
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            codeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            codeLabel.trailingAnchor.constraint(lessThanOrEqualTo: pokemonImageView.leadingAnchor)
        ])
        
        codeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        codeLabel.textColor = UIColor(red: 0.09, green: 0.09, blue: 0.106, alpha: 0.6)
    }
    
    func nameLabelConfiguration() {
        containerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: pokemonImageView.leadingAnchor)
        ])
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 26)
        nameLabel.textColor = .white
    }
    
    func backgroundDetailImageViewConfiguration() {
        containerView.addSubview(backgroundDetailImageView)
        backgroundDetailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundDetailImageView.widthAnchor.constraint(equalToConstant: 74),
            backgroundDetailImageView.heightAnchor.constraint(equalToConstant: 32),
            backgroundDetailImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundDetailImageView.trailingAnchor.constraint(equalTo: pokemonImageView.leadingAnchor, constant: -30)
        ])
        
        backgroundDetailImageView.image = UIImage(named: "backgroundDetail")
    }
    
    func tagsStackViewConfiguration() {
        containerView.addSubview(tagsStackView)
        tagsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tagsStackView.heightAnchor.constraint(equalToConstant: 25),
            tagsStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            tagsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            tagsStackView.trailingAnchor.constraint(lessThanOrEqualTo: pokemonImageView.leadingAnchor)
        ])
        
        tagsStackView.spacing = 5
        tagsStackView.axis = .horizontal
    }
}

// MARK: Private methods
private extension PokemonTableViewCell {
    func roundContainerCorners() {
        containerView.layer.cornerRadius = 10
    }
    
    func setupTags(_ types: [PokemonType]) {
        types.forEach { setupTag(forType: $0) }
    }
    
    func setupTag(forType type: PokemonType) {
        let imageView = UIImageView(image: UIImage.getPokemonTag(withType: type))
        tagsStackView.addArrangedSubview(imageView)
    }
    
    func removeTags() {
        tagsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
