//
//  RegisterViewModel.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/3/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class RegisterViewModel: ObservableObject {
    
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var showLoadingIndicator: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    @Published var rotateIndicator: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var showErrorPopUp: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var errorDiscription: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var showSuccessPopUp: Bool = false {
        didSet {
            objectWillChange.send()
        }
    }
}
