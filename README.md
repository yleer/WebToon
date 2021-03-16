# Cloning Naver Webtoon Aplication with Swift 

This is a simple application created using Swift to mimic basic design and functionality of the official Naver Webtoon app. It used Python and Beautifulsoup to get actual data from the internet.



## WebToon Preview.

![aa](https://user-images.githubusercontent.com/48948578/111142095-a51c1800-85c7-11eb-9b25-de70c05887b2.gif)


## Basic idea.

Get data of webtoon(thumnail images, episode urls, etc..) using beautifulSoup in Python. 
Make model with the data.
Provide data to collection view and table view.
Make UI look like real app.


## Problems while making app.

1. In MainViewController the navigation bar acts little different from the real app. In real app, if scroll the collection view, nav bar moves down and up accordingly. However, in my app I put a limit(fixed height). If scroll over that limit navigation bar comes down, and if scroll down the limit navigation bar disapppears. I tried to make it work like real app by inseting navigtaion bar it self, but doing so made a problem. When segue on to the next view controller, navigation bar kept the inset from the previuous view controller, making navigation bar unshown. 

2. Because i did't have actual webtoon data, I implement the last view controller using UIWebView. This caused my app to be little different from the real app. I wish i had real webtoon data so that i can make my web view be a scroll view instead. This will enable to add tap gesture which will more likely to look like real app.


## Things can be improved.

1. Add tab bar controller to look more like the real app.
2. Add more data. Currently put only some of monday and tuesday webtoon data.
3. When internet is unavailable, set collection views cell and table views cell with default image.
4. When seguing from MainViewController to TableViewController navigation bar is not being animated. 



