//
//  Elements.swift
//  AC3.2-MidtermElements
//
//  Created by Kadell on 12/8/16.
//  Copyright © 2016 Kadell. All rights reserved.
//

import Foundation

enum ErrorCatching: Error {
    case testError
}

class Elements {
    
    let name: String
    let symbol: String
    let weight: Double
    let number: Int
    let melting: Double
    let boiling: Double

    init(name: String, symbol: String, weight:  Double, number: Int, melting: Double , boiling: Double) {
        self.name = name
        self.symbol = symbol
        self.weight = weight
        self.number = number
        self.melting = melting
        self.boiling = boiling
    }
    
    
    static func getData(data: Data) -> [Elements]? {
        do{
            
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let dict = json as? [[String: Any]] else {
                print("Error accessing the Dictionary")
                return nil}
            
            var elementsArray = [Elements]()
            
            for element in dict {
                guard let name = element["name"] as? String else { throw ErrorCatching.testError }
                guard let symbol = element["symbol"] as? String else { throw ErrorCatching.testError }
                guard let weight = element["weight"] as? Double else {throw ErrorCatching.testError}
                guard let number = element["number"] as? Int else {throw ErrorCatching.testError}
                    let melt = element["melting_c"] as? Double ?? 0.0
                    let boil = element["boiling_c"] as? Double ?? 0.0
                    let elementOf = Elements(name: name, symbol: symbol, weight: weight, number: number, melting: melt, boiling: boil )
                    elementsArray.append(elementOf)
            }
            
            return elementsArray
        }
            
        catch{
            print("\(error)")
        }
        
        return nil
    }
    
    
}
