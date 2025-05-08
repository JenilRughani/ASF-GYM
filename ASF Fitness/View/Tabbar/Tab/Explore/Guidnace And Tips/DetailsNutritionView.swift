//
//  DetailsNutritionView.swift
//  ASF
//
//  Created by Jenil Rughani on 25/03/25.
//

import SwiftUI

struct DetailsNutritionView: View {
    
    var nutritionDetails: NutritionModel
    
    var body: some View {
        ZStack {
            Color("lightBlue")
                .ignoresSafeArea()
            
            VStack {
                BackView()
                
                HStack {
                    Text("Nutrition Details")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(.black)
                    .frame(height: 1)
                    .padding([.bottom, .horizontal])
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: 25) {
                        HStack {
                            Text("Name:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text(nutritionDetails.name.capitalized)
                                .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                                .foregroundStyle(Color("bluePurple"))
                        }
                        
                        HStack {
                            Text("Fat:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text("\(nutritionDetails.fat) g")
                                .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                                .foregroundStyle(Color("bluePurple"))
                        }
                        
                        HStack {
                            Text("Fat Saturated:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text("\(nutritionDetails.fatSaturated) g")
                                .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                                .foregroundStyle(Color("bluePurple"))
                        }
                        
                        HStack {
                            Text("Sodium:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text("\(nutritionDetails.sodium) g")
                                .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                                .foregroundStyle(Color("bluePurple"))
                        }
                        
                        HStack {
                            Text("Potassium:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text("\(nutritionDetails.potassium) g")
                                .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                                .foregroundStyle(Color("bluePurple"))
                        }
                        
                        HStack {
                            Text("Cholesterol:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text("\(nutritionDetails.cholesterol) g")
                                .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                                .foregroundStyle(Color("bluePurple"))
                        }
                        
                        HStack {
                            Text("Carbohydrates:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text("\(nutritionDetails.carbohydrates) g")
                                .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                                .foregroundStyle(Color("bluePurple"))
                        }
                        
                        HStack {
                            Text("Fiber:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text("\(nutritionDetails.fiber) g")
                                .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                                .foregroundStyle(Color("bluePurple"))
                        }
                        
                        HStack {
                            Text("Sugar:")
                                .font(.caustenFont(customFontName: .CaustenBold, fontSize: 22))
                            
                            Spacer()
                            
                            Text("\(nutritionDetails.sugar) g")
                                .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                                .foregroundStyle(Color("bluePurple"))
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    DetailsNutritionView(nutritionDetails: NutritionModel(name: "brisket", fat: "82.9", fatSaturated: "33.2", sodium: "217", potassium: "781", cholesterol: "487", carbohydrates: "0.0", fiber: "50.0", sugar: "10.0"))
}
