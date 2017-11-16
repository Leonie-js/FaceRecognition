# FaceRecognition
A face recognition program I wrote with processing.

I made an interactive tour (in dutch) where you could make your own smoothie. But before you know which smoothie you were going to make you had do the smoothie test. The smoothie test will choose a personal smoothie for you depending on how you answer the questions.
In this smoothie test you had to answer some question by nodding your head.

<b> The start (StartState) </b>
<img src="https://imgur.com/a/pXhkU" width="350"/>

This is the first state and here the logo of project is shown. At the same time is a distance sensor under the screen so that if someone walks by, it will go to the next state. 

<b> Explanation (MovieState</b>
<img src="https://ibb.co/muhfSm" width="350"/>

In this state the program will tell the user what he or she has to do. By pressing enter the user can go to the next state.

<b> Answering questions (NoddingState) </b>
<img src="https://imgur.com/a/4YK3K" width="350"/>

At this point the questions will be received from the database and shown to the user. The user can then nod his head to say yes or no.

<img src="https://imgur.com/a/JGCFW" width="350"/>
This is how it will look like if the user nods no.

<img src="https://imgur.com/a/61se6" width="350"/>
This is how it will look like if the user nods yes.

<img src="https://imgur.com/a/TNqIv" width="350"/>
There can also be a message been shown to the user that he or she has to change his position to the screen.

When the user has nodded an answer he or she has to wait for 5 seconds to confirm the answer. In those 5 seconds he or she can still change the answer. The time is shown on the right down side.
When all the questions are answered the program automatically goes to the next state. 

<b> Result Smoothie (ActiveState) </b>
<img src="https://imgur.com/a/mk6mE" width="350"/>

The smoothie then gets chosen and shown to the user. The user has to press enter to go to the next state.

<b> Fill in data (FormState) </b>
<img src="https://imgur.com/a/oxwZi" width="350"/>

In this state the user has to fill in his or her details to participate in the tour.
After submitting the data, the user will see a video where the tour is explained. 

