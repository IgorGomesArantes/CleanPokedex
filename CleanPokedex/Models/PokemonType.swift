//
//  PokemonType.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 04/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import UIKit

enum PokemonType: String, Decodable {
    case bug = "Bug"
    case ice = "Ice"
    case fire = "Fire"
    case rock = "Rock"
    case dark = "Dark"
    case ghost = "Ghost"
    case grass = "Grass"
    case steel = "Steel"
    case fairy = "Fairy"
    case water = "Water"
    case flying = "Flying"
    case normal = "Normal"
    case poison = "Poison"
    case dragon = "Dragon"
    case ground = "Ground"
    case psychic = "Psychic"
    case electric = "Electric"
    case fighting = "Fighting"
}

// MARK: Resource methods
extension PokemonType {
    var color: UIColor {
        let colorName: String = rawValue.lowercased()
        return UIColor(named: colorName)!
    }
    
    var backgroundColor: UIColor {
        let colorName: String = "background-\(rawValue.lowercased())"
        return UIColor(named: colorName)!
    }
    
    var tagImage: UIImage {
        let imageName: String = "\(rawValue.lowercased())-tag"
        return UIImage(named: imageName)!
    }
}
