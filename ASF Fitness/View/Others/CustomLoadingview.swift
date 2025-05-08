//
//  CustomLoadingview.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/25.
//

import SwiftUI

struct CustomLoadingview: View {
    var isShowing: Bool
    
    var body: some View {
        VStack {
            if isShowing {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .foregroundColor(.white)
                    .font(.caption)
                    .fontWeight(.bold)
                    .animation(.easeInOut, value: isShowing)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.black.opacity(0.75))
                    }
                    .scaleEffect(2.0)  // Large Size
            }
        }
        
    }
}

#Preview {
    CustomLoadingview(isShowing: true)
}
