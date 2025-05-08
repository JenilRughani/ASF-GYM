//
//  DetailsOfRecipeView.swift
//  ASF
//
//  Created by Jenil Rughani on 25/03/25.
//

import SwiftUI

struct DetailsOfRecipeView: View {
    var recipeDetails: RecipeModel
    
    var body: some View {
        VStack {
            BackView()
            
            HStack {
                Text(recipeDetails.title)
                    .font(.caustenFont(customFontName: .CaustenBold, fontSize: 35))
                
                Spacer()
            }
            .padding([.horizontal])
            .padding(.bottom, 8)
            
            HStack {
                Text("By ASF")
                    .font(.caustenFont(customFontName: .CaustenRegular, fontSize: 18))
                
                Spacer()
            }
            .padding([.bottom, .horizontal])
            
            ScrollView(showsIndicators: false) {
                AsyncImage(url: URL(string: recipeDetails.image)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: logicalHeight/2.5, height: logicalHeight/2.5)
                            .clipShape(Rectangle())
                            .shadow(radius: 5)
                            .padding()
                    } else {
                        ProgressView()
                            .tint(Color("bluePurple"))
                    }
                }
                
                HStack {
                    Text("Health Score:")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                    
                    Spacer()
                    
                    Text("\(recipeDetails.healthScore)/100")
                        .font(.caustenFont(customFontName: .CaustenRegular, fontSize: 20))
                        .foregroundColor(Color("bluePurple"))
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Vegetarian:")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                    
                    Spacer()
                    
                    Circle()
                        .fill(recipeDetails.vegetarian ? .green : .red)
                        .frame(width: 30, height: 30)
                        .shadow(radius: 2)
                }
                .padding()
                
                HStack {
                    Text("Dish Type:")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                    
                    Spacer()
                }
                .padding([.horizontal, .bottom])
                
                HStack(alignment: .center) {
                    Text(recipeDetails.dishTypes.capitalized)
                        .font(.caustenFont(customFontName: .CaustenRegular, fontSize: 20))
                        .foregroundColor(Color("bluePurple"))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Text(recipeDetails.instructions)
                    .font(.caustenFont(customFontName: .CaustenRegular, fontSize: 20))
                    .padding()
                
                HStack {
                    Text("Summery:")
                        .font(.caustenFont(customFontName: .CaustenBold, fontSize: 25))
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                Text(recipeDetails.instructions)
                    .font(.caustenFont(customFontName: .CaustenMedium, fontSize: 20))
                    .padding()
            }
        }
    }
}

#Preview {
    DetailsOfRecipeView(recipeDetails: RecipeModel(image: "https://img.spoonacular.com/recipes/1-556x370.jpg", title: "Fried Anchovies with Sage", sourceUrl: "http://latavolamarcherecipebox.blogspot.com/2009/10/fried-anchovies-with-sage.html", vegetarian: false, dishTypes: "lunch,\n main course,\n main dish,\n dinner", healthScore: "23.0", instructions: "<p>If you have not tried anchovies before - you must try them now! Get over any weird apprehensions or that its just bait or a punchline for a joke about pizza (\"extra anchovies\")! These little suckers are delicious &amp; actually good for you! Baked, fried &amp; grilled - they are ohh so good and worth a try. If your not up to it, then pass me your plate because I love'em!Here is my favorite - Fried Anchovies - the recipe below adds a sage leave to each piece of fish as well for an extra burst of flavor &amp; color.Fried Anchovies with SageAcciughe fritte con Salvia1lb of anchovies cleaned, spine removedsage leaves (optional - if you are not a fan of sage just omit)batter1 cup of flour1 egg1 teaspoon of salt1 teaspoon of baking powderseltzer watervegetable oil for fryingIn a bowl combine flour, eggs, salt &amp; baking powder. Slowly add in seltzer water &amp; mix until forms a thin batter. Cover with plastic &amp; set in the fridge for at least an hour.Heat oil in a pot to 350 degree.Remove batter from fridge and mix once or twice (batter will have separated).Take a sage leaf &amp; anchovy put them together &amp; dip into the batter - allowing access batter to drip off.Fry 20 seconds a side until golden brown.Remove from oil &amp; drain on a paper towel.Sprinkle with salt &amp; serve immediately.Pairs great with prosecco or white wine.</p>", summery: "Fried Anchovies with Sage could be just the <b>dairy free and pescatarian</b> recipe you've been looking for. One serving contains <b>594 calories</b>, <b>68g of protein</b>, and <b>19g of fat</b>. This recipe serves 3. For <b>$5.61 per serving</b>, this recipe <b>covers 26%</b> of your daily requirements of vitamins and minerals. 3 people have tried and liked this recipe. Not a lot of people really liked this main course. A mixture of seltzer water, anchovies, baking powder, and a handful of other ingredients are all it takes to make this recipe so scrumptious. It is brought to you by latavolamarcherecipebox.blogspot.com. From preparation to the plate, this recipe takes around <b>45 minutes</b>. With a spoonacular <b>score of 72%</b>, this dish is good. Similar recipes are <a href=\"https://spoonacular.com/recipes/broccoli-rabe-with-tomatoes-anchovies-spaghetti-636212\">Broccoli Rabe with Tomatoes, Anchovies & Spaghetti</a>, <a href=\"https://spoonacular.com/recipes/grilled-peppers-with-anchovies-feta-cheese-and-spaghetti-645795\">Grilled Peppers With Anchovies, Feta Cheese and Spaghetti</a>, and <a href=\"https://spoonacular.com/recipes/italian-string-beans-with-anchovies-and-breadcrumbs-648259\">Italian String Beans With Anchovies and Breadcrumbs</a>."))
}
