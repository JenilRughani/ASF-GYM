//
//  DetailsFitnessView.swift
//  ASF
//
//  Created by Jenil Rughani on 26/03/25.
//

import SwiftUI

struct DetailsFitnessView: View {
    var fitnessModel: FitnessGideModel
    
    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
           
            VStack {
                BackView()
                
                Image("yoga1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                
                Text("Fitness Guidance")
                    .font(.caustenFont(customFontName: .CaustenBold, fontSize: 30))
                    .foregroundStyle(.white)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        //MARK: - Title
                        VStack(spacing: 12) {
                            HStack {
                                Text("Title:")
                                    .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text(fitnessModel.name.capitalized)
                                    .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                                    .foregroundStyle(.white)
                                
                                Spacer()
                            }
                        }
                        
                        //MARK: - Type
                        HStack {
                            Text("Type:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text(fitnessModel.type.capitalized)
                                .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                                .foregroundStyle(.white)
                        }
                        
                        //MARK: - muscle
                        HStack {
                            Text("Muscle:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text(fitnessModel.muscle.capitalized)
                                .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                                .foregroundStyle(.white)
                        }
                        
                        //MARK: - Equipment
                        HStack {
                            Text("Equipment:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text(fitnessModel.equipment.capitalized)
                                .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                                .foregroundStyle(.white)
                        }
                        
                        //MARK: - Difficulty
                        HStack {
                            Text("Difficulty:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text(fitnessModel.difficulty.capitalized)
                                .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                                .foregroundStyle(.white)
                        }
                        
                        //MARK: - Instructions
                        VStack(alignment: .leading ,spacing: 12) {
                            HStack {
                                Text("Instructions:")
                                    .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                                
                                Spacer()
                            }
                            
                            Text(fitnessModel.instructions.capitalized)
                                .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    DetailsFitnessView(fitnessModel: FitnessGideModel(name: "Incline Hammer Curls", type: "strength", muscle: "biceps", equipment: "dumbbell", difficulty: "beginner", instructions: "Seat yourself on an incline bench with a dumbbell in each hand. You should pressed firmly against he back with your feet together. Allow the dumbbells to hang straight down at your side, holding them with a neutral grip. This will be your starting position. Initiate the movement by flexing at the elbow, attempting to keep the upper arm stationary. Continue to the top of the movement and pause, then slowly return to the start position."))
}
