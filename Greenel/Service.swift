//
//  Service.swift
//  Greenel
//
//  Created by Andrew Kozlov on 10/11/2018.
//  Copyright © 2018 Andrew Kozlov. All rights reserved.
//

import Foundation

class Service {
    
    static let recordsUpdated = NSNotification.Name("Service.recordsUpdated")
    
    static let shared = Service()
    
    private(set) var records: [Record] = [] {
        didSet {
            NotificationCenter.default.post(name: Service.recordsUpdated, object: nil)
        }
    }
    
    private var _records: [Record] = []
    
    func fetch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.records = self._records
            
            self.fetch()
        }
    }
    
    func emit() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self._records = [
                Record(
                    identifier: "1",
                    creationDate: Date(),
                    ownerName: "Owner 1",
                    ownerOGRN: "OGRN 1",
                    ownerAddress: "Address 1",
                    volume: 123.45,
                    period: "Period 1",
                    emissionVolume: 0.123,
                    certificateNumber: "1234567890",
                    lifeTime: 5,
                    type: "A",
                    wallet: "01234567890"
                ),
                Record(
                    identifier: "2",
                    creationDate: Date(),
                    ownerName: "Owner 2",
                    ownerOGRN: "OGRN 2",
                    ownerAddress: "Address 2",
                    volume: 123.45,
                    period: "Period 2",
                    emissionVolume: 0.123,
                    certificateNumber: "1234567890",
                    lifeTime: 5,
                    type: "B",
                    wallet: "01234567890"
                ),
                Record(
                    identifier: "3",
                    creationDate: Date(),
                    ownerName: "Owner 1",
                    ownerOGRN: "OGRN 1",
                    ownerAddress: "Address 1",
                    volume: 12.345,
                    period: "Period 3",
                    emissionVolume: 0.123,
                    certificateNumber: "1234567890",
                    lifeTime: 50,
                    type: "A",
                    wallet: "01234567890"
                )
            ]
        }
    }
    
    func revoke() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self._records = []
        }
    }
    
}
