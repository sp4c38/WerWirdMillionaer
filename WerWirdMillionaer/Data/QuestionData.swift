//
//  LoadQuestionsJson.swift
//  WerWirdMillionaer
//
//  Created by Léon Becker on 30.08.20.
//

import Foundation

struct Question: Codable {
    var question: String // Question
    var answer_a: String // Answer possibility A
    var answer_b: String // Answer possibility B
    var answer_c: String // Answer possibility C
    var answer_d: String // Answer possibility D
    var correct_answer: String // Name of the answer possibility variable which holds the correct answer
}

struct PrizeLevel: Codable {
    var prizeLevelName: String
    var questions: [Question]
}

struct QuestionData: Codable {
    var prizeLevels: [PrizeLevel] // Store question for each prize level in list
}

func LoadQuestionsJson(fileName: String, fileExtension: String) -> QuestionData? {
    // Will load different questions for different prize levels from json file
    // This JSON file is generated out of more overviewable text by a python script
    
    let fileData: Data
    let fileContents: QuestionData
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
