//
//  AboutUsView.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/25.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        VStack {
            BackView()
            
            HStack(content: {
                Text("About Us")
                    .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                
                Spacer()
            })
            .padding([.bottom,.horizontal])
            
            ScrollView(showsIndicators: false) {
                Image("backImage")
                    .resizable()
                    .scaledToFill()
                    .overlay {
                        Color.black.opacity(0.25)
                            .overlay {
                                Image("ASF")
                                    .resizable()
                                    .scaledToFit()
                                                .frame(width: 130)
                                    .foregroundStyle(.white)
                            }
                    }
                
                Text("""
The ASF Gym App is a comprehensive fitness application designed to help users improve their health and wellness through structured workouts, nutrition guidance, AI assistance, and health tracking. The app consists of four main sections: Explore, Stats, AI, and Profile.

In the Explore section, users can access various fitness-related resources. The Workout Categories feature allows users to browse six different workout categories, including Upper Arms, Cardio & Strength, Chest, Lower Legs, Shoulder, and Waist. Each category provides details such as the targeted body part, required equipment, and step-by-step instructions. Additionally, the Helps & Tips section offers four key functionalities: Nutrition Helper, which provides detailed nutritional information such as fat content, sodium levels, and carbohydrates; Food & Recipes, where users can explore healthy meal ideas with images, descriptions, and health ratings; Meditation & Yoga, which features various yoga poses with images, category names, benefits, and detailed descriptions; and Lifestyle Progress, where users can input their height, weight, age, and gender to calculate their BMI, BMR, and overall fitness status. The Fitness Guides section offers a collection of guides that users can tap on to view detailed descriptions and images. Lastly, the Health & Tips section provides valuable health insights through informative articles.

The Stats section allows users to log and track their daily health data, including steps, heart rate, training activities, calories burned, sleep patterns, and distance traveled. This section also includes a custom calendar view, enabling users to view their fitness progress based on date and time.

The AI section offers an interactive chat feature where users can engage in conversations related to health and fitness. Additionally, users can personalize their chat experience by changing the message color theme.

The Profile section provides users with an overview of their personal details, including their profile picture, name, and email. It includes three main functionalities: Health Settings, where users can add and view daily health data; Help & Support, which provides access to sections such as About Us, Contact Us (with title, email, and description), Terms & Conditions, and an option to rate the app; and Account Settings, where users can edit their account information or sign out.

With its combination of workout planning, health tracking, AI assistance, and user-friendly profile management, the ASF Gym App serves as a complete fitness companion for users looking to maintain a healthy lifestyle.
""")
                .padding()
            }
        }
    }
}

#Preview {
    AboutUsView()
}
