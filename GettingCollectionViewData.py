from bs4 import BeautifulSoup
import urllib.request
import urllib.parse
# just change the url.

# getting thumnail image of the webtoon and url
web_url = "https://comic.naver.com/webtoon/weekday.nhn"
html = ""
soup = ""
with urllib.request.urlopen(web_url) as response:
    html = response.read()
    soup = BeautifulSoup(html, 'html.parser')

    data = soup.find_all("div",  {"class":"col_inner"})

    # data[0] -> 월요일, data[1] -> 화요일 계속 반복.
    tmpArray = []
    for item in data[1].contents[3].contents :
        if item == '\n':
            pass
        else:
            tmpArray.append(item)

    for item in tmpArray:
        print(item.contents[1].contents[1].contents[1].attrs["src"])     # for getting cell image.
        url = "https://comic.naver.com" + item.contents[1].contents[1].attrs["href"]
        print(url)
        print()



# 우선 월요일꺼만하자

