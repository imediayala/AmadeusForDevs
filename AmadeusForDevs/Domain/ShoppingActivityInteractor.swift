//
//  ShoppingActivityInteractor.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 10/3/21.
//

import Foundation

typealias failureHandler = (CustomErrors) -> Void


class ShoppingActivityInteractor {
    
    private let shoppingActivityProvider = ShoppingActivityProvider()
    typealias successShoppingActivityHandler = (ShoppingActivity) -> Void

    
    func getShoppingActivities(dto: ShoppingActivityInteractorDTO, success: @escaping successShoppingActivityHandler, failure: @escaping failureHandler) {
        shoppingActivityProvider.shoppingActivityReq(dto: ShoppingActivityProviderDTO(latitude: dto.latitude, longitude: dto.longitude, radius: dto.radius)) { (shoppingActivityEntity) in
            success(ShoppingActivity(entity: shoppingActivityEntity))
        } failure: { (error) in
            failure(CustomErrors(entity: error))
        }

    }

}

struct ShoppingActivityInteractorDTO {
    let latitude: String
    let longitude: String
    let radius: String
}

