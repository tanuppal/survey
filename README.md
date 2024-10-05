# Tendable Coding Assessment

## Usage

```sh
bundle
ruby questionnaire.rb
```

## Goal

The goal is to implement a survey where a user should be able to answer a series of Yes/No questions. After each run, a rating is calculated to let them know how they did. Another rating is also calculated to provide an overall score for all runs.

## Requirements

Possible question answers are: "Yes", "No", "Y", or "N" case insensitively to answer each question prompt.

The answers will need to be **persisted** so they can be used in calculations for subsequent runs >> it is proposed you use the pstore for this, already included in the Gemfile

After _each_ run the program should calculate and print a rating. The calculation for the rating is: `100 * number of yes answers / number of questions`.

The program should also print an average rating for all runs.

The questions can be found in questionnaire.rb

Ensure we can run your exercise

## Bonus Points

Updated readme with an explanation of your approach

Unit Tests

Code Comments

Dockerfile / Bash script if needed for us to run the exercise

# Survey Application

This is a simple command-line survey application that allows users to answer a series of Yes/No questions.

## Features

- User can answer a predefined set of questions.
- Answers are persisted using PStore.
- Individual and average ratings are calculated and displayed after each run.

## How to Run

1. Ensure Ruby and Bundler are installed.
2. Run `bundle install` to install dependencies.
3. Execute the program with `ruby questionnaire.rb`.
4. Dockerfile / Bash script 
5. Build the Docker image: docker build -t ruby_survey_app .
5. Run ./run.sh



## Code Structure

The main logic is contained in the `Survey` class, which handles user interaction, question asking, and data persistence.

## Unit tests
1. Rspec questionnaire_spec.rb
