//
//  NewConversationViewModel.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/7/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class NewConversationViewModel: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var userList: [FirebaseUser] = [] {
        didSet {
            objectWillChange.send()
        }
    }
}
