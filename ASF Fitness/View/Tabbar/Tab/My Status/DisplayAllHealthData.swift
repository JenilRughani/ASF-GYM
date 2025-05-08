//
//  DisplayAllHealthData.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/25.
//

import SwiftUI


struct DisplayAllHealthData: View {
    @State private var isStartLoader: Bool = false
    @EnvironmentObject var healthDataVM: HealthViewModel
    
    var healthData: [HealthModel] = [
        HealthModel(steps: "120", heartRate: "100", training: "100", calories: "500", sleep: "8", distance: "5.5", dateTime: Date()),
        HealthModel(steps: "100", heartRate: "110", training: "100", calories: "1000", sleep: "10", distance: "5.8", dateTime: Date()),
    ]
    
    var body: some View {
        VStack {
            BackView()
            
            //MARK: - Img
            HStack {
                
                VStack(alignment: .leading) {
                    Image("ASF")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .foregroundStyle(Color("bluePurple"))
                    
                    Text("Health Data")
                        .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 30))
                        .foregroundStyle(Color("bluePurple"))
                    
                }
                
                Spacer()
                
                if isStartLoader {
                    ProgressView()
                }
            }
            .padding([.bottom, .horizontal])
            
            if healthDataVM.healthData.isEmpty {
                Spacer()
                
                Image("noData")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaledToFit()
                
                Text("No Data Found")
                    .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 20))
                    .foregroundStyle(.gray)
                
                Spacer()
            } else {
                List {
                    ForEach(healthDataVM.healthData.sorted(by: { $0.dateTime > $1.dateTime })) { data in
                        
                        HStack {
                            Spacer()
                            
                            Text(dateFormatted(data.dateTime))
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("bluePurple"))
                        }
                        
                        VStack {
                            HStack {
                                Text("Steps:")
                                    .font(.title3)
                                
                                Spacer()
                                
                                Text(data.steps)
                                    .foregroundStyle(Color("bluePurple"))
                            }
                            
                            HStack {
                                Text("Calories:")
                                    .font(.title3)
                                
                                Spacer()
                                
                                Text(data.calories)
                                    .foregroundStyle(Color("bluePurple"))
                            }
                            
                            HStack {
                                Text("Training:")
                                    .font(.title3)
                                
                                Spacer()
                                
                                Text(data.training)
                                    .foregroundStyle(Color("bluePurple"))
                            }
                            
                            HStack {
                                Text("Sleep:")
                                    .font(.title3)
                                
                                Spacer()
                                
                                Text(data.sleep)
                                    .foregroundStyle(Color("bluePurple"))
                            }
                            
                            HStack {
                                Text("Distance:")
                                    .font(.title3)
                                
                                Spacer()
                                
                                Text(data.distance)
                                    .foregroundStyle(Color("bluePurple"))
                            }
                        }
                    }
                    .onDelete(perform: healthDataVM.deleteHealthData)
                }
            }
        }
    }
}

#Preview {
    DisplayAllHealthData()
        .environmentObject(HealthViewModel())
}
