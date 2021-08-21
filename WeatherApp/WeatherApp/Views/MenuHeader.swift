//
//  MenuHeader.swift
//  WeatherApp
//
//  Created by wassim on 21/8/2021.
//

import SwiftUI

struct MenuHeader: View {
    @ObservedObject var cityViewModel: CityViewViewModel
    @State var searchTerm = "San Francisco"
    var body: some View {
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
        .foregroundColor(Color.white)
        .padding()
        .background(ZStack(alignment: .leading, content: {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .padding(.leading,10)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue.opacity(0.5))
        }))
    }
}

struct MenuHeader_Previews: PreviewProvider {
    static var previews: some View {
        MenuHeader()
    }
}
