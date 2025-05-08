//
//  ListOfHealthFitnessView.swift
//  ASF
//
//  Created by Jenil Rughani on 26/03/25.
//

import SwiftUI

struct ListOfHealthFitnessView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var healthFitnessVM = HealthFitnessViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        dismiss.callAsFunction()
                    }, label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .font(.title3)
                            .fontWeight(.bold)
                    })
                    
                    Spacer()
                    
                    Text("Health & Fitness")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                        .offset(x: -10)
                    
                    Spacer()
                }
                .padding()
                
                ScrollView(showsIndicators: false) {
                    
                    //MARK: - Yoga2
                    VStack {
                        
                        Image("yoga2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                        
                        Text("Fitness is a journey, not a destination. It\n requires consistent effort, dedication, and\n patience to achieve long-term health and\n wellness goals.")
                            .padding()
                            .font(Font.caustenFont(customFontName: .CaustenMedium, fontSize: 16))
                            .foregroundStyle(.white)
                    }
                    .offset(y: -75)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("bluePurple"))
                            .frame(maxWidth: .infinity)
                            .frame(height: logicalHeight/5)
                    }
                    .offset(y: 70)
                    .padding(.bottom)
                    
                    HStack {
                        Text("Literature")
                            .font(Font.caustenFont(customFontName: .CaustenExtraBold, fontSize: 25))
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .padding()
                    
                    ForEach(healthFitnessVM.arrResponseText) { health in
                        NavigationLink {
                            SpecificHealthFitnessView(healthModel: health)
                                .navigationBarBackButtonHidden()
                        } label: {
                            HealthFitnessView(img: health.urlToImage, title: health.title)
                        }
                        .foregroundStyle(.black)
                    }
                }
            }
            
            if healthFitnessVM.isLoading {
                CustomLoadingview(isShowing: healthFitnessVM.isLoading)
            }
        }
        .onAppear {
            if healthFitnessVM.arrResponseText.isEmpty {
                healthFitnessVM.callAPI()
            }
        }
    }
}

#Preview {
    ListOfHealthFitnessView()
}
