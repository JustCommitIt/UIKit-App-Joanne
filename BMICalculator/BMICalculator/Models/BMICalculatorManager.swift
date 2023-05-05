//
//  BMICalculatorManage.swift
//  BMICalculator
//
//  Created by 김요한 on 2023/05/05.
//

import UIKit

// BMI를 계산하는 모든 로직을 여기에 간단하면 구조체 앱이 커지면 클래스로 변경
struct BMICalculatorManager {
    
    //bmi계산 결과값을 보관하기 위한 변수
    var bmi: BMI?   // 모델 BMI파일안에 구조체
    
    mutating func getBMI(height: String, weight: String) -> BMI {
        //BMI만들기 메서드 호출
        calculateBMI(height:height, weight:weight)
        //BMI리턴
        return bmi ?? BMI(value: 0.0, advice: "에러발생", matchColor: UIColor.white)
    }
    
    mutating private func calculateBMI (height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = BMI(value: 0.0, advice: "에러 발생", matchColor: UIColor.white)
            return
        }
        
        var bmiNum = w / (h * h) * 10000
        bmiNum = round(bmiNum * 10) / 10
        
        switch bmiNum {
        case ..<18.6:
            let color = UIColor.red
            bmi = BMI(value: bmiNum, advice: "저체중", matchColor: color)
        case 18.6..<23.0:
            let color = UIColor.orange
            bmi = BMI(value: bmiNum, advice: "표준", matchColor: color)
        case 23..<25.0:
            let color = UIColor.yellow
            bmi = BMI(value: bmiNum, advice: "과체중", matchColor: color)
        case 25.0..<30.0:
            let color = UIColor.green
            bmi = BMI(value: bmiNum, advice: "비만", matchColor: color)
        case 30.0...:
            let color = UIColor.blue
            bmi = BMI(value: bmiNum, advice: "고도비만", matchColor: color)
        default:
            bmi = BMI(value: 0.0, advice: "문제발생", matchColor: UIColor.white)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    //bmi계산하는 함수
//    mutating func calculateBMI(height: String, weight: String) {
//        guard let h = Double(height), let w = Double(weight) else {
//            bmi = 0.0 // 값이 제대로 안들어오면 그냥 0.0 함수를 벗어남.
//            return
//        }
//        var bmiNumber = w / (h * h) * 10000
//        bmi = round(bmiNumber * 10) / 10 // 반올림처리 해주는 방법
//    }
//
//
//    // bmi결과값을 뱉어주는 함수
//    func getBMIResult() -> BMI {
//        return bmi ?? BMI(value: 0.0, matchColor: .white, advice: "에러발생") // Double?옵셔널 사용 하지 않으려면 기본값을 제시해주면 된다
//    }
//
//
//    // bmi 숫자에 맞게 결과페이지 레이블 백그라운드 컬러 변경하는 함수
//    func getBackgroundColor () -> UIColor {
//        guard let bmi = bmi else { return UIColor.black}
//        switch bmi {
//        case ..<18.6:
//            return UIColor.red
//        case 18.6..<23.0:
//            return UIColor.orange
//        case 23..<25.0:
//            return UIColor.yellow
//        case 25.0..<30.0:
//            return UIColor.green
//        case 30.0...:
//            return UIColor.blue
//        default:
//            return UIColor.black
//        }
//    }
//
//    // 문자열을 얻는 함수
//    func getBMIAdviceString() -> String {
//        guard let bmi = bmi else { return "" }
//        switch bmi {
//        case ..<18.6:
//            return "저체중"
//        case 18.6..<23.0:
//            return "표준"
//        case 23..<25.0:
//            return "과체중"
//        case 25.0..<30.0:
//            return "비만"
//        case 30.0...:
//            return "고도비만"
//        default:
//            return ""
//        }
//    }
//
//
//
//
//
//
//
//
//
//
//
//
}
