//
//  TodayWeatherView.swift
//  WeatherApp
//
//  Created by wassim on 21/8/2021.
//

import SwiftUI

struct TodayWeatherView: View {
    @ObservedObject var cityVM : CityViewViewModel
    var body: some View {
        VStack(spacing: 10){
            Text("Today")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack(spacing: 20){
                //TODO: - lottie animation function
                LottieView(name: "dayClearSky",loopMode: .loop)
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    Text("\(cityVM.temperature)°F")
                        .font(.system(size: 42))
                    Text(cityVM.conditions)
                }
            }
            HStack{
                Spacer()
                widgetView(image: "wind", color: .green, title: "\(cityVM.windSpeed)mi/hr")
                Spacer()
                widgetView(image: "drop.fill", color: .blue, title: "\(cityVM.humidity)")
                Spacer()
                widgetView(image: "umbrella.fill", color: .red, title: "\(cityVM.rainChance)")
                Spacer()
            }
            .padding([.leading, .bottom, .trailing])
            
        }
        .padding()
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.8), Color.blue.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
                .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
        )
        
    }
}

private func widgetView(image: String , color: Color , title: String)-> some View{
    VStack{
        Image(systemName: image)
            .padding()
            .font(.title)
            .foregroundColor(color)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        Text(title)
    }
}

struct TodayWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        //TodayWeatherView(cityVM: CityViewViewModel())
        ContentView()
    }
}
