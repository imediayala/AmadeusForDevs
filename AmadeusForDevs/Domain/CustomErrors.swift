//
//  CustomErrors.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 11/3/21.
//

import Foundation

struct CustomErrors {
    var errors = [CustomError]()
    
    init(entity: CustomErrorsEntity) {
        entity.errors?.forEach { errors.append(CustomError(entity: $0)) }
    }
}

struct CustomError {
    public var code: Int64?
    public let title: String?
    public let detail: String?
    public let status: Int?
    
    init(entity: CustomErrorEntity) {
        code = entity.code
        title = entity.title
        detail = entity.detail
        status = entity.status
    }
}
