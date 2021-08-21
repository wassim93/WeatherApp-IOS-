//
//  MenuHeaderView.swift
//  WeatherApp
//
//  Created by wassim on 20/8/2021.
//

import SwiftUI

struct MenuHeaderView: View {
    
    @ObservedObject var cityViewModel: CityViewViewModel
    @State var searchTerm = "San Francisco"
    
    var body: some View{
        HStack{
            TextField("",text: $searchTerm).padding(.leading,20)
            Button{
                cityViewModel.city = searchTerm
            }
            label :{
                ZStack{
                    RoundedRectangle(cornerRadius: 10).fill(Color.blue)
                    Image(systemName: "location.fill")
                }
            }
            .frame(width: 50, height: 50)
        }
        .foregroundColor(.white)
        .padding()
        .background(ZStack(alignment: .leading, content: {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading,10)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue.opacity(0.5))
        }))
        
    }
    
}

struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MenuHeaderView(cityViewModel: CityViewViewModel())
        //ContentView()
    }
}
