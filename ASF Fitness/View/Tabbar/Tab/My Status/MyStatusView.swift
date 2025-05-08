//
//  MyStatusView.swift
//  ASF
//
//  Created by Jenil Rughani on 21/03/23.
//

import SwiftUI


struct MyStatusView: View {
    
    @State private var isOpenCalender: Bool = false
    @State private var isAddData: Bool = false
    @State private var isOpenShareView: Bool = false
    @State private var isOpenListView: Bool = false
    @State private var isLoadData: Bool = false
    @State private var latestEntry: HealthModel? = nil
    @State private var isAnimating = false
    @State private var circleProgress: CGFloat = 0.75
    private var circlePercentage: Int { Int(circleProgress * 100.0) }
    @EnvironmentObject var healthDataVM: HealthViewModel
    
    var body: some View {
        ZStack {
            VStack {
                HStack(content: {
                    Text("My Stats")
                        .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                    
                    Spacer()
                    
                    Button(action: {
                        isOpenCalender = true
                    }, label: {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    })
                    .navigationDestination(isPresented: $isOpenCalender, destination: {
                        CustomCalnderView()
                            .navigationBarBackButtonHidden()
                    })
                    .padding(.trailing)
                    
                    Button(action: {
                        withAnimation {
                            isOpenListView = true
                        }
                    }, label: {
                        Image(systemName: "list.dash.header.rectangle")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    })
                    .navigationDestination(isPresented: $isOpenListView) {
                        DisplayAllHealthData()
                            .navigationBarBackButtonHidden()
                            .environmentObject(healthDataVM)
                    }
                })
                .padding()
                
                if  latestEntry != nil {
                    
                    ScrollView(showsIndicators: false) {
                        
                        //MARK: - Steps
                        HStack(alignment: .center) {
                            
                            Circle()
                                .trim(from: 0, to: 1)
                                .stroke(.gray.opacity(0.15),
                                        style: StrokeStyle(lineWidth: 8,
                                                           lineCap: CGLineCap.round))
                                .frame(height: 80)
                                .rotationEffect(.degrees(-90))
                                .overlay(
                                    Circle()
                                        .trim(from: 0, to: circleProgress)
                                        .stroke(Color("bluePurple"),
                                                style: StrokeStyle(lineWidth: 8,
                                                                   lineCap: CGLineCap.round))
                                        .frame(height: 80)
                                        .rotationEffect(.degrees(-90))
                                        .overlay(
                                            Text("\(latestEntry?.steps ?? "1000") \nSteps")
                                                .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 18))
                                                .fontWeight(.semibold)
                                                .foregroundColor(.black))
                                        .multilineTextAlignment(.center)
                                        .onAppear {
                                            circleProgress = 0.0
                                            
                                            withAnimation(.smooth) {
                                                circleProgress = 0.75
                                            }
                                        }
                                )
                                .multilineTextAlignment(.center)
                            
                            VStack(alignment: .leading) {
                                Text("Steps:")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 8)
                                
                                HStack {
                                    Text("\(latestEntry?.steps ?? "1000")")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.purple)
                                    
                                    Text("/ 10,000")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                }
                            }
                            .padding(.leading)
                            
                            Spacer()
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(uiColor: UIColor.systemGray5))
                                .shadow(radius: 2)
                        }
                        .padding()
                        
                        //MARK: - heart
                        HStack(alignment: .top) {
                            
                            Image("heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .scaleEffect(isAnimating ? 1.1 : 0.8)
                                .opacity(isAnimating ? 0.8 : 1.0)
                                .animation(Animation.easeInOut(duration: 0.85).repeatCount(3, autoreverses: true), value: isAnimating)
                                .onAppear {
                                    isAnimating = true
                                }
                            
                            VStack(alignment: .leading) {
                                Text("Heart Rate:")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 8)
                                
                                HStack {
                                    Text("\(latestEntry?.heartRate ?? "75")")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.purple)
                                    
                                    Text("/ 100")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                }
                            }
                            .padding(.leading, 20)
                            
