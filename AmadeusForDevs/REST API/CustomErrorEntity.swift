//
//  CustomErrorEntity.swift
//  AmadeusForDevs
//
//  Created by Daniel Ayala on 10/3/21.
//

public struct CustomErrorEntity: Decodable {
    public var code: Int?
    public let id: String?
    public let description: String?
    public let localizedDescription: String?
}
