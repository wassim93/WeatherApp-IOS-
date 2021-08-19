//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by wassim on 8/19/21.
//

import Foundation

struct WeatherResponse : Codable {
    var current: WeatherSubClass
    var hourly: [Weather]
    var feel_like:Double
    var pressure : Int
    var humidity : Int
    var dew_point : Double
    var clouds : Int
    var wind_speed : Double
    var wind_deg : Int
    var weather : [WeatherDetail]
}
