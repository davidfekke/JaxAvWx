//
//  AviationWeather.swift
//  JaxAvWx
//
//  Created by David Fekke on 10/12/19.
//  Copyright © 2019 David Fekke. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class AviationWeather: ObservableObject {
    
    @Published var identifier: String = ""
    @Published var currentObservation: Report?
    @Published var hasData: Bool = false
    
    init(ident: String) {
        identifier = ident
        retrieveWeather()
    }
    
    func retrieveWeather() {
        guard let url = URL(string: "https://avwx.herokuapp.com/metar/\(identifier)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.hasData = true
            DispatchQueue.main.async {
                if let realData = data {
                    do {
                        print(self.identifier)
                        let avwxMetar = try JSONDecoder().decode(Metar.self, from: realData)
                        self.currentObservation = avwxMetar.reports[0]
                        
                    } catch {
                        print("Error serializing json:", error)
                    }
                }
                
            }
            
        }.resume()
    }
    
    
}
