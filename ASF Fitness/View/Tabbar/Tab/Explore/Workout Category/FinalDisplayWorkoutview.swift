//
//  FinalDisplayWorkoutview.swift
//  ASF
//
//  Created by Jenil Rughani on 23/03/25.
//

import SwiftUI
import Kingfisher

struct FinalDisplayWorkoutview: View {
    
    var cat: WorkoutModel
    var workoutCatModel: WorkoutCatModel
    
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
                    
                    KFAnimatedImage(URL(string: workoutCatModel.gifUrl))
                        .padding(.vertical)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .shadow(radius: 5)
                        }
                    
                    HStack {
                        Text("Title:")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(workoutCatModel.name)
                            .font(Font.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                        
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("BodyPart:")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                        
                        Spacer()
                        
                        Text(workoutCatModel.bodyPart)
                            .font(Font.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Equipment:")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                        
                        Spacer()
                        
                        Text(workoutCatModel.equipment)
                            .font(Font.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Target:")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                        
                        Spacer()
                        
                        Text(workoutCatModel.target)
                            .font(Font.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Secondary Muscles:")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(workoutCatModel.secondaryMuscles)
                            .font(Font.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                        
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Instructions:")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(workoutCatModel.instructions)
                            .font(Font.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                        
                        Spacer()
                    }
                    .padding(.bottom)
                }
                .padding()
            }
        }
    }
}

#Preview {
    FinalDisplayWorkoutview(cat: arrOFWorkout[0], workoutCatModel: WorkoutCatModel(bodyPart: "back", equipment: "cable", gifUrl: "https://v2.exercisedb.io/image/mSd0oEMgSMe2YH", name: "alternate lateral pulldown", target: "lats", secondaryMuscles: "biceps,rhomboids", instructions: "Sit on the cable machine with your back straight and feet flat on the ground.\n,Grasp the handles with an overhand grip, slightly wider than shoulder-width apart.\n,Lean back slightly and pull the handles towards your chest, squeezing your shoulder blades together.\n,Pause for a moment at the peak of the movement, then slowly release the handles back to the starting position.\nRepeat for the desired number of repetitions."))
}
