//
//  AIChatView.swift
//  ASF
//
//  Created by Jenil Rughani on 14/03/25.
//

import SwiftUI

struct AIChatView: View {
    
    @State private var messageText: String = ""
    @State private var alertMessage: String = ""
    @State private var messages: [String] = []
    @State private var isAlert: Bool = false
    @State private var isLoader: Bool = false
    @StateObject var geminiVM: AIChatViewModel = AIChatViewModel()
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("chatColorTheme") var chatColorTheme: ChatColorTheme = .lightBlue
    @AppStorage("AIChat") private var storedMessages: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                //MARK: - Header
                HStack {
                    
                    Text("AI Chat")
                        .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            messages = []
                            saveMessages()
                        }
                    } label: {
                        Image(systemName: "xmark.bin.fill")
                            .foregroundColor(Color("bluePurple"))
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .padding(.trailing)
                    
                    NavigationLink {
                        Settingview(chatColor: $chatColorTheme)
                            .navigationBarBackButtonHidden()
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(Color("bluePurple"))
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                }
                .padding()
                
                //MARK: - Message View
                
                if messages.isEmpty {
                    
                    Spacer()
                    
                    Image("noData")
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                    Text("No Data Found")
                        .font(.caustenFont(customFontName: .CaustenSemiBold, fontSize: 16))
                    
                    Spacer()
                    
                } else {
                    ScrollView(showsIndicators: false) {
                        
                        ForEach(messages, id: \.self) { mess in
                            if mess.contains("USER") {
                                
                                let newMessage = mess.replacingOccurrences(of: "[USER]", with: "")
                                
                                HStack {
                                    Spacer()
                                    Text(newMessage)
                                        .padding()
                                        .foregroundColor(.black)
                                        .background(Color(chatColorTheme.rawValue))
                                        .cornerRadius(8)
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 10)
                                        .contextMenu {
                                            Button(role: .destructive) {
                                                deleteMessage(mess)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
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
                }
                
                //MARK: - Textfiled
                HStack{
                    TextField("Message...", text: $messageText)
                        .padding()
                        .frame(height: 60)
                        .autocorrectionDisabled(true)
                        .cornerRadius(30)
                        .onSubmit {
                            if messageText.isEmpty {
                                alertMessage = "Please enter a text in textfiled."
                                isAlert = true
                            } else {
                                sentMessage(message: messageText)
                            }
                        }
                    
                    Button {
                        if messageText.isEmpty {
                            alertMessage = "Please enter a text in textfiled."
                            isAlert = true
                        } else {
                            sentMessage(message: messageText)
                        }
                    } label: {
                        Text("Send")
                            .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("bluePurple"))
                    }
                    .padding(.trailing, 20)
                }
                .background(.gray.opacity(0.15)).clipShape(RoundedRectangle(cornerSize: .init(width: 50, height: 50)))
                .padding(.horizontal)
            }
            .alert(isPresented: $isAlert, content: {
                Alert(title: Text("Alert"), message: Text(alertMessage))
            })
        }
        .overlay {
            if isOnDataConnection {
                CustomLoadingview(isShowing: geminiVM.isLoading)
            } else {
                if isLoader {
                    CustomLoadingview(isShowing: isLoader)
                }
            }
        }
        .onAppear {
            loadMessages()
            
            if !isOnDataConnection {
                isAlert = true
                alertMessage = "You are offline mode, please check your internet connection."
            }
        }
        .onDisappear {
            saveMessages()
        }
    }
    
    //MARK: - Delete Message
    func deleteMessage(_ message: String) {
        if let index = messages.firstIndex(of: message) {
            messages.remove(at: index)
            saveMessages()
        }
    }
    
    
    //MARK: - sentMessage
    func sentMessage(message: String) {
        withAnimation {
            
            messages.append("[USER]" + message)
            
            if isOnDataConnection {
                saveMessages()
                
                Task {
                    await geminiVM.fetchGeminiResponse(query: message)
                    
                    DispatchQueue.main.async {
                        withAnimation {
                            messages.append(geminiVM.responseText)
                            saveMessages()
                        }
                    }
                }
            } else {
                
                isLoader = true
                
                withAnimation {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.isLoader = false
                        messages.append(replayMessage(message: message))
                    }
                }
            }
            
            self.messageText = ""
        }
    }
    
    //MARK: - saveMessages
    func saveMessages() {
        if let data = try? JSONEncoder().encode(messages),
           let jsonString = String(data: data, encoding: .utf8) {
            storedMessages = jsonString
            debugPrint("Saved")
        }
    }
    
    //MARK: - loadMessages
    func loadMessages() {
        if let data = storedMessages.data(using: .utf8),
           let decodedMessages = try? JSONDecoder().decode([String].self, from: data) {
            messages = decodedMessages
        }
    }
}

#Preview {
    NavigationView {
        AIChatView()
    }
}

//MARK: - Fake Response data
func replayMessage(message: String) -> String {
    
    let tempMessage = message.lowercased()
    
    if tempMessage.contains("hello") {
        return "Hey there!"
    }
    else if tempMessage.contains("hi") {
        return "Hey there!"
    }
    else if tempMessage.contains("goodbye") {
        return "Talk to you later!"
    }
    else if tempMessage.contains("by") {
        return "Talk to you later!"
    }
    else if tempMessage.contains("how are you") {
        return "I'm fine, how about you?"
    }
    else {
        return "That's cool."
    }
}
