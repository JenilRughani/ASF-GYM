//
//  NotifyView.swift
//  ASF
//
//  Created by Jenil Rughani on 16/03/25.
//

import SwiftUI
import UserNotifications

struct NotifyView: View {
    
    @StateObject var notificationManager = NotificationManagerViewModel()
    var arrOfNotiufy: [NotificationModel] = [
        NotificationModel(id: UUID().uuidString, title: "hii", body: "welcome to Asf GYM", date: getCurrentDate()),
        NotificationModel(id: UUID().uuidString, title: "Hello", body: "it's Gym Time!", date: getCurrentDate()),
    ]
    
    var body: some View {
        ZStack {
            VStack {
                BackView()
                
                HStack {
                    Text("Notification")
                        .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                if notificationManager.notifications.isEmpty {
                    
                    Spacer()
                    
                    Image("emptyNotifiy")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .scaledToFit()
                    
                    Text("No Notification")
                        .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 18))
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(notificationManager.notifications, id: \.id) { notify in
                            
                            HStack(alignment: .center, spacing: 15) {
                                Image("notification-bell")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80)
                                
                                VStack(alignment: .leading ,spacing: 15) {
                                    VStack(alignment: .leading ,spacing: 10) {
                                        Text("Title:")
                                            .font(.caustenFont(customFontName: .CaustenBold, fontSize: 20))
                                        
                                        Text(notify.title.capitalized)
                                            .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 18))
                                            .foregroundStyle(.blue)
                                    }
                                    
                                    VStack(alignment: .leading ,spacing: 10) {
                                        Text("Description:")
                                            .font(.caustenFont(customFontName: .CaustenBold, fontSize: 20))
                                        
                                        Text(notify.body.capitalized)
                                            .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 18))
                                            .foregroundStyle(.blue)
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(uiColor: UIColor.systemGray6))
                                    .shadow(radius: 1)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
            
            if notificationManager.isLoadView {
                CustomLoadingview(isShowing: notificationManager.isLoadView)
            }
        }
        .onAppear {
            notificationManager.getNotifyAllData(email: email)
        }
    }
}

#Preview {
    NotifyView()
}
