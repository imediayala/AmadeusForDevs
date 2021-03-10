//
//  ShoppingActivityEntity.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 10/3/21.
//

import Foundation

struct ShoppingActivityEntity: Codable {
    let type: String
    let name: String
    let shortDescription: String
    let rating: String
    let price: Price
    let pictures: [String]
    let bookingLink: String
    
}

struct Price: Codable {
    let currencyCode: String
    let ammount: String
}