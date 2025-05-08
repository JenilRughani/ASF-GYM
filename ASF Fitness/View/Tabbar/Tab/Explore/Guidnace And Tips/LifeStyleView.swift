//
//  LifeStyleView.swift
//  ASF
//
//  Created by Jenil Rughani on 27/03/25.
//

import SwiftUI

struct LifeStyleView: View {
    
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var age: String = ""
    @State private var gender: String = "male"
    @State private var isStartLoader : Bool = false
    @State private var isAlertView : Bool = false
    @State private var isMoveAnsVc : Bool = false
    
    var body: some View {
        ZStack {
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
                        
                        Text("Add LifeData")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 30))
                            .foregroundStyle(Color("bluePurple"))
                    }
                    
                    Spacer()
                    
                }
                .padding([.bottom, .horizontal])
                
                //MARK: - Textfileds
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 18) {
                        
                        HStack {
                            Text("Your height:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        TextField("Enter Height (cm)", text: $height)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                        
                        HStack {
                            Text("Your weight:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        TextField("Enter Weight (kg)", text: $weight)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                        
                        HStack {
                            Text("Your age:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        TextField("Enter Age (years)", text: $age)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                        
                        HStack {
                            Text("Select Gender:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        Picker("Select Gender", selection: $gender) {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }
                        .pickerStyle(.wheel)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(uiColor: UIColor.systemGray6))
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        height = ""
                        weight = ""
                        age = ""
                        gender = ""
                    }, label: {
                        Text("Clear")
                            .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(ASFCapsuleButtonStyle())
                    
                    Button(action: {
                        if height.isEmpty || weight.isEmpty || age.isEmpty || gender.isEmpty {
                            isAlertView = true
                        } else {
                            isStartLoader = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.isStartLoader = false
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    self.isMoveAnsVc = true
                                }
                            }
                        }
                    }, label: {
                        Text("Calculate")
                            .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(ASFCapsuleButtonStyle())
                    .alert("Data is Empty", isPresented: $isAlertView) {
                        Button(action: {
                            height = ""
                            weight = ""
                            age = ""
                            gender = ""
                        }, label: {
                            Text("OK")
                        })
                    }
                    .navigationDestination(isPresented: $isMoveAnsVc) {
                        
                        let heightDouble = Double(height) ?? 150
                        let weightDouble = Double(weight) ?? 50
                        let ageInt = Int(Double(age) ?? 20)
                        
                        AnswerLifestyleView(lifeData: LifestyleModel(height: heightDouble, weight: weightDouble, age: ageInt, gender: gender))
                            .navigationBarBackButtonHidden()
                    }
                }
                .padding(.horizontal)
            }
         
            if isStartLoader {
               CustomLoadingview(isShowing: isStartLoader)
            }
        }
    }
}

#Preview {
    LifeStyleView()
}
