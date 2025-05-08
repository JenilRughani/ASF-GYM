//
//  SpecificHealthFitnessView.swift
//  ASF
//
//  Created by Jenil Rughani on 26/03/25.
//

import SwiftUI
import Kingfisher

struct SpecificHealthFitnessView: View {
    
    var healthModel: HealthFitnessModel
    
    var body: some View {
        VStack {
            BackView()
            
            ScrollView(showsIndicators: false) {
                Text(healthModel.title)
                    .font(.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                    .padding(12)
                
                HStack(content: {
                    Text("By ASF")
                        .foregroundStyle(.gray)
                    
                    Spacer()
                })
                .padding([.horizontal, .bottom])
                
                KFImage(URL(string: healthModel.urlToImage))
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 260)
                    .scaledToFit()
                
                Group {
                    Text(healthModel.description)
                        .font(.caustenFont(customFontName: .CaustenRegular, fontSize: 18))
                        .padding()
                    
                }
                
                HStack(content: {
                    Text("Publish at \(healthModel.publishedAt)")
                        .font(.caustenFont(customFontName: .CaustenRegular, fontSize: 16))
                        .foregroundStyle(.gray)
                    
                    Spacer()
                })
                .padding(.horizontal)
                
                Button(action: {
                    UIApplication.shared.open(URL(string: healthModel.url) ?? URL(string: "https://news.google.com/home?hl=en-IN&gl=IN&ceid=IN:en")!)
                }, label: {
                    Text("Read More")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 20))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                })
                .padding()
                .buttonStyle(ASFCapsuleButtonStyle())
            }
        }
    }
}

#Preview {
    SpecificHealthFitnessView(healthModel: HealthFitnessModel(title: "The #1 Morning Habit to Break for Weight Loss, According to Dietitians - EatingWell", author: "https://www.facebook.com/EatingWell/", urlToImage: "https://www.eatingwell.com/thmb/81ypzinmbpC6zKmIBmVNCtbydpo=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/weight-loss-habit-mar-2025-39f7899763294421b8975350316d9a56.jpg", url: "https://www.eatingwell.com/morning-habit-to-break-for-weight-loss-11696661", description: "Dietitians say skipping breakfast is the #1 habit to break for weight loss because it helps control cravings and hunger and averts blood sugar spikes.", content: "<ul><li>Registered dietitians say skipping breakfast is the No. 1 habit to break for weight loss.</li><li>Skipping breakfast can make you eat more later on and lead to blood sugar spikes. </li><li>In… [+6550 chars]", publishedAt: "2025-03-25T03:00:00Z"))
}
