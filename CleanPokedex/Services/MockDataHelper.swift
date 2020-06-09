//
//  MockedService.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 08/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

final class MockDataHelper {
    // MARK: Abstract data
    enum MockedResource: String {
        case pokemons = "Pokemons"
    }
    
    // MARK: Methods
    static func getData(forResource resource: MockedResource) -> Data {
        let bundle = Bundle(for: self)
        guard let path = bundle.path(forResource: resource.rawValue, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                fatalError("Recurso não encontrado")
        }
        
        return data
    }
}
