//
//  NutritionGuidanceView.swift
//  ASF
//
//  Created by Jenil Rughani on 16/03/25.
//

import SwiftUI

struct NutritionGuidanceView: View {
    
    @StateObject var nutritionVM = NutritionViewModel()
    @State private var arrOfList: [NutritionModel] = [
        NutritionModel(name: "brisket", fat: "82.9", fatSaturated: "33.2", sodium: "217", potassium: "781", cholesterol: "487", carbohydrates: "0.0", fiber: "50.0", sugar: "10.0"),
        NutritionModel(name: "fries", fat: "14.8", fatSaturated: "2.3", sodium: "212", potassium: "124", cholesterol: "0", carbohydrates: "0.0", fiber: "3.8", sugar: "0.3"),
        NutritionModel(name: "brisket", fat: "82.9", fatSaturated: "33.2", sodium: "217", potassium: "781", cholesterol: "487", carbohydrates: "0.0", fiber: "50.0", sugar: "10.0"),
        NutritionModel(name: "soup", fat: "1", fatSaturated: "0.3", sodium: "217", potassium: "781", cholesterol: "487", carbohydrates: "0.0", fiber: "50.0", sugar: "10.0"),
        NutritionModel(name: "dal", fat: "82.9", fatSaturated: "33.2", sodium: "200", potassium: "133", cholesterol: "487", carbohydrates: "0.0", fiber: "5.0", sugar: "2.0"),
    ]
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            
            Color("lightBlue")
                .ignoresSafeArea()
            
            VStack {
                BackView()
                
                HStack {
                    Text("Nutrition Guidance")
                        .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                        .offset(x: -70)
                    
                    Spacer()
                    
                }
                .offset(x: 70)
                .padding()
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
                    TextField("Search Food Nutrition", text: $searchText)
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            nutritionVM.callListAPI(name: searchText)
                        }, label: {
                            Text("Send")
                                .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 18))
                                .foregroundStyle(Color("bluePurple"))
                        })
                        .onSubmit {
                            nutritionVM.callListAPI(name: searchText)
                        }
                        .onChange(of: !nutritionVM.arrResponseText.isEmpty) {
                            if nutritionVM.isaddItem {
                                var tempArr: [NutritionModel] = []
                                tempArr = arrOfList
                                arrOfList.removeAll()
                                
                                nutritionVM.arrResponseText.forEach { nutri in
                                    arrOfList.append(nutri)
                                }
                                
                                tempArr.forEach { temp in
                                    arrOfList.append(temp)
                                }
                                
                                tempArr.removeAll()
                                self.searchText = ""
                                self.nutritionVM.arrResponseText.removeAll()
                            }
                        }
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.white)
                        .shadow(radius: 5)
                }
                .padding()
                .offset(y: -10)
                
                ScrollView(showsIndicators: false) {
                    ForEach(arrOfList) { list in
                        NavigationLink {
                            DetailsNutritionView(nutritionDetails: list)
                                .navigationBarBackButtonHidden()
                        } label: {
                            VStack {
                                HStack(spacing: 12) {
                                    Image("Nutritio")
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
            
            if nutritionVM.isLoading {
                CustomLoadingview(isShowing: nutritionVM.isLoading)
            }
        }
    }
}

#Preview {
    NutritionGuidanceView()
}
