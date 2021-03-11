//
//  ShoppingActivityProvider.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 10/3/21.
//

import Foundation


class ShoppingActivityProvider: BaseProvider {

    typealias successShoppingActivityEntityHandler = (ShoppingActivityEntity) -> Void
    
    // MARK: PUBLIC
    func shoppingActivityReq(dto: ShoppingActivityProviderDTO ,success: @escaping successShoppingActivityEntityHandler, failure: @escaping failureHandler) {
        let parameters = ["latitude": dto.latitude, "longitude": dto.longitude, "radius": dto.radius]

        request(endpoint: "/shopping/activities", method: .get, parameters: parameters, entityType: ShoppingActivityEntity.self, success: { shoppingActivityEntity in
            success(shoppingActivityEntity)
        }, failure: failure)
    }

}

struct ShoppingActivityProviderDTO {
    let latitude: String
    let longitude: String
    let radius: String
}