                            Spacer()
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(uiColor: UIColor.systemGray5))
                                .shadow(radius: 2)
                        }
                        .padding([.bottom,.horizontal])
                        
                        //MARK: - Training
                        HStack(alignment: .top) {
                            
                            Image("alarm-clock")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .rotationEffect(.degrees(isAnimating ? 0 : 12))
                                .animation(Animation.easeInOut(duration: 0.25).repeatCount(4, autoreverses: true), value: isAnimating)
                                .onAppear {
                                    isAnimating = true
                                }
                            
                            VStack(alignment: .leading) {
                                Text("Training:")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 8)
                                
                                HStack {
                                    Text("\(latestEntry?.training ?? "75")")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.purple)
                                    
                                    Text("minutes")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                }
                            }
                            .padding(.leading, 20)
                            
                            Spacer()
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(uiColor: UIColor.systemGray5))
                                .shadow(radius: 2)
                        }
                        .padding([.bottom,.horizontal])
                        
                        //MARK: - Training
                        HStack(alignment: .top) {
                            
                            Image("calories")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .scaleEffect(isAnimating ? 1 : 0.8)
                                .animation(Animation.easeInOut(duration: 0.85).repeatCount(1, autoreverses: true), value: isAnimating)
                                .onAppear {
                                    isAnimating = true
                                }
                            
                            VStack(alignment: .leading) {
                                Text("Calories:")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 8)
                                
                                HStack {
                                    Text("\(latestEntry?.calories ?? "900")")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.purple)
                                    
                                    Text("cal")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                }
                            }
                            .padding(.leading, 20)
                            
                            Spacer()
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(uiColor: UIColor.systemGray5))
                                .shadow(radius: 2)
                        }
                        .padding([.bottom,.horizontal])
                        
                        //MARK: - Sleep
                        HStack(alignment: .top) {
                            
                            Image("sleep")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .scaleEffect(isAnimating ? 1 : 0.8)
                                .animation(Animation.easeInOut(duration: 0.85).repeatCount(1, autoreverses: true), value: isAnimating)
                                .onAppear {
                                    isAnimating = true
                                }
                            
                            VStack(alignment: .leading) {
                                Text("Sleep:")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 8)
                                
                                HStack {
                                    Text("\(latestEntry?.sleep ?? "5")")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.purple)
                                    
                                    Text("/ 8 hr")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                }
                            }
                            .padding(.leading, 20)
                            
                            Spacer()
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(uiColor: UIColor.systemGray5))
                                .shadow(radius: 2)
                        }
                        .padding([.bottom,.horizontal])
                        
                        //MARK: - Distance
                        HStack(alignment: .top) {
                            
                            Image("distance")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                                .scaleEffect(isAnimating ? 1 : 0.8)
                                .animation(Animation.easeInOut(duration: 0.85).repeatCount(1, autoreverses: true), value: isAnimating)
                                .onAppear {
                                    isAnimating = true
                                }
                            
                            VStack(alignment: .leading) {
                                Text("Distance:")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 8)
                                
                                HStack {
                                    Text("\(latestEntry?.distance ?? "10")")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.purple)
                                    
                                    Text("/ 60 min")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                }
                            }
                            .padding(.leading, 20)
                            
                            Spacer()
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(uiColor: UIColor.systemGray5))
                                .shadow(radius: 2)
                        }
                        .padding([.bottom,.horizontal])
                    }
                    
                    HStack {
                        
                        Button {
                            withAnimation {
                                isOpenShareView = true
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
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(.black)
                                .frame(height: 50)
                        }
                        
                        Button {
                            withAnimation {
                                isAddData = true
                            }
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                    .fontWeight(.bold)
                                
                                Text("ADD DATA")
                                    .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 18))
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(.black)
                                .frame(height: 50)
                        }
                        .navigationDestination(isPresented: $isAddData) {
                            AddHealthData()
                                .navigationBarBackButtonHidden()
                                .environmentObject(healthDataVM)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                else {
                    VStack {
                        Spacer()
                        
                        Image("health1")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .scaledToFit()
                            .foregroundStyle(Color("bluePurple"))
                        
                        Text("Add Health Data")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                isAddData = true
                            }
                        } label: {
                            HStack {
                                Image(systemName: "plus")
                                    .fontWeight(.bold)
                                
                                Text("ADD DATA")
                                    .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 18))
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.white)
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color("bluePurple"))
                                .frame(height: 50)
                        }
                        .navigationDestination(isPresented: $isAddData) {
                            AddHealthData()
                                .navigationBarBackButtonHidden()
                                .environmentObject(healthDataVM)
                        }
                        .padding()
                    }
                }
                
                Spacer()
            }
            
            if isOpenShareView {
                CustomShareView(model: healthDataVM.latestHealthData()!, isOpen: $isOpenShareView)
            }
        }
        .onAppear {
            healthDataVM.loadData()
            latestEntry = healthDataVM.latestHealthData()
            
            circleProgress = CGFloat((Double(latestEntry?.steps ?? "1000") ?? 1000) / 10000)
        }
    }
}

struct MyStatusView_Previews: PreviewProvider {
    static var previews: some View {
        MyStatusView()
            .environmentObject(HealthViewModel())
    }
}
