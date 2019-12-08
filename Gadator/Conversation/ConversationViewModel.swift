//
//  ConversationViewModel.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/6/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class ConversationViewModel: ObservableObject {
    
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var reciverName: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var messagesToShow: [FirebaseMessage] = [] {
        didSet {
            objectWillChange.send()
        }
    }
}
