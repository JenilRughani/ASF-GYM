//
//  Settingview.swift
//  ASF
//
//  Created by Jenil Rughani on 16/03/25.
//

import SwiftUI

struct Settingview: View {
    
    @State private var messages: [String] = ["[USER]" + "hi", "Hi there", "[USER]" + "How are your?", "I'm fine", "[USER]" + "By", "By"]
    @Binding var chatColor: ChatColorTheme
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
                
                Text("Chat Theme")
                    .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                    .offset(x: -10)
                
                Spacer()
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                
                //MARK: - Chat
                ScrollView(showsIndicators: false) {
                    
                    ForEach(messages, id: \.self) { mess in
                        if mess.contains("USER") {
                            
                            let newMessage = mess.replacingOccurrences(of: "[USER]", with: "")
                            
                            HStack {
                                Spacer()
                                Text(newMessage)
                                    .padding()
                                    .foregroundColor(.black)
                                    .background(Color(chatColor.rawValue))
                                    .cornerRadius(8)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                            }
                        }
                        else {
                            HStack {
                                Text(mess)
                                    .padding()
                                    .foregroundColor(.black)
                                    .background(.gray.opacity(0.25))
                                    .cornerRadius(8)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                                Spacer()
                            }
                        }
                    }
                    .rotationEffect(.degrees(180))
                }
                .rotationEffect(.degrees(180))
                .scrollIndicators(.never)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .shadow(radius: 2)
                }
                .padding()
                
                //MARK: - HEading
                HStack {
                    Text("Select Color Theme:")
                        .font(Font.caustenFont(customFontName: .CaustenSemiBold, fontSize: 23))
                    
                    Spacer()
                }
                .padding([.horizontal])
                
                //MARK: - Color Buttons
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        
                        Button(action: {
                            chatColor = .lightBlue
                        }, label: {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color("lightBlue"))
                                .shadow(radius: 2)
                                .frame(width: 65, height: 65)
                        })
                        
                        Button(action: {
                            chatColor = .lightPink
                        }, label: {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color("lightPink"))
                                .shadow(radius: 2)
                                .frame(width: 65, height: 65)
                        })
                        
                        Button(action: {
                            chatColor = .lightYellow
                        }, label: {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color("lightYellow"))
                                .shadow(radius: 2)
                                .frame(width: 65, height: 65)
                        })
                        
                        Button(action: {
                            chatColor = .textfileColor
                        }, label: {
                            RoundedRectangle(cornerRadius: 50)
                                .fill(Color("textfileColor"))
                                .shadow(radius: 2)
                                .frame(width: 65, height: 65)
                        })
                    }
                    .padding(.leading, 20)
                }
                .padding()
            }
        }
        .background {
            Color(uiColor: .systemGray6)
                .ignoresSafeArea()
        }
        .onDisappear {
            //chatColorTheme = chatColor
        }
    }
}

#Preview {
    Settingview(chatColor: .constant(.lightBlue))
}
