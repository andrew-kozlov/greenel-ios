//
//  Record.swift
//  Greenel
//
//  Created by Andrew Kozlov on 10/11/2018.
//  Copyright © 2018 Andrew Kozlov. All rights reserved.
//

import Foundation

struct Record: Decodable {
    
    let identifier: String
    let creationDate: Date
    let ownerName: String
    let ownerOGRN: String
    let ownerAddress: String
    let volume: Float
    let period: String
    let emissionVolume: Float
    let certificateNumber: String
    let lifeTime: Int
    let type: String
    let wallet: String
    
    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case creationDate = "createdDate"
        case ownerName = "ownerName"
        case ownerOGRN = "ogrn"
        case ownerAddress = "address"
        case volume = "volume"
        case period = "period"
        case emissionVolume = "co2Volume"
        case certificateNumber = "sertNumber"
        case lifeTime = "lifeTime"
        case type = "type"
        case wallet = "wallet"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""
        creationDate = try container.decodeIfPresent(Date.self, forKey: .creationDate) ?? Date()
        ownerName = try container.decodeIfPresent(String.self, forKey: .ownerName) ?? ""
        ownerOGRN = try container.decodeIfPresent(String.self, forKey: .ownerOGRN) ?? ""
        ownerAddress = try container.decodeIfPresent(String.self, forKey: .ownerAddress) ?? ""
        volume = try container.decodeIfPresent(Float.self, forKey: .volume) ?? 0.0
        period = try container.decodeIfPresent(String.self, forKey: .period) ?? ""
        emissionVolume = try container.decodeIfPresent(Float.self, forKey: .emissionVolume) ?? 0.0
        certificateNumber = try container.decodeIfPresent(String.self, forKey: .certificateNumber) ?? ""
        lifeTime = try container.decodeIfPresent(Int.self, forKey: .lifeTime) ?? 0
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        wallet = try container.decodeIfPresent(String.self, forKey: .wallet) ?? ""
    }
    
}
