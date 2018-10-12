# French Hangman - Pendu

The simple game of Hangman in a shell script.
Resulting from a school duty I programmed this little game with a small interface ascii having two game modes: easy and difficult.

Fonctionnement :
1. A line is drawn at random from a list.txt file containing a part of the French dictionary.
2. When displaying the word, the letters are replaced by underscores,
3. step by step the user is invited to write letters that will be displayed instead of the underscore if they are present in the chosen word
4. If the letter is not present in the word, the hanged man is built progressively, after 12 mistakes the game is over it's a defeat
5. If you find the word you win
A scoring system is present, all the completed parts are saved in the score.txt file as follows:
"score ; player ; word"


Author : Arthur REITER
Website : arthur.reiter.tf 
