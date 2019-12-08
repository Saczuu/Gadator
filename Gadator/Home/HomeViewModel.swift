//
//  File.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/2/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class HomeViewModel: ObservableObject {
    
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
}
