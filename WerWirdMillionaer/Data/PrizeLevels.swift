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
                            Prize(amount: 50.0, isSecurityLevel: false), // 1
                            Prize(amount: 100.0, isSecurityLevel: false), // 2
                            Prize(amount: 200.0,  isSecurityLevel: false), // 3
                            Prize(amount: 300.0, isSecurityLevel: false), // 4
                            Prize(amount: 500.0, isSecurityLevel: true), // 5
                            Prize( amount: 1000.0, isSecurityLevel: false), // 6
                            Prize(amount: 2000.0, isSecurityLevel: true), // 7
                            Prize(amount: 4000.0, isSecurityLevel: false), // 8
                            Prize(amount: 8000.0, isSecurityLevel: false), // 9
                            Prize(amount: 16000.0, isSecurityLevel: true), // 10
                            Prize(amount: 32000.0, isSecurityLevel: false), // 11
                            Prize(amount: 64000.0, isSecurityLevel: false), // 12
                            Prize(amount: 125000.0, isSecurityLevel: false), // 13
                            Prize(amount: 500000.0, isSecurityLevel: false), // 14
                            Prize(amount: 1000000.0, isSecurityLevel: false), // 15
                           ]
    }
}

let prizesData = PrizesData()
