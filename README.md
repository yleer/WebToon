# WebToon

This is a simple application created using Swift to mimic basic design and functionality of the official Naver Webtoon app. It used Python and Beautifulsoup to get actual data from the internet.

<img src="https://user-images.githubusercontent.com/48948578/111142095-a51c1800-85c7-11eb-9b25-de70c05887b2.gif"  width="250" height="450">

# Contents
+ [Why?](#why)
+ [Installation](#Installation)
+ [Usage](#Usage)
+ [How FoodChooser is made](#How-FoodChooser-is-made)
+ [Problems while making app.](#Problems-while-making-app)
+ [Things could be improved.](#Things-could-be-improved)


***
### Why?
This project's purpose is to test what I can do using what I've learned so far. After learning Swift by flowing instruction from online lessions. I wanted to make a real app used by many people. Before making my own new app, I decided to clone an existing app. Becuase clonning will give me ideas of how the app will look and sturcutre of the app. I thought if I clone an app that I use daily, it will be maningful, so I cloned Naver Webtoon App which I use daily.


***
### Installation
Simply install the project.
> + Clone the project.    https://github.com/yleer/WebToon.git
> + Or download the zip file.

***
### Usage

Just like the real Naver Webtoon, this app can be used to see webtoons. 


***
### How WebToon is made

1. Data Structure
>+ Data - Contains data of webtoons : webtoon's thumnail image url, webtoon's description, webtoon episode's title, rating, url, thumnail image 
>+ Episode - Makes Data's episode data into single Episode struct.
>+ WebtoonModel - Contains array of Episode, which makes up a single Webootn.
>+ Model - Contains array of WebtoonModels by day.

2. Data Flow
>+ Get data of webtoon(thumnail images, episode urls, etc..) using beautifulSoup in Python. 
>+ Make model with the data. 
>+ Provide data to collection view and table view. 



### Problems while making app.

1. In MainViewController the navigation bar acts little different from the real app. In real app, if scroll the collection view, nav bar moves down and up accordingly. However, in my app I put a limit(fixed height). If scroll over that limit navigation bar comes down, and if scroll down the limit navigation bar disapppears. I tried to make it work like real app by inseting navigtaion bar it self, but doing so made a problem. When segue on to the next view controller, navigation bar kept the inset from the previuous view controller, making navigation bar unshown. 

2. Because i did't have actual webtoon data, I implement the last view controller using UIWebView. This caused my app to be little different from the real app. I wish i had real webtoon data so that i can make my web view be a scroll view instead. This will enable to add tap gesture which will more likely to look like real app.


### Things could be improved.

1. Add tab bar controller to look more like the real app.
2. Add more data. Currently put only some of monday and tuesday webtoon data.
3. When internet is unavailable, set collection views cell and table views cell with default image.
4. When seguing from MainViewController to TableViewController navigation bar is not being animated. 



