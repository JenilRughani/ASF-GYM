//
//  ExploreView.swift
//  ASF
//
//  Created by Jenil Rughani on 21/03/23.
//

import SwiftUI

struct ExploreView: View {
    
    @State private var isMoveWorkoutScreen: Bool = false
    @State private var isNotifyScreen: Bool = false
    @State private var isNutritionScreenMove: Bool = false
    @State private var isRecipeScreenMove: Bool = false
    @State private var isHealthyScreenMove: Bool = false
    @State private var isLifeStyleScreenMove: Bool = false
    @State private var isFitnessGuidance: Bool = false
    @State private var isHealthAndFitness: Bool = false
    @State private var fName: String = ""
    @AppStorage("userInfoDetail") var userInfoDetail: Data = Data()
    
    var body: some View {
        VStack {
            HStack(content: {
                Text("Hi, \(fName)!")
                    .font(Font.caustenFont(customFontName: .CaustenExtraBold, fontSize: 35))
                    .lineLimit(2)
                
                Spacer()
                
                HStack(alignment: .center, spacing: 25) {
                    Button(action: {
                        withAnimation {
                            isMoveWorkoutScreen = true
                        }
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    })
                    .navigationDestination(isPresented: $isMoveWorkoutScreen) {
                        WorkoutCategoriesView()
                            .navigationBarBackButtonHidden()
                    }
                    
                    Button(action: {
                        withAnimation {
                            isNotifyScreen = true
                        }
                    }, label: {
                        Image(systemName: "bell")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    })
                    .navigationDestination(isPresented: $isNotifyScreen) {
                        NotifyView()
                            .navigationBarBackButtonHidden()
                    }
                }
            })
            .padding([.top, .horizontal])
            
            ScrollView(showsIndicators: false) {
                VStack {
                    
                    //MARK: - Workout Categories
                    HStack {
                        Text("Workout Categories")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                        
                        Spacer()
                    }
                    .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(arrOFWorkout) { data in
                                NavigationLink {
                                    SpecificCategoryView(cat: data)
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    WorkoutView(name: data.name, img: data.img, color: data.color)
                                }
                            }
                            .padding(.horizontal, 8)
                        }
                        .padding(.leading)
                    }
                    
                    //MARK: - Guidance and Tips
                    HStack {
                        Text("Helps and Tips")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                        
                        Spacer()
                    }
                    .padding()
                    
                    VStack {
                        HStack(spacing: 40) {
                            GuidanceAndTipsView(img: "Nutritio", name: "Nutrition\n Helper") {
                                withAnimation {
                                    isNutritionScreenMove = true
                                }
                            }
                            .navigationDestination(isPresented: $isNutritionScreenMove) {
                                NutritionGuidanceView()
                                    .navigationBarBackButtonHidden()
                            }
                            
                            GuidanceAndTipsView(img: "Recipes", name: "Recipes &\nFood") {
                                withAnimation {
                                    isRecipeScreenMove = true
                                }
                            }
                            .navigationDestination(isPresented: $isRecipeScreenMove) {
                                ListOfRecipeView()
                                    .navigationBarBackButtonHidden()
                            }
                        }
                        .padding()
                        
                        HStack(spacing: 40) {
                            GuidanceAndTipsView(img: "Healthy", name: "Meditation &\n Yoga") {
                                withAnimation {
                                    isHealthyScreenMove = true
                                }
                            }
                            .navigationDestination(isPresented: $isHealthyScreenMove) {
                                ListOfYogaView()
                                    .navigationBarBackButtonHidden()
                            }

                            GuidanceAndTipsView(img: "Lifestyle", name: "Lifestyle\nProgress") {
                                withAnimation {
                                    isLifeStyleScreenMove = true
                                }
                            }
                            .navigationDestination(isPresented: $isLifeStyleScreenMove) {
                                LifeStyleView()
                                    .navigationBarBackButtonHidden()
                            }
                        }
                        .padding()
                    }
                    .padding(.bottom)
                    
                    //MARK: - Fitness Guidance
                    VStack {
                        
                        Image("yoga1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                        
                        Text("Fitness Guidance")
                            .font(Font.caustenFont(customFontName: .CaustenExtraBold, fontSize: 24))
                            .foregroundStyle(.white)
                        
                        Text("Fitness is a journey, not a destination. It\n requires consistent effort, dedication, and\n patience to achieve long-term health and\n wellness goals.")
                            .padding()
                            .font(Font.caustenFont(customFontName: .CaustenMedium, fontSize: 16))
                            .foregroundStyle(.white)
                        
                        Button(action: {
                            withAnimation {
                                isFitnessGuidance = true
                            }
                        }, label: {
                            Text("Know More")
                                .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 16))
                                .foregroundStyle(.black)
                        })
                        .navigationDestination(isPresented: $isFitnessGuidance, destination: {
                            ListOfFitnessGideView()
                                .navigationBarBackButtonHidden()
                        })
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(.white)
                                .frame(width: 190, height: 42)
                        }
                    }
                    .offset(y: -50)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.purple)
                            .frame(maxWidth: .infinity)
                            .frame(height: logicalHeight/3)
                    }
                    .padding(.top, 50)
                    
                    //MARK: - Health and Fitness literature and Tips
                    VStack {
                        
                        Image("yoga2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                        
                        Text("Health & Fitness and Tips")
                            .font(Font.caustenFont(customFontName: .CaustenExtraBold, fontSize: 22))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 200)
                        
                        Text("Fitness is a journey, not a destination. It\n requires consistent effort, dedication, and\n patience to achieve long-term health and\n wellness goals.")
                            .padding()
                            .font(Font.caustenFont(customFontName: .CaustenMedium, fontSize: 16))
                            .foregroundStyle(.white)
                        
                        Button(action: {
                            withAnimation {
                                isHealthAndFitness = true
                            }
                        }, label: {
                            Text("Know More")
                                .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 16))
                                .foregroundStyle(.black)
                        })
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(.white)
                                .frame(width: 190, height: 42)
                        }
                    }
                    .navigationDestination(isPresented: $isHealthAndFitness, destination: {
                        ListOfHealthFitnessView()
                            .navigationBarBackButtonHidden()
                    })
                    .offset(y: -60)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 40)
                            .fill(Color("bluePurple"))
                            .frame(maxWidth: .infinity)
                            .frame(height: logicalHeight/2.75)
                    }
                    .padding(.top)
                }
            }
        }
        .onAppear() {
            //TODO:- Add the Firebase get User details Info
            self.fName = loadUserInfo(userInfoData: userInfoDetail)?.fName ?? "Jason"
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
