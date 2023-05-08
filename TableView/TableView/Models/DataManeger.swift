//
//  DataManeger.swift
//  TableView
//
//  Created by 김요한 on 2023/05/08.
//

import UIKit

// 뷰컨트롤러가 요청했을때 배열을 전달해주고...

class DataManager {
    var movieDataArray: [Movie] = []
    
    // 무비 배열을 만드는 함수, 통신할때 이렇게 많이 합니당
    func makeMovieData() {
        movieDataArray = [
            Movie(movieImage: UIImage(named: "batman.png"), movieName: "베트맨", movieDescription: "베트맨이 출현하는 영화"),
            Movie(movieImage: UIImage(named: "captain.png"), movieName: "캡틴 아메리카", movieDescription: "캡틴아메리카가 출현하는 영화"),
            Movie(movieImage: UIImage(named: "ironman.png"), movieName: "아이언맨", movieDescription: "아이언맨이 출현하는 영화"),
            Movie(movieImage: UIImage(named: "thor.png"), movieName: "토르", movieDescription: "토르가 출현하는 영화"),
            Movie(movieImage: UIImage(named: "hulk.png"), movieName: "헐크", movieDescription: "헐크가 출현하는 영화"),
            Movie(movieImage: UIImage(named: "spiderman.png"), movieName: "스파이더맨", movieDescription: "스파이더맨이 출현하는 영화"),
            Movie(movieImage: UIImage(named: "blackpanther.png"), movieName: "블랙팬서", movieDescription: "블랙팬서 출현하는 영화"),
            Movie(movieImage: UIImage(named: "doctorstrange.png"), movieName: "닥터 스트레인지", movieDescription: "닥터스트레인지가 출현하는 영화"),
            Movie(movieImage: UIImage(named: "guardians.png"), movieName: "가디언즈 오브 갤럭시 ", movieDescription: "가오갤이 출현하는 영화")
        ]
    }
    
    // 뷰컨트롤러에서 데이터 내놔! 
    func getMovieData() ->[Movie] {
        return movieDataArray
    }
    
    func updateMovieData() {
        
        let movie = Movie(movieImage:UIImage(named:"spiderman2.png"),movieName: "스파이더맨2", movieDescription: "스파이더맨 시즌2")
        
        movieDataArray.append(movie)
    }
    
    
    
    
    
    
    
    
}
