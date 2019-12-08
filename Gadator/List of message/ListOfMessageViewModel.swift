//
//  ListOfMessageViewModel.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/4/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class ListOfMessageViewModel: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var showLoadingIndicator: Bool = true {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var rotateIndicator: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var messagesToShow: [FirebaseChat] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
}
