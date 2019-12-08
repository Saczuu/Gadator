//
//  FirebaseMessage.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/6/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation

struct FirebaseMessage: Identifiable {
    var id = UUID().uuidString
    var areCurrentUserIsAuthor: Bool!
    var value: String!
}
