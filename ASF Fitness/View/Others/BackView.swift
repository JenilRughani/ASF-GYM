//
//  BackView.swift
//  ASF
//
//  Created by Jenil Rughani on 13/03/25.
//

import SwiftUI

struct BackView: View {
    
    @Environment(\.dismiss) var dismiss
    var img: String = "arrow.left"
    
    var body: some View {
        HStack {
            Button(action: {
                dismiss.callAsFunction()
            }, label: {
                Image(systemName: img)
                    .foregroundColor(.black)
                    .font(.title3)
                    .fontWeight(.bold)
            })
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    BackView()
}
