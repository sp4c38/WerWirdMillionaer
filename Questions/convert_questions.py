# Used to convert a text with a specific format to JSON format
# for the Wer Wird Millionär-App. Used to make it easier to add and remove questions
# without needing to handle a large JSON dataset

import json
import os

def add_answer(section, answer_char, question):
    if len(section) == 1:
        question[answer_char] = section[0]
    if len(section) == 2:
        question[answer_char] = section[1]
        question["correctAnswer"] = section[1]

    return question

def main():
    # using swift variable name style in json

    text_file = open(os.path.join(os.getcwd(), "questions.txt"), "r") # File with the text to convert
    output_file = open(os.path.join(os.getcwd(), "questions.json"), "w")

    output_json = {"prizeLevels": []}
    current_prize_level = -1

    for line in text_file.readlines():
        line = line.replace("\n", "")
        if "€" in line and ":" in line: # Don't include in output
            current_prize_level += 1
            prize_level = {"questions": []}
            prize_level["questions"] = []
            output_json["prizeLevels"].append(prize_level)
            continue

        if not current_prize_level == -1:
            question = {"question": "", "answerA": "", "answerB": "", "answerC": "", "answerD": "", "correctAnswer": ""}
            sections = line.split("<")
            for section in sections:
                if section.replace(" ", "") and section.replace("\xa0", ""):
                    if not question["question"] and not question["answerA"] and not question["answerB"] and not question["answerC"] and not question["answerD"]:
                        question["question"] = section

                    elif question["question"] and not question["answerA"] and not question["answerB"] and not question["answerC"] and not question["answerD"]:
                        section = section.split("^")
                        question = add_answer(section, "answerA", question)

                    elif question["question"] and question["answerA"] and not question["answerB"] and not question["answerC"] and not question["answerD"]:
                        section = section.split("^")
                        question = add_answer(section, "answerB", question)

                    elif question["question"] and question["answerA"] and question["answerB"] and not question["answerC"] and not question["answerD"]:
                        section = section.split("^")
                        question = add_answer(section, "answerC", question)

                    elif question["question"] and question["answerA"] and question["answerB"] and question["answerC"] and not question["answerD"]:
                        section = section.split("^")
                        question = add_answer(section, "answerD", question)

            if question["question"] and question["answerA"] and question["answerB"] and question["answerC"] and question["answerD"] and question["correctAnswer"]:
                output_json["prizeLevels"][current_prize_level]["questions"].append(question)
            else:
                line_empty = False
                if len(sections) == 1:
                    if sections[0].replace(" ", "") == "" or sections[0].replace("\xa0", ""):
                        line_empty = True
                if not line_empty:
                    print(f"Couldn't scan {sections}. This section wasn't added to output.")

    all_question_list = [] # list with all questions to check if a question appears multiple times

    for prizeLevel in output_json["prizeLevels"]:
        for question in prizeLevel["questions"]:
            all_question_list.append(question["question"])

    for question in all_question_list:
        times_question_appears = all_question_list.count(question)
        if times_question_appears != 1:
            print(f"{question} appears {times_question_appears} time(s).")

    output_file.write(json.dumps(output_json))

    text_file.close()
    output_file.close()


if __name__ == '__main__':
    main()
