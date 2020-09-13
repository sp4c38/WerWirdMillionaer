//
//  PrizeLevels.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 30.08.20.
//

import Foundation

struct Prize: Equatable {
    var name: String
    var amount: Double
    var isSecurityLevel: Bool
}

struct PrizesData {
    // Should match the same prize levels which questions in the JSON file with the questions have
    
    var prizeLevels: [Prize]
        
    init() {
        self.prizeLevels = [ // Prizes must be sorted from worst to greatest prize
                            Prize(name: "0 Euro", amount: 0.0, isSecurityLevel: true),
                            Prize(name: "50 Euro", amount: 50.0, isSecurityLevel: false),
                            Prize(name: "100 Euro", amount: 100.0, isSecurityLevel: false),
                            Prize(name: "200 Euro", amount: 200.0,  isSecurityLevel: false),
                            Prize(name: "300 Euro", amount: 300.0, isSecurityLevel: false),
                            Prize(name: "500 Euro", amount: 500.0, isSecurityLevel: true),
                            Prize(name: "1.000 Euro", amount: 1000.0, isSecurityLevel: false),
                            Prize(name: "2.000 Euro", amount: 2000.0, isSecurityLevel: true),
                            Prize(name: "4.000 Euro", amount: 4000.0, isSecurityLevel: false),
                            Prize(name: "8.000 Euro", amount: 8000.0, isSecurityLevel: false),
                            Prize(name: "16.000 Euro", amount: 16000.0, isSecurityLevel: true),
                            Prize(name: "32.000 Euro", amount: 32000.0, isSecurityLevel: false),
                            Prize(name: "64.000 Euro", amount: 64000.0, isSecurityLevel: false),
                            Prize(name: "125.000 Euro", amount: 125000.0, isSecurityLevel: false),
                            Prize(name: "500.000 Euro", amount: 500000.0, isSecurityLevel: false),
                            Prize(name: "1.000.000 Euro", amount: 1000000.0, isSecurityLevel: false),
                           ]
    }
}

let prizesData = PrizesData()
