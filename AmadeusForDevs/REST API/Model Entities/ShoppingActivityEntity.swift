//
//  ShoppingActivityEntity.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 10/3/21.
//

import Foundation

struct ShoppingActivityEntity: Decodable {
    let data: [ShoppingSingleActivityEntity]?
}

struct ShoppingSingleActivityEntity: Decodable {
    let type: String?
    let name: String?
    let shortDescription: String?
    let rating: String?
    let price: PriceEntity?
    let pictures: [String]?
    let bookingLink: String?
    let id: String
    
}

struct PriceEntity: Decodable {
    let currencyCode: String?
    let ammount: String?
}
