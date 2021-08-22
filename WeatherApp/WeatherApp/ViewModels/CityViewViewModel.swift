//
//  CityViewViewModel.swift
//  WeatherApp
//
//  Created by wassim on 20/8/2021.
//


import SwiftUI
import CoreLocation

final class CityViewViewModel : ObservableObject{
    
    @Published var weather = WeatherResponse.empty()
    @Published var city : String = "San Francisco" {
        didSet{
            getLocation()

        }
    }
    
    // we use computed propety instead of function
    //if the call is cheap
    //and does not throw errors
    //or return same result of its first invocation
    
   
    
    init() {
        getLocation()
    }
    
    
    
    
    
    var weatherIcon : String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "dayClearSky"
    }
    
    var temperature: String {
        return getTempFor(temp: weather.current.temp)
    }
    
    var conditions: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
        }
        return "default conditions"
    }
    
    var windSpeed : String {
        return String(format: "%0.1f", weather.current.wind_speed)
    }
    
    var humidity : String {
        return String(format: "%d%%", weather.current.humidity)
    }
    
    
    var rainChance : String {
        return String(format: "%0.0f%%", weather.current.dew_point)
    }
    
    
    
    
    func getTempFor(temp:Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    private func getLocation(){
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks , let place = places.first{
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    
    private func getWeather(coord: CLLocationCoordinate2D?){
        if let coord = coord {
            let urlString = API.getURLFor(lat: coord.latitude, lon: coord.longitude)
            getWeatherInternal(city: city, for: urlString)
        }else{
            let urlString = API.getURLFor(lat: 37.5485, lon: -121.9886)
            getWeatherInternal(city: city, for: urlString)

        }
    }
    
    
    private func getWeatherInternal(city:String , for urlString:String){
        NetworkManager<WeatherResponse>.fetch(for: URL(string: urlString)!) { (result) in
            switch result {
                case .success(let response) :
                    DispatchQueue.main.async {
                        self.weather = response
                    }
                case .failure(let error) :
                    print(error)
            }
        }
    }
    
    func getAnimationFor(icon: String) -> String{
       switch icon {
           case "01d": return "dayClearSky"
           case "01n": return "nightClearSky"
           case "02d": return "dayFewClouds"
           case "02n": return "nightFewClouds"
           case "03d": return "dayScatteredClouds"
           case "03n": return "nightScatteredClouds"
           case "04d": return "dayBrokenClouds"
           case "04n": return "nightBrokenClouds"
           case "09d": return "dayShowerRains"
           case "09n": return "nightShowerRains"
           case "10d": return "dayRain"
           case "10n": return "nightRain"
           case "11d": return "dayThunderstorm"
           case "11n": return "nightThunderstorm"
           case "13d": return "daySnow"
           case "13n": return "nightSnow"
           case "50d": return "dayMist"
           case "50n": return "nightMist"
           default: return "dayClearSky"
       }
   }
    
    
     func getWeatherIcon(icon: String) -> Image{
        switch icon {
            case "01d": return Image(systemName: "sun.max.fill")
            case "01n": return Image(systemName: "moon.fill")
            case "02d": return Image(systemName: "cloud.sun.fill")
            case "02n": return Image(systemName: "cloud.moon.fill")
            case "03d": return Image(systemName: "cloud.fill")
            case "03n": return Image(systemName: "cloud.fill")
            case "04d": return Image(systemName: "cloud.fill")
            case "04n": return Image(systemName: "cloud.fill")
            case "09d": return Image(systemName: "cloud.drizzle.fill")
            case "09n": return Image(systemName: "cloud.drizzle.fill")
            case "10d": return Image(systemName: "cloud.heavyrain.fill")
            case "10n": return Image(systemName: "cloud.heavyrain.fill")
            case "11d": return Image(systemName: "cloud.bolt.fill")
            case "11n": return Image(systemName: "cloud.bolt.fill")
            case "13d": return Image(systemName: "cloud.snow.fill")
            case "13n": return Image(systemName: "cloud.snow.fill")
            case "50d": return Image(systemName: "cloud.fog.fill")
            case "50n": return Image(systemName: "cloud.fog.fill")
            default: return Image(systemName: "sun.max.fill")
        }
    }
    
    //MARK: - dateFormatter Functions
    
    private lazy var dateformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    
    private lazy var dayformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    
    
    var date : String  {
        return dateformatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    func getTimeFor(timestamp:Int) -> String {
        return timeformatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getDayFor(timestamp:Int)-> String{
        return dayformatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))

    }
}
