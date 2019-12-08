//
//  NewUserPopUp.swift
//  Gadator
//
//  Created by Maciej Sączewski on 11/13/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import SwiftUI

struct NewUserPopUp: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Spacer()
            Text("GDZIE POP UP")
            Spacer()
        }
        .background(Color.white)
    }
}

struct NewUserPopUp_Previews: PreviewProvider {
    static var previews: some View {
        NewUserPopUp()
    }
}
