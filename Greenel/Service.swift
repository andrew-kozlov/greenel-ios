//
//  Service.swift
//  Greenel
//
//  Created by Andrew Kozlov on 10/11/2018.
//  Copyright © 2018 Andrew Kozlov. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

class Service {
    
    static let recordsUpdated = NSNotification.Name("Service.recordsUpdated")
    
    static let shared = Service()
    
    private var emitted = false
    
    private(set) var records: [Record] = [] {
        didSet {
            NotificationCenter.default.post(name: Service.recordsUpdated, object: nil)
        }
    }
    
    func fetch() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        Alamofire.SessionManager.default.request(Bundle.main.url(forResource: "list", withExtension: "json")!).responseDecodableObject(decoder: decoder) { (response: DataResponse<Array<Record>>) in
            
            if self.emitted {
                self.records = response.value ?? []
            } else {
                self.records = []
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.fetch()
            }
        }
    }
    
    func emit() {
        emitted = true
    }
    
    func revoke() {
        emitted = false
    }
    
}
