//
//  WorkoutCategoriesView.swift
//  ASF
//
//  Created by Jenil Rughani on 13/03/25.
//

import SwiftUI

struct WorkoutCategoriesView: View {
    
    @State private var search: String = ""
    @State private var searchText: String = ""
    @State private var isSearch: Bool = false
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack {
            BackView()
            
            HStack {
                Text("Workout Categories")
                    .font(Font.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                
                Spacer()
            }
            .padding([.bottom, .horizontal])
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                TextField("Search something", text: $search)
                    .foregroundColor(.primary)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onSubmit {
                        withAnimation {
                            searchText = search
                            isSearch = true
                        }
                    }
                
                if !search.isEmpty {
                    Button(action: {
                        withAnimation {
                            search = ""
                            searchText = ""
                            isSearch = false
                        }
                    }, label: {
                        Image(systemName: "multiply.circle.fill")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    })
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background {
                RoundedRectangle(cornerRadius: 40)
                    .fill(.gray.opacity(0.2))
            }
            .padding(.horizontal)
            
            ScrollView(showsIndicators: false) {
                if !searchText.isEmpty && isSearch, let exactMatch = arrOFWorkout.first(where: { $0.name.localizedCaseInsensitiveCompare(searchText) == .orderedSame }) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        VStack {
                            NavigationLink {
                                SpecificCategoryView(cat: exactMatch)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                WorkoutView(name: exactMatch.name, img: exactMatch.img, color: exactMatch.color)
                            }
                        }
                        .padding(.top, 10)
                    }
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(arrOFWorkout) { workout in
                            NavigationLink {
                                SpecificCategoryView(cat: workout)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                WorkoutView(name: workout.name, img: workout.img, color: workout.color)
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    WorkoutCategoriesView()
}
