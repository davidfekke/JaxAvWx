//
//  ContentView.swift
//  JaxAvWx
//
//  Created by David Fekke on 10/12/19.
//  Copyright © 2019 David Fekke. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var airports: [Airport] = []
    var body: some View {
        NavigationView {
            List(airports) { airport in
                
                NavigationLink(destination: ContentDetailView(weather: AviationWeather(ident: airport.identifier))) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(airport.identifier)
                        Text(airport.name)
                            .font(.subheadline)
                    }
                }
                
            }.navigationBarTitle(Text("Jacksonville Airports"))
        }
        
    }
}

struct ContentDetailView: View {
    @ObservedObject var weather: AviationWeather = AviationWeather(ident: "")
    
    var body : some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    if weather.currentObservation != nil {
                        WeatherView(report: weather.currentObservation!)
                    }
                    Text("hasData: \(weather.hasData ? "YES" : "NO")")
                }.padding()
                Spacer()
            }
            Spacer()
        }
    .navigationBarTitle(Text(weather.identifier))
    }
}

struct WeatherView : View {
    @State var report: Report
    var body : some View {
        VStack {
            
            HStack {
                Text(report.flightCategory)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(report.flightCategory == "VFR" ? Color.green : report.flightCategory == "MVFR" ? Color.blue : Color.red)
                    
                Spacer()
            }
            
            HStack {
                Text("Visibility")
                Spacer()
                Text(String(report.visibilityStatuteMi))
            }
            
            HStack {
                Text("Temp C")
                Spacer()
                Text(String(report.tempC))
            }
            
            HStack {
                Text("Dewpoint:")
                Spacer()
                Text(String(report.dewpointC))
            }
            
            HStack {
                Text("Wind Dir:")
                Spacer()
                Text(String(report.windDirDegrees))
            }
            
            HStack {
                Text("Wind Speed:")
                Spacer()
                Text(String(report.windSpeedKt))
            }
            
            HStack {
                Text("Altimeter:")
                Spacer()
                Text(String(report.altimInHg))
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(airports: testData)
            ContentView(airports: testData).environment(\.colorScheme, .dark)
        }
        
    }
}
