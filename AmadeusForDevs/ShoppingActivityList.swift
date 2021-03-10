//
//  ShoppingActivityList.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 10/3/21.
//

import Foundation

class ShoppingActivityList {
    
    private let shoppingActivityProvider = ShoppingActivityProvider()
    
    func getShoppingActivities() {
        shoppingActivityProvider.shoppingActivityReq(dto: ShoppingActivityProviderDTO(latitude: "40.416775", longitude: "-3.703790", radius: "1")) { (shoppingActivity) in
            print(shoppingActivity)
        } failure: { (error) in
            print(error)
        }

    }

}
