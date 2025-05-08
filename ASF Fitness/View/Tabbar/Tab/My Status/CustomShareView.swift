//
//  CustomShareView.swift
//  ASF
//
//  Created by Jenil Rughani on 14/03/25.
//

import SwiftUI

struct CustomShareView: View {
    
    var model: HealthModel
    @Binding var isOpen: Bool
    @State private var isShowingShareSheet = false
    @State private var shareText = ""
    
    var body: some View {
        VStack {
            Image("share")
                .resizable()
                .frame(width: 65, height: 65)
                .scaledToFill()
                .padding(.top)
            
            Text("Share Data!")
                .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                .padding(.bottom)
                .foregroundStyle(.white)
            
            //MARK: - List Of Share Data!
            VStack(alignment: .leading, spacing: 12) {
             
                HStack {
                    Text("1.")
                    
                    Text("Steps:")
                    
                    Spacer()
                    
                    Text(model.steps)
                        .foregroundStyle(Color("bluePurple"))
                }
                
                
                HStack {
                    Text("2.")
                    
                    Text("Heart rate:")
                    
                    Spacer()
                    
                    Text(model.heartRate)
                        .foregroundStyle(Color("bluePurple"))
                }
                
                HStack {
                    Text("3.")
                    
                    Text("Training:")
                    
                    Spacer()
                    
                    Text(model.training)
                        .foregroundStyle(Color("bluePurple"))
                }
                
                HStack {
                    Text("4.")
                    
                    Text("Calories rate:")
                    
                    Spacer()
                    
                    Text(model.calories)
                        .foregroundStyle(Color("bluePurple"))
                }
                
                HStack {
                    Text("5.")
                    
                    Text("Sleep:")
                    
                    Spacer()
                    
                    Text(model.sleep)
                        .foregroundStyle(Color("bluePurple"))
                }
                
                HStack {
                    Text("6.")
                    
                    Text("Distance:")
                    
                    Spacer()
                    
                    Text(model.distance)
                        .foregroundStyle(Color("bluePurple"))
                }
                
            }
            .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 22))
            .foregroundStyle(.white)
            
            //MARK: - Buttons
            HStack {
                Button(action: {
                    withAnimation {
                        isOpen = false
                    }
                }, label: {
                    HStack(spacing: 0) {
                        Image(systemName: "multiply")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("CANCLE")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 18))
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(.white)
                })
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color("bluePurple"))
                }
                
                Button(action: {
                    withAnimation {
                        isOpen = false
                    }
                    shareContent()
                }, label: {
                    HStack(spacing: 0) {
                        Image(systemName: "arrowshape.turn.up.right.fill")
                            .font(.title3)
                            .fontWeight(.bold)
                        Text("SHARE")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 18))
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(.white)
                })
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color("bluePurple"))
                }
                .sheet(isPresented: $isShowingShareSheet) {
                    ShareSheet(items: [shareText])
                }
            }
            .padding(.vertical)
        }
        .onAppear {
            shareText = """
Health Data:
- Steps: \(model.steps)
- Heart Rate: \(model.heartRate)
- Training: \(model.training)
- Calories: \(model.calories)
- Sleep: \(model.sleep)
- Distance: \(model.distance)
- Date: \(model.dateTime)
"""
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.black.opacity(0.85))
        }
        .padding(.horizontal, 25)
        .ignoresSafeArea()
    }
    
    private func shareContent() {
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true, completion: nil)
        }
    }
}

#Preview {
    CustomShareView(model: HealthModel(steps: "1234", heartRate: "120", training: "120", calories: "120", sleep: "120", distance: "120", dateTime: Date()), isOpen: .constant(false))
}
