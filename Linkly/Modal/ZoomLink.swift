//
//  ZoomLink.swift
//  Linkly
//
//  Created by Hallie on 9/12/21.
//

import Foundation

struct ZoomLink: Hashable, Codable {
    static func == (lhs: ZoomLink, rhs: ZoomLink) -> Bool {
        return (rhs.uuid == lhs.uuid)
    }
    
    let uuid: String
    let title: String
    let link: String
    let color: ZoomLinkColor
    
    init(withTitle t: String, forLink l: String, id: String, ofColor c: ZoomLinkColor = .blue) {
        self.title = t
        self.link = l
        self.color = c
        self.uuid = id
    }
}
