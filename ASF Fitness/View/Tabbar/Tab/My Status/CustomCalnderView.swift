//
//  CustomCalnderView.swift
//  ASF
//
//  Created by Jenil Rughani on 22/03/25.
//

import SwiftUI

struct CustomCalnderView: View {
    
    @State private var selectedDate: Date = Date()
    @Environment(\.dismiss) var dismiss
    @StateObject var calenderVM = CalenderViewModel() // Ensure it initializes

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
                
                Text("Calendar View")
                    .font(.title)
                    .fontWeight(.bold)
                    .offset(x: -8)
                
                Spacer()
            }
            .padding([.horizontal, .top])
            
            // Date Picker
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding([.bottom, .horizontal])
            
            Divider()
            
            // Filter events for the selected date
            let filteredEvents = calenderVM.events(for: selectedDate)
            
            if filteredEvents.isEmpty {
                VStack {
                    Image(systemName: "tray.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    
                    Text("No data found")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding()
                
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(filteredEvents) { event in
                        HStack(spacing: 15) {
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(event.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(event.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                                    .truncationMode(.middle)
                                
                                Text(FormattedDate(event.date))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(uiColor: UIColor.systemGray5)))
                        .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear {
            calenderVM.loadSampleEvents() 
        }
    }
    
    // Helper Function to Format Time
    func FormattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)
    }
}

// Preview
#Preview {
    CustomCalnderView()
}
