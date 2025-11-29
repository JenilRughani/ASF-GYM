//
//  AddHealthData.swift
//  ASF
//
//  Created by Jenil Rughani on 17/03/25.
//

import SwiftUI

struct AddHealthData: View {
    @State private var steps: String = ""
    @State private var heartRate: String = ""
    @State private var traning: String = ""
    @State private var cal: String = ""
    @State private var sleep: String = ""
    @State private var distance: String = ""
    @State private var isAlertView: Bool = false
    @State private var isStartLoader: Bool = false
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var healthDataVM: HealthViewModel
    
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
                        
                        Text("Add HealthData")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 30))
                            .foregroundStyle(Color("bluePurple"))
                        
                    }
                    
                    Spacer()
                }
                .padding([.bottom, .horizontal])
                
                Spacer()
                
                //MARK: - Textfileds
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 18) {
                        
                        HStack {
                            Text("Add your steps:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        TextField("12334", text: $steps)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                        
                        HStack {
                            Text("Add your heart rate:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        TextField("120 bmp", text: $heartRate)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                        
                        HStack {
                            Text("Add your training:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        TextField("120 min", text: $traning)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                        
                        HStack {
                            Text("Add your calories:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        TextField("990 cal", text: $cal)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                        
                        HStack {
                            Text("Add your sleep:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        TextField("7.5 hr", text: $sleep)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                        
                        HStack {
                            Text("Add your distance:")
                                .foregroundStyle(.black)
                                .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            
                            Spacer()
                        }
                        .padding([.top, .horizontal])
                        
                        TextField("55 min", text: $distance)
                            .padding()
                            .foregroundColor(.black)
                            .autocorrectionDisabled(true)
                            .keyboardType(.numberPad)
                            .background {
                                RoundedRectangle(cornerRadius: 35)
                                    .fill(Color(UIColor(named: "textfileColor")!).opacity(0.5))
                            }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        clearFields()
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
                        if steps.isEmpty || heartRate.isEmpty || traning.isEmpty || cal.isEmpty || sleep.isEmpty || distance.isEmpty {
                            isAlertView = true
                        } else {
                            
                            isStartLoader = true
                            
                            healthDataVM.addHealthData(steps: steps, heartRate: heartRate, training: traning, calories: cal, sleep: sleep, distance: distance)
                            
                            clearFields()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.isStartLoader = false
                                dismiss.callAsFunction()
                            }
                        }
                    }, label: {
                        Text("Save")
                            .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(ASFCapsuleButtonStyle())
                    .alert("Somethings Wrongs", isPresented: $isAlertView) {
                        Button(action: {
                            steps = ""
                            heartRate = ""
                            traning = ""
                            cal = ""
                            sleep = ""
                            distance = ""
                        }, label: {
                            Text("OK")
                        })
                    }
                }
                .padding(.horizontal)
            }
            
            if isStartLoader {
                CustomLoadingview(isShowing: isStartLoader)
            }
        }
        .onDisappear {
            // healthDataVM.latestHealthData()
        }
    }
    
    //  Clear Fields
    func clearFields() {
        steps = ""
        heartRate = ""
        traning = ""
        cal = ""
        sleep = ""
        distance = ""
    }
}

#Preview {
    AddHealthData()
        .environmentObject(HealthViewModel())
}
