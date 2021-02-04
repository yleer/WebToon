//
//  Model.swift
//  WebToon
//
//  Created by Yundong Lee on 2021/01/26.
//

import Foundation

struct Model {
    
    var webtoon = [[WebtoonModel]]()
    var mondayWebtoon : [WebtoonModel] = []
    var tuesdayWebtoon : [WebtoonModel] = []
    var wendsdayWebtoon : [WebtoonModel] = []
    var thursdayWebtoon : [WebtoonModel] = []
    var fridayWebtoon : [WebtoonModel] = []
    var saturdayWebtoon : [WebtoonModel] = []
    var sundayWebtoon : [WebtoonModel] = []
    
    init() {
        // MARK: monday init
        let 참교육 = WebtoonModel(url: 참교육url,title: "참교육" ,episodes: 참교육episodes, rating: "9.75",author: "채용택 / 한가람", discription: 참교육description)
        let 뷰티플군바리 = WebtoonModel(url: 뷰티플군바리url,title: "뷰티플 군바리", episodes: 뷰티플군바리episode, rating: "9.82",author: "설이 / 윤성원",discription: 뷰티풀군바리description)
        let 윈드브레이커 = WebtoonModel(url: 윈드브레이커url,title:"윈드브레이커", episodes: 윈드브레이커episode, rating: "9.87",author: "조용석",discription: 윈드브레이커description)
        let 소녀의세계 = WebtoonModel(url: 소녀의세계url,title:"소녀의 세계", episodes:소녀의세계episode, rating: "9.97",author: "모랑지",discription: 소녀의세계description)
        let 백수세끼 = WebtoonModel(url: 백수세끼url,title: "백수세끼", episodes: 백수세끼episode, rating: "9.87",author: "치즈",discription: 백수세끼description)
        let 장씨세가호위무사 = WebtoonModel(url: 장씨세가호위무사url,title: "장씨세가호위무사" ,episodes: 장씨세가호위무사episode, rating: "9.97",author: "조형근 / 김인호",discription: 장씨세가호위무사description)
        let 만렙돌파 = WebtoonModel(url: 만렙돌파url,title:"만렙돌파" ,episodes: 만렙돌파episode, rating: "8.41",author: "성불예정,홍실 / 미노",discription: 만렙돌파description)
        let 파이게임 = WebtoonModel(url: 파이게임url,title:"파이게임" ,episodes: 파이게임episode, rating: "9.74",author: "배진수",discription: 파이게임description)
        let 앵무살수 = WebtoonModel(url: 앵무살수url,title:"앵무살수" ,episodes: 앵무살수episode, rating: "9.98",author: "김성진",discription: 앵무살수description)
        let 선배그립스틱 = WebtoonModel(url: 선배그립스틱바르지마요url,title: "선배그립스틱바르지마요",episodes: 선배그립스틱바르지마요episode, rating: "9.81",author: "까페라떼 / JINHA",discription: 선배그립스틱바르지마요description)
        let 유일무이로멘스 = WebtoonModel(url: 유일무이로맨스url,title:"유일무이로멘스", episodes: 유일무이로맨스episode, rating: "9.98",author: "두부",discription: 유일무이로맨스description)
        let 칼가는소녀 = WebtoonModel(url: 칼가는소녀url,title: "칼가는소녀" ,episodes: 칼가는소녀episode, rating: "9.97",author: "오리",discription: 칼가는소녀description)
        let 요리go = WebtoonModel(url: 요리gourl, title:"요리go" ,episodes: 요리goepisode, rating: "9.93",author: "HO9",discription: 요리godescription)
        
        let 바이러스x = WebtoonModel(url: 바이러스xurl, title: "바이러스x", episodes: 바이러스xepisode, rating: "7.43", author: "준 / 하랑",discription: 바이러스xdescription)
        let 오늘의순정만화 = WebtoonModel(url: 오늘의순정만화url, title: "오늘의순정만화", episodes: 오늘의순정만화episode, rating: "9.98", author: "손하기",discription: 오늘의순정만화description)
        let 히어로메이커 = WebtoonModel(url: 히어로메이커빤쓰url, title: "히어로메이커", episodes: 히어로메이커빤쓰episode, rating: "9.96", author: "빤쓰",discription: 히어로메이커빤쓰description)
        let 리턴투플레이어 = WebtoonModel(url: 리턴투플레이어url, title: "리턴 투 플레이어", episodes: 리턴투플레이어episode, rating: "9.90", author: "인덱스 / 세혼",discription: 리턴투플레이어description)
        let 트리거 = WebtoonModel(url: 트리거고경빈url, title: "트리거", episodes: 트리거고경빈episode, rating: "9.76", author: "고경빈",discription: 트리고description)
        let 결혼생활그림 = WebtoonModel(url: 결혼생활그림일기url, title: "결혼생활 그림일기", episodes: 결혼생활그림일기episode, rating: "9.93", author: "은꼼지",discription: 결혼생활그림일기description)
        let 순정말고순종 = WebtoonModel(url: 순정말고순종url, title: "순정말고 순종", episodes: 순정말고순종episode, rating: "9.94", author: "슈안",discription: 순정말고순종description)
        let 라서드 = WebtoonModel(url: 라서드감람url, title:"라서드", episodes: 라서드감람episode, rating: "9.85", author: "감람",discription: 라서드감람description)
        let 싸이코리벤지 = WebtoonModel(url: 싸이코리벤지url, title: "싸이코 리벤지", episodes: 싸이코리벤지episode, rating: "9.74", author: "기송 / 넴가",discription: 싸이코리벤지description)
        let 이탄국의자청비 = WebtoonModel(url: 이탄국의자청비url, title: "이탄국의 자청비", episodes: 이탄국의자청비episode, rating: "9.67", author: "김보람 / 나넷",discription: 이탄국의자청비description)
        let 평범한8반 = WebtoonModel(url: 평범한8반url, title: "평범한 8반", episodes: 평범한8반episode, rating: "9.85", author: "영파카",discription: 평범한8반description)
        
        mondayWebtoon.append(참교육)
        mondayWebtoon.append(뷰티플군바리)
        mondayWebtoon.append(윈드브레이커)
        mondayWebtoon.append(소녀의세계)
        mondayWebtoon.append(백수세끼)
        mondayWebtoon.append(장씨세가호위무사)
        mondayWebtoon.append(만렙돌파)
        mondayWebtoon.append(파이게임)
        mondayWebtoon.append(앵무살수)
        mondayWebtoon.append(선배그립스틱)
        mondayWebtoon.append(유일무이로멘스)
        mondayWebtoon.append(칼가는소녀)
        mondayWebtoon.append(요리go)
        mondayWebtoon.append(바이러스x)
        mondayWebtoon.append(오늘의순정만화)
        mondayWebtoon.append(히어로메이커)
        mondayWebtoon.append(리턴투플레이어)
        mondayWebtoon.append(트리거)
        mondayWebtoon.append(결혼생활그림)
        mondayWebtoon.append(순정말고순종)
        mondayWebtoon.append(라서드)
        mondayWebtoon.append(싸이코리벤지)
        mondayWebtoon.append(이탄국의자청비)
        mondayWebtoon.append(평범한8반)
        
        
        // MARK: tuesday init
        
        let 여신강림 = WebtoonModel(url: 여신강림url, title: "여신강림", episodes: 여신강림episode, rating: "9.62", author: "야옹이",discription: 여신강림description)
        let 관계의종말 = WebtoonModel(url: 관계의종말url, title: "관계의 종말", episodes: 관계의종말episode, rating: "9.76", author: "김용키",discription: 관계의종말description)
        let 한림체육관 = WebtoonModel(url: 한림체육관url, title: "한림체육관", episodes: 한림체육관episode, rating: "9.72", author: "혜성 / 이석재",discription: 한림체육관description)
        let 바른연애길잡이 = WebtoonModel(url: 바른연애길잡이url, title: "바른연애 길잡이", episodes: 바른연애길잡이episode, rating: "9.97", author: "남수",discription: 바른연애길잡이description)
        let 랜덤채팅의그녀 = WebtoonModel(url: 랜던채팅의그녀url, title: "랜덤채팅의 그녀!", episodes: 랜던채팅의그녀episode, rating: "9.68", author: "박은혁",discription: 랜덤채팅의그녀description)
        let 하루만네가되고싶어 = WebtoonModel(url: 하루만네가되고싶어url, title: "하루만 네가 되고 싶어", episodes: 하루만네가되고싶어episode, rating: "9.98", author: "삼",discription: 하루만네가되고싶어description)
        let 중증외상센터 = WebtoonModel(url: 중증외상센터골든아워url, title: "중증외상센터 : 골든 아워", episodes: 중증외상센터골든아워episode, rating: "9.97", author: "한산이가 / 홍비치라",discription: 중증외상센터골든아워description)
        let 사신소녀 = WebtoonModel(url: 사신소녀url, title: "사신소년", episodes: 사신소녀episode, rating: "9.92", author: "류",discription: 사신소녀description)
//        let 헬58 = WebtoonModel(url: 헬58url, title: "헬58", episodes: 헬58episode, rating: "9.95", author: "장성준")
        let 신도림 = WebtoonModel(url: 신도림url, title: "신도림", episodes: 신도림episode, rating: "9.95", author: "오세형",discription: 신도림description)
        
        
        tuesdayWebtoon.append(여신강림)
        tuesdayWebtoon.append(관계의종말)
        tuesdayWebtoon.append(한림체육관)
        tuesdayWebtoon.append(바른연애길잡이)
        tuesdayWebtoon.append(랜덤채팅의그녀)
        tuesdayWebtoon.append(하루만네가되고싶어)
        tuesdayWebtoon.append(중증외상센터)
        tuesdayWebtoon.append(사신소녀)
//        tuesdayWebtoon.append(헬58)
        tuesdayWebtoon.append(신도림)
//
        webtoon.append(mondayWebtoon)
        webtoon.append(tuesdayWebtoon)
        webtoon.append(wendsdayWebtoon)
        webtoon.append(thursdayWebtoon)
        webtoon.append(fridayWebtoon)
        webtoon.append(saturdayWebtoon)
        webtoon.append(sundayWebtoon)
    }
    
}



















