//
//  ShoppingActivity.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 10/3/21.
//

import Foundation
import SwiftUI

struct ShoppingActivity {
    var shoppingActivities = [ShoppingSingleActivity]()
    
    init(entity: ShoppingActivityEntity) {
        entity.data?.forEach { shoppingActivities.append(ShoppingSingleActivity(entity: $0)) }
    }
}

struct ShoppingSingleActivity: Hashable, Codable, Identifiable {
    var id: String
    let type: String?
    let name: String?
    let shortDescription: String?
    let rating: String?
    let price: Price?
    let pictures: [String]?
    let bookingLink: String?
    
    init(entity: ShoppingSingleActivityEntity) {
        id = entity.id
        type = entity.type
        name = entity.name
        shortDescription = entity.shortDescription
        rating = entity.rating
        if let priceEntity = entity.price {
            price = Price(entity: priceEntity)
        }else {
            price = nil
        }
        pictures = entity.pictures
        bookingLink = entity.bookingLink
    }
    
}

struct Price: Hashable, Codable {
    let currencyCode: String?
    let ammount: String?
    
    init(entity: PriceEntity) {
        currencyCode = entity.currencyCode
        ammount = entity.ammount
    }
}
