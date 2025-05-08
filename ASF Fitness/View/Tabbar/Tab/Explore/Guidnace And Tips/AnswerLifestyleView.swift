//
//  AnswerLifestyleView.swift
//  ASF
//
//  Created by Jenil Rughani on 27/03/25.
//

import SwiftUI

struct AnswerLifestyleView: View {
    
    var lifeData: LifestyleModel
    @StateObject var lifestyleVM = LifeStyleViewModel()
    @State private var bmi: Double = 0.0
    @State private var bmr: Int = 0
    @State private var bmiCategory: String = ""
    @State private var fitnessStatus: String = ""
    @State private var isShareData: Bool = false
    @State private var shareText: String = ""
    
    var body: some View {
        VStack {
            //MARK: - Back Button
            BackView()
            
            //MARK: - Img
            HStack {
                VStack(alignment: .leading) {
                    Image("ASF")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .foregroundStyle(Color("bluePurple"))
                    
                    Text("Lifestyle Data")
                        .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 30))
                        .foregroundStyle(Color("bluePurple"))
                }
                
                Spacer()
                
            }
            .padding([.bottom, .horizontal])
            
            Spacer()
            
            VStack(spacing: 15) {
                
                HStack(content: {
                    Text("Calculate Data")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                        .foregroundStyle(.green)
                        .padding(.top)
                })
                
                HStack {
                    Text("BMI:")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text(String(format: "%.2f", bmi))
                        .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 18))
                        .foregroundColor(Color("bluePurple"))
                        .multilineTextAlignment(.trailing)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("BMR:")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text("\(bmr) kcal/day")
                        .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 18))
                        .foregroundColor(Color("bluePurple"))
                        .multilineTextAlignment(.trailing)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Category:")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22)).multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text(bmiCategory)
                        .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 18))
                        .foregroundColor(Color("bluePurple"))
                        .multilineTextAlignment(.trailing)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding()
            .background(
                Color(UIColor.secondarySystemBackground)
            )
            .cornerRadius(12)
            .padding(.horizontal)
            
            Text("🔥You are \(fitnessStatus)🔥")
                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 20))
                .lineLimit(2)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            MarqueeText(
                text: "⭐️ Note: The BMI and BMR values are general estimates. Please consult a doctor for accurate health evaluation. ⭐️",
                font: UIFont.systemFont(ofSize: 16, weight: .bold),
                leftFade: 15,
                rightFade: 15,
                startDelay: 0.5
            )
            .foregroundStyle(Color("bluePurple"))
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .padding([.horizontal])
            .padding()
            
            Button {
                withAnimation {
                    isShareData = true
                }
            } label: {
                HStack {
                    Image(systemName: "arrowshape.turn.up.right.fill")
                    Text("SHARE DATA")
                        .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 18))
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
            }
            .sheet(isPresented: $isShareData) {
                ShareSheet(items: [shareText])
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 40)
                    .fill(.black)
                    .frame(height: 50)
            }
            .padding(.horizontal)
        }
        .onAppear() {
            bmi = lifestyleVM.bmi(height: lifeData.height, weight: lifeData.weight)
            bmr = Int(lifestyleVM.bmr(height: lifeData.height, weight: lifeData.weight, age: Double(lifeData.age), gender: lifeData.gender))
            
            bmiCategory = lifestyleVM.bmiCategory(bmi: bmi)
            fitnessStatus = lifestyleVM.fitnessStatus(bmi: bmi, bmr: Double(bmr))
            
            shareText = """
    BMI: \(bmi),
    BMR: \(bmr),
    BMI Category: \(bmiCategory),
    Fitness Status: \(fitnessStatus)
"""
        }
    }
}

#Preview {
    AnswerLifestyleView(lifeData: LifestyleModel(height: 153, weight: 60, age: 22, gender: "male"))
}
