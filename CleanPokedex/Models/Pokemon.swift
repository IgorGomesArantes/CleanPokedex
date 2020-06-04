//
//  Pokemon.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let speed: Int
    let total: Int
    let name: String
    let code: String
    let attack: Int?
    let defence: Int?
    let type: [String]
    let height: String
    let weight: String
    let cycles: String
    let reason: String
    let genderless: Int
    let category: String
    let imageURL: String
    let eggGroups: String
    let healthPoints: Int
    let specialAttack: Int
    let experience: String
    let specialDefence: Int
    let abilities: [String]
    let evolvedFrom: String
    let xDescription: String
    let yDescription: String
    let weaknesses: [String]
    let evolutions: [String]
    let malePercentage: String?
    let femalePercentage: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case speed
        case total
        case height
        case weight
        case cycles
        case attack
        case reason
        case defence
        case category
        case abilities
        case weaknesses
        case evolutions
        case genderless
        case code = "id"
        case healthPoints = "hp"
        case imageURL = "imageurl"
        case type = "typeofpokemon"
        case experience = "base_exp"
        case eggGroups = "egg_groups"
        case evolvedFrom = "evolvedfrom"
        case xDescription = "xdescription"
        case yDescription = "ydescription"
        case specialAttack = "special_attack"
        case specialDefence = "special_defense"
        case malePercentage = "male_percentage"
        case femalePercentage = "female_percentage"
    }
}


