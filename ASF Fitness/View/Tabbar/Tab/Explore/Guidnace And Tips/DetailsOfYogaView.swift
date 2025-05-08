//
//  DetailsOfYogaView.swift
//  ASF
//
//  Created by Jenil Rughani on 03/04/25.
//

import SwiftUI

struct DetailsOfYogaView: View {
    
    var yodaDetails: YogaModel
    @State private var isShowingShareSheet = false
    @State private var shareText = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
                    dismiss.callAsFunction()
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .font(.title3)
                        .fontWeight(.bold)
                })
                
                Spacer()
                
                Text("Yoga Details")
                    .font(.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                    .offset(x: -10)
                
                Spacer()
            }
            .padding()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        AsyncImage(url: URL(string: yodaDetails.img)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120)
                            } else {
                                ProgressView()
                                    .tint(Color("bluePurple"))
                            }
                        }
                        .padding()
                        .background {
                            Circle()
                                .fill(Color(uiColor: UIColor.systemGray6))
                        }
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Yoga name:")
                                    .font(.caustenFont(customFontName: .CaustenBold, fontSize: 23))
                                
                                Text(yodaDetails.englishName)
                                    .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                                    .foregroundStyle(Color("bluePurple"))
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Category Name:")
                                    .font(.caustenFont(customFontName: .CaustenBold, fontSize: 23))
                                
                                Text(yodaDetails.englishName)
                                    .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                                    .foregroundStyle(Color("bluePurple"))
                            }
                            
                        }
                        .padding(.leading)
                        
                        Spacer()
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Pose Benefits:")
                            .font(.caustenFont(customFontName: .CaustenBold, fontSize: 23))
                        
                        Text(yodaDetails.pose_benefits)
                            .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            .foregroundStyle(Color("bluePurple"))
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Pose Description:")
                            .font(.caustenFont(customFontName: .CaustenBold, fontSize: 23))
                        
                        Text(yodaDetails.pose_description)
                            .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                            .foregroundStyle(Color("bluePurple"))
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
            
            Button(action: {
                isShowingShareSheet = true
            }, label: {
                Text("Share")
                    .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 22))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(ASFCapsuleButtonStyle())
            .padding(.horizontal)
            .sheet(isPresented: $isShowingShareSheet) {
                ShareSheet(items: [shareText])
            }
        }
        .onAppear {
            shareText = """
    Category Name: \(yodaDetails.catName),
    Yoga Name: \(yodaDetails.englishName),
    Pose Benefits: \(yodaDetails.pose_benefits),
    Pose Description: \(yodaDetails.pose_description),
"""
        }
    }
}

#Preview {
    DetailsOfYogaView(yodaDetails: YogaModel(img: "https://res.cloudinary.com/dko1be2jy/image/upload/fl_sanitize/v1676483071/yoga-api/1_txmirf.png", catName: "Core Yoga", englishName: "Boat", pose_description: "From a seated position the feet are lifted up so that the thighs are angled about 45-50 degrees relative to the earth.  The tailbone is lengthened into the earth and the pubis pulls toward the navel.  The shoulder blades are spread across the back and the hands reach around the back of the calves, with legs pulled towards the body.  The chin is tipped slightly toward the sternum so that the base of the skull lifts lightly away from the back of the neck.  Gaze is forward.",                                   pose_benefits: "Strengthens the abdomen, hip flexors, and spine.  Stimulates the kidneys, thyroid and prostate glands, and intestines.  Helps relieve stress.  Improves digestion."))
}
