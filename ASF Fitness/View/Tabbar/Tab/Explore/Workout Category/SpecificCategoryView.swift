//
//  SpecificCategoryView.swift
//  ASF
//
//  Created by Jenil Rughani on 23/03/25.
//

import SwiftUI
import Kingfisher

struct SpecificCategoryView: View {
    var cat: WorkoutModel
    @StateObject var workoutVM = WorkoutCategoryViewModel()
    
    var body: some View {
        ZStack {
            cat.color
                .ignoresSafeArea()
            
            VStack {
                
                BackView()
                
                HStack {
                    Text(cat.name)
                        .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                        .lineLimit(2)
                    
                    Spacer()
                    
                }
                .padding([.bottom, .horizontal])
                
                RoundedRectangle(cornerRadius: 40)
                    .frame(height: 2)
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                
                ScrollView(showsIndicators: false) {
                    ForEach(workoutVM.arrResponseText, id: \.self) { model in
                        
                        NavigationLink {
                            FinalDisplayWorkoutview(cat: cat, workoutCatModel: model)
                                .navigationBarBackButtonHidden()
                        } label: {
                            HStack(alignment: .top ,spacing: 0) {
                                KFAnimatedImage(URL(string: model.gifUrl))
                                    .padding(.vertical)
                                    .background {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(.white)
                                            .shadow(radius: 5)
                                    }
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    Text(model.name.capitalized)
                                        .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 25))
                                        .multilineTextAlignment(.leading)
                                    
                                    HStack {
                                        Text("Type:")
                                            .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                                        
                                        Spacer()
                                    }
                                    
                                    Text(model.target.capitalized)
                                        .font(Font.caustenFont(customFontName: .CaustenMedium, fontSize: 18))
                                        .foregroundStyle(Color("bluePurple"))
                                        .multilineTextAlignment(.leading)
                                    
                                    HStack {
                                        Text("Bodypart:")
                                            .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                                        
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text(model.bodyPart.capitalized)
                                            .font(Font.caustenFont(customFontName: .CaustenMedium, fontSize: 18))
                                            .foregroundStyle(Color("bluePurple"))
                                    }
                                    .padding(.top, -10)
                                }
                                .padding()
                            }
                            .foregroundStyle(.black)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                            }
                            .padding()
                        }
                    }
                }
            }
            
            if workoutVM.isLoading {
                CustomLoadingview(isShowing: workoutVM.isLoading)
            }
        }
        .onAppear {
            if workoutVM.arrResponseText.isEmpty {
                workoutVM.callAPI(type: cat.img)
            }
        }
    }
}

#Preview {
    SpecificCategoryView(cat: arrOFWorkout[0])
}
