//
//  PrizeLevels.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 30.08.20.
//

import Foundation

struct Prize {
    var name: String
    var amount: Double
    var isSecurityLevel: Bool
    var isHighest: Bool
}

struct PrizesData {
    // Should match the same prize levels which questions in the JSON file with the questions have
    
    var prizeLevels: [Prize]
        
    init() {
        self.prizeLevels = [
                            Prize(name: "100€", amount: 100.0, isSecurityLevel: false, isHighest: false),
                            Prize(name: "200€", amount: 200.0,  isSecurityLevel: false, isHighest: false),
                            Prize(name: "300€", amount: 300.0, isSecurityLevel: false, isHighest: false),
                            Prize(name: "500€", amount: 500.0, isSecurityLevel: true, isHighest: false),
                            Prize(name: "1.000€", amount: 1000.0, isSecurityLevel: false, isHighest: false),
                            Prize(name: "2.000€", amount: 2000.0, isSecurityLevel: false, isHighest: false),
                            Prize(name: "4.000€", amount: 4000.0, isSecurityLevel: false, isHighest: false),
                            Prize(name: "8.000€", amount: 8000.0, isSecurityLevel: false, isHighest: false),
                            Prize(name: "16.000€", amount: 16000.0, isSecurityLevel: true, isHighest: false),
                            Prize(name: "32.000€", amount: 32000.0, isSecurityLevel: false, isHighest: false),
                            Prize(name: "64.000€", amount: 64000.0, isSecurityLevel: false, isHighest: false),
                            Prize(name: "125.000€", amount: 125000.0, isSecurityLevel: false, isHighest: false),
                            Prize(name: "500.000€", amount: 500000.0, isSecurityLevel: false, isHighest: false),
                            Prize(name: "1.000.000€", amount: 1000000.0, isSecurityLevel: false, isHighest: true),
                           ]
    }
}

let prizesData = PrizesData()
