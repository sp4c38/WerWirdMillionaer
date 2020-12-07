//
//  LoadQuestionsJson.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 30.08.20.
//

import Foundation

struct Question: Codable, Equatable {
    var question: String // Question
    var answerA: String? // Answer possibility A
    var answerB: String? // Answer possibility B
    var answerC: String? // Answer possibility C
    var answerD: String? // Answer possibility D
    var correctAnswer: String // Name of the answer possibility variable which is the correct answer
    
    mutating func shuffleOrder() {
        var items = [self.answerA, self.answerB, self.answerC, self.answerD]
        items.shuffle()
        self.answerA = items[0]
        self.answerB = items[1]
        self.answerC = items[2]
        self.answerD = items[3]
    }
}

struct PrizeLevel: Codable {
    var questions: [Question]
}

struct QuestionData: Codable {
    var prizeLevels: [PrizeLevel] // Store question for each prize level in list
}

func LoadQuestionsJson(fileName: String, fileExtension: String) -> QuestionData? {
    // Will load different questions for different prize levels from json file
    // This JSON file is generated out of more overviewable text by a python script
    
    let fileData: Data
    var fileContents: QuestionData
    let decoder = JSONDecoder()
    
    guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
        return nil
    }
    
    do {
        fileData = try Data(contentsOf: fileLocation)
    } catch {
        print("Couldn't load the JSON file with questions. \(error)")
        return nil
    }
    
    do {
        fileContents = try decoder.decode(QuestionData.self, from: fileData)
    } catch {
        print("Couldn't decode the JSON file with questions. \(error)")
        return nil
    }
    
    return fileContents
}

let questionData = LoadQuestionsJson(fileName: "questions", fileExtension: "json")
