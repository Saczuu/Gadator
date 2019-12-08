//
//  FirebaseChat.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/6/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation

struct FirebaseChat: Identifiable {
    var id: String
    var reciver: FirebaseUser
    var messages: [FirebaseMessage]
}
