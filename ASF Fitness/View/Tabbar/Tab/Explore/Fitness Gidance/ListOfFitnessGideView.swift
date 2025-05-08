//
//  ListOfFitnessGideView.swift
//  ASF
//
//  Created by Jenil Rughani on 26/03/25.
//

import SwiftUI

struct ListOfFitnessGideView: View {
    
    @StateObject var fitnessVM = FitnessViewModel()
    @Environment(\.dismiss) var dismiss
    
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
                    
                    Text("Fitness Guidance")
                        .font(Font.caustenFont(customFontName: .CaustenExtraBold, fontSize: 25))
                        .offset(x: -10)
                    
                    Spacer()
                }
                .padding()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        
                        Image("yoga1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                        
                        Text("Fitness is a journey, not a destination. It requires consistent effort, dedication, and patience to achieve long-term health and wellness goals.")
                            .lineLimit(5)
                            .offset(y: 30)
                            .foregroundStyle(.white)
                    }
                    .offset(y: -80)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.purple)
                            .frame(height: logicalHeight/4)
                    }
                    .padding(.horizontal)
                    .padding(.top, 80)
                    
                    ForEach(fitnessVM.arrResponseText) { list in
                        NavigationLink {
                            DetailsFitnessView(fitnessModel: list)
                                .navigationBarBackButtonHidden()
                        } label: {
                            VStack {
                                HStack(spacing: 12) {
                                    Image("yoga1")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: logicalWidth/3, height: logicalWidth/3)
                                        .clipShape(Rectangle())
                                        .shadow(radius: 3)
                                    
                                    VStack(alignment: .leading, spacing: 13) {
                                        Text(list.name.capitalized)
                                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text("Nutrition Guidance provied the fat, protin, sodium & more...")
                                            .font(Font.caustenFont(customFontName: .CaustenRegular, fontSize: 16))
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                        
                                        HStack {
                                            Text("READ MORE")
                                                .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 16))
                                                .foregroundStyle(Color("bluePurple"))
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.forward")
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                }
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.gray)
                                    .frame(height: 1)
                                    .padding(.top)
                            }
                            .foregroundStyle(.black)
                            .padding()
                        }
                    }
                }
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                }
                .ignoresSafeArea()
            }
            
            if fitnessVM.isLoading {
                CustomLoadingview(isShowing: fitnessVM.isLoading)
            }
        }
        .onAppear {
            if fitnessVM.arrResponseText.isEmpty {
                fitnessVM.callAPI()
            }
        }
    }
}

#Preview {
    ListOfFitnessGideView()
}
