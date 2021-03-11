//
//  CustomErrorsEntity.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 10/3/21.
//

struct CustomErrorsEntity: Decodable {
    let errors: [CustomErrorEntity]?
}


struct CustomErrorEntity: Decodable {
    public var code: Int64?
    public let title: String?
    public let detail: String?
    public let status: Int?
}
