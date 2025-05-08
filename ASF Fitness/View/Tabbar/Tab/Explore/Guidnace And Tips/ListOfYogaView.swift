//
//  ListOfYogaView.swift
//  ASF
//
//  Created by Jenil Rughani on 03/04/25.
//

import SwiftUI

struct ListOfYogaView: View {
    @StateObject var yogaVM = YogaViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color("lightBlue")
                .ignoresSafeArea()
            
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
                    
                    Text("Meditation & Yoga")
                        .font(Font.caustenFont(customFontName: .CaustenExtraBold, fontSize: 25))
                        .offset(x: -8)
                    
                    Spacer()
                }
                .padding()
            
                Spacer()
                    .frame(height: 50)
                
                
                ScrollView(showsIndicators: false) {
                    
                    
                    ForEach(yogaVM.arrResponseText) { list in
                        NavigationLink {
                            DetailsOfYogaView(yodaDetails: list)
                                .navigationBarBackButtonHidden()
                        } label: {
                            VStack {
                                HStack(spacing: 12) {
                                    AsyncImage(url: URL(string: list.img)) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: logicalWidth/3, height: logicalWidth/3)
                                                .clipShape(Rectangle())
                                                .shadow(radius: 3)
                                        } else {
                                            ProgressView()
                                                .tint(Color("bluePurple"))
                                        }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 13) {
                                        Text(list.englishName.capitalized)
                                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text(list.pose_benefits)
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
            
            if yogaVM.isLoading {
                CustomLoadingview(isShowing: yogaVM.isLoading)
            }
        }
        .onAppear {
            if yogaVM.arrResponseText.isEmpty {
                yogaVM.callAPI()
            }
        }
    }
}

#Preview {
    ListOfYogaView()
}
