# Cloning Naver Webtoon Aplication with Swift 

This is a simple application created using Swift to mimic basic design and functionality of the official Naver Webtoon app. It used Python and Beautifulsoup to get actual data from the internet.



## WebToon Preview.

![aa](https://user-images.githubusercontent.com/48948578/111142095-a51c1800-85c7-11eb-9b25-de70c05887b2.gif)


## WebToon 만들며 아쉬웠던 점들.



## WebToon 고칠 수 있는 것들?

1. In MainViewController the navigation bar acts little different from the real app. In real app, if scroll the collection view, nav bar moves down and up accordingly. However, in my app I put a limit(fixed height). If scroll over that limit navigation bar comes down, and if scroll down the limit navigation bar disapppears. I tried to make it work like real app by inseting navigtaion bar it self, but doing so made a problem. When segue on to the next view controller, navigation bar keeps the inset from the previuous view controller, making navigation bar unshown. 

2. When seguing from MainViewController to TableViewController navigation bar is not being animated. 

3. 3번째


