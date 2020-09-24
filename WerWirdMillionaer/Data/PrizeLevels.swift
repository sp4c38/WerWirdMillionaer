//
//  PrizeLevels.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 30.08.20.
//

import Foundation

struct Prize: Equatable {
    var amount: Double
    var isSecurityLevel: Bool
}

struct PrizesData {
    // Should match the same prize levels which questions in the JSON file with the questions have
    
    var unit = "€"
    var prizeLevels: [Prize]
        
    init() {
        self.prizeLevels = [ // Prizes must be sorted from worst to greatest prize
                            Prize(amount: 0.0, isSecurityLevel: true),
                            Prize(amount: 50.0, isSecurityLevel: false),
                            Prize(amount: 100.0, isSecurityLevel: false),
                            Prize(amount: 200.0,  isSecurityLevel: false),
                            Prize(amount: 300.0, isSecurityLevel: false),
                            Prize(amount: 500.0, isSecurityLevel: true),
                            Prize( amount: 1000.0, isSecurityLevel: false),
                            Prize(amount: 2000.0, isSecurityLevel: true),
                            Prize(amount: 4000.0, isSecurityLevel: false),
                            Prize(amount: 8000.0, isSecurityLevel: false),
                            Prize(amount: 16000.0, isSecurityLevel: true),
                            Prize(amount: 32000.0, isSecurityLevel: false),
                            Prize(amount: 64000.0, isSecurityLevel: false),
                            Prize(amount: 125000.0, isSecurityLevel: false),
                            Prize(amount: 500000.0, isSecurityLevel: false),
                            Prize(amount: 1000000.0, isSecurityLevel: false),
                           ]
    }
}

let prizesData = PrizesData()
