//
//  OnBoardingMangeView.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/23.
//

import SwiftUI

struct OnBoardingMangeView: View {
    
    @AppStorage("isWelcome") var isWelcome: Bool = false
    
    var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @State var count = 0
    
    var body: some View {
        VStack {
            
            TabView(selection: $count) {
                WalkthroughView(image: "onBordingImg1", title: "Personalized Workout", description: "personalized workout plan based on your\n fitness goals, fitness level, and schedule. This\n means that you'll have a workout plan that is\n tailored specifically to you")
                    .tag(0)
                
                WalkthroughView(image: "onBordingImg2", title: "Progress Tracking", description: "personalized workout plan based on your\n fitness goals, fitness level, and schedule. This\n means that you'll have a workout plan that is\n tailored specifically to you")
                    .tag(1)
                
                WalkthroughView(image: "onBordingImg3", title: "Nutritional Guidance", description: "personalized workout plan based on your\n fitness goals, fitness level, and schedule. This\n means that you'll have a workout plan that is\n tailored specifically to you")
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            
            Spacer()
            
            PageControl(current: count)
            
            Button {
                withAnimation(.smooth) {
                    
                    isWelcome = count == 2 ? true : false
                    count += 1
                }
            } label: {
                Text(count == 2 ? "Get Started" : "Next")
                    .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(ASFCapsuleButtonStyle())
            .padding()
            .navigationDestination(isPresented: $isWelcome) {
                SignInView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

struct OnBoardingMangeView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingMangeView()
            .environmentObject(GoogleAutheticationViewModel())
            .environmentObject(EmailAuthenticationViewModel())
    }
}

struct PageControl: UIViewRepresentable {
    
    var current = 0
    
    func makeUIView(context: UIViewRepresentableContext<PageControl>) -> UIPageControl {
        
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = UIColor(Color("Primary"))
        page.numberOfPages = 3
        page.pageIndicatorTintColor = .gray
        
        return page
    }
    
    func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<PageControl>) {
        uiView.currentPage = current
    }
}
