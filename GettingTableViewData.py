from bs4 import BeautifulSoup
import urllib.request
import urllib.parse
# just change the url.

# data for table view.
# getting episode title, url, rating , date.


html = ""
web_url = "https://comic.naver.com/webtoon/list.nhn?titleId=703849&weekday=mon&page=2"
soup = ""
with urllib.request.urlopen(web_url) as response:
    html = response.read()
    soup = BeautifulSoup(html, 'html.parser')

    titleData = []
    ratingData = []
    dateData = []
    urlData = []
    thumNailData = []

    titles = soup.find_all("td",  {"class":"title"})
    for title in titles:
        titleData.append(title.contents[1].contents[0])

    ratings = soup.find_all("div", {"class": "rating_type"})
    for rating in ratings:
        ratingData.append(rating.contents[3].contents[0])

    dates = soup.find_all("td",  {"class":"num"})
    for date in dates:
        dateData.append(date.contents[0])

    urls = soup.find_all("td", {"class": "title"})
    for url in urls:
        completeUrl = "https://comic.naver.com" + url.contents[1]["href"]
        urlData.append(completeUrl)

    thumNails = soup.find_all("img")
    for thumNail in thumNails:
        if "onerror" in thumNail.attrs:
            if thumNail.attrs["height"] == "41":
                thumNailData.append(thumNail["src"])


    webtoon = []
    episode = []
    for index in range(10):
        episode.append(titleData[index])
        episode.append(urlData[index])
        episode.append(ratingData[index])
        episode.append(dateData[index])
        episode.append(thumNailData[index])
        webtoon.append(episode)
        episode = []

    print(webtoon)


