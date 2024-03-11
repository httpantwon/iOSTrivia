# Project 3 - Trivia

Submitted by: Antwon Walls

Trivia is a game app that displays a history question and 4 choices. There are a total of 3 history questions. Trivia asks questions that always have a correct answer. It is a great way to keep your mind sharp and alert because you’re constantly having to remember facts and information while you’re playing!

Time spent: 48 hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] User can view the current question and 4 different answers
- [x] User can view the next question after tapping an answer
- [x] User can answer at least 3 different questions

The following **optional** features are implemented:

- [x] User can use the vertical orientation of the app on any device
- [x] User can track the question they are on and how many questions are left
- [x] User can see how many questions they got correct after answering all questions
- [x] User should be able to restart the game after they've finished answering all questions

## Video Walkthrough

Here is a reminder on how to embed Loom videos on GitHub. Feel free to remove this reminder once you upload your README. 

[Guide]](https://youtu.be/IPe-sxQEva4) 

## Notes

The challenges I faced:

1. Making the corners of my Labels and Buttons Rounded. I learned that these type of properties have to manually be coded into the TriviaViewController because they can’t be made in the Interactive Builder. 

2. Changing the correct answer count when the user taps a correct answer. Another student assisted me by pointing out that I had my gameOverMesssage in viewDidLoad(), which will only render once when the screen is first loaded. 

## License

    Copyright [2024] [Antwon Walls]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
