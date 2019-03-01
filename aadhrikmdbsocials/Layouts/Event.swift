//
//  Event.swift
//  aadhrikmdbsocials
//
//  Created by Aadhrik Kuila on 2/24/19.
//  Copyright © 2019 Aadhrik Kuila. All rights reserved.
//

import Foundation

class Event {
    var uid = ""
    var name: String
    var date: String
    var description: String
    var owner: String
    var numInterested: Int
    
    
    init(withName name: String, dated date: String, wDescription description: String, ownedBy owner: String, interested numInterested: Int) {
        self.name = name
        self.date = date
        self.description = description
        self.owner = owner
        self.numInterested = numInterested
    }

    func getDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm/dd/yyyy"
        return formatter.date(from: self.date)!
    }
    
}
