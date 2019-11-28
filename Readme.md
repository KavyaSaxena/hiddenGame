**The problem statement was to create a collection view with the number of cells entered by the user and building a memory game with certain functionalities. 
So, my first step was to create a UI where the user can enter the number of cells, and the collection view can be displayed.
I used the MVC model to structure my project.**
# View
Firstly I started with View part on the storyboard, where I need to three view controllers :
* Entry View Controller: Where I need to get user input for the number of rows and columns in my collection view. With a button to play the game.
* Game View Controller: Where the user is directed from entry view on clicking the play button. Here are score labels for the user and a collection view.
* End View Controller: To display the ending of the game and all the cards are shown now in the memory game. It consists of a label to display score and SKView for animation and presenting SKScene.
# Controller
Connected various view controllers with their corresponding swift file.
My second goal was to fit the data in cards and to check whether the last opened card and current card have the same data that I checked by saving the indexPath of the previous card in an array and comparing it with present data. If equal, then updating the score +10 points and if not updating it to -5 points.
**Note**: Points are deducted only when card is opened priorly else not. 
I added the animation when the card is shown for flipping the card and displaying the data.
Thirdly on all the cards is contained by the shown array of cards — display endViewController with the score.
# Model
It is the data for a particular card that is opened an array for data previously. I used the shuffle function to shuffle the data in cards. So that users can never predict which card will have which value.
Only if the card is shown previously, then only -5 points will happen. No negative marking if the user opened the card for the first time using boolean variable.

# How to run the project?
Open MemoryGame.xcodeproj file to run the project. Then, build and run the project on stimulator.


