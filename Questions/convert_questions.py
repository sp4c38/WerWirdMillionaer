
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
        question["correct_answer"] = section[1]

    return question

def main():
    text_file = open(os.path.join(os.getcwd(), "questions.txt"), "r") # File with the text to convert
    output_file = open(os.path.join(os.getcwd(), "questions.json"), "w")

    output_json = {}

    current_prize_level = ""
    for line in text_file.readlines():
        line = line.replace("\n", "")
        if "€" in line and ":" in line:
            current_prize_level = line[:-2] # Removes the € and : characters
            output_json[current_prize_level] = []

        if current_prize_level and not "€" in line and not ":" in line:
            question = {"question": "", "answer_a": "", "answer_b": "", "answer_c": "", "answer_d": "", "correct_answer": ""}
            sections = line.split("<")

            for section in sections:
                if not section == "" and not section == " ":
                    if not question["question"] and not question["answer_a"] and not question["answer_b"] and not question["answer_c"] and not question["answer_d"]:
                        question["question"] = section

                    elif question["question"] and not question["answer_a"] and not question["answer_b"] and not question["answer_c"] and not question["answer_d"]:
                        section = section.split("1")
                        question = add_answer(section, "answer_a", question)

                    elif question["question"] and question["answer_a"] and not question["answer_b"] and not question["answer_c"] and not question["answer_d"]:
                        section = section.split("1")
                        question = add_answer(section, "answer_b", question)

                    elif question["question"] and question["answer_a"] and question["answer_b"] and not question["answer_c"] and not question["answer_d"]:
                        section = section.split("1")
                        question = add_answer(section, "answer_c", question)

                    elif question["question"] and question["answer_a"] and question["answer_b"] and question["answer_c"] and not question["answer_d"]:
                        section = section.split("1")
                        question = add_answer(section, "answer_d", question)

            if question["question"] and question["answer_a"] and question["answer_b"] and question["answer_c"] and question["answer_d"]:
                output_json[current_prize_level].append(question)

    output_file.write(json.dumps(output_json))

    text_file.close()
    output_file.close()


if __name__ == '__main__':
    main()
