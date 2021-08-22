//
//  ContentView.swift
//  WeatherApp
//
//  Created by wassim on 8/18/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cityVM = CityViewViewModel()
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0){
                MenuHeaderView(cityViewModel: cityVM)
                ScrollView(showsIndicators: false) {
                    CityView(cityVM: cityVM)
                }
            }.padding(.top,30)
        }.edgesIgnoringSafeArea(.all)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
