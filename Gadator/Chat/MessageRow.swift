//
//  MessageRow.swift
//  Gadator
//
//  Created by Maciej Sączewski on 11/14/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import SwiftUI

struct MessageRow: View {
    var message: Message!
    var isCurrentUserAuthor: Bool!
    var body: some View {
        HStack{
            if isCurrentUserAuthor {
                Spacer()
                HStack {
                    Text(message.value)
                }
                    .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .cornerRadius(45)
                    .frame( minHeight: 45, maxHeight: .infinity)
                    .foregroundColor(.black)
                    .background(Color.gray)
            } else {
                HStack {
                    Text(message.value)
                }
                    .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .cornerRadius(45)
                    .frame( minHeight: 45, maxHeight: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                Spacer()
            }
        }
    }
}

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        MessageRow()
    }
}
