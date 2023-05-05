//
//  BMICalculatorManage.swift
//  BMICalculator
//
//  Created by 김요한 on 2023/05/05.
//

import UIKit

// BMI를 계산하는 모든 로직을 여기에
struct BMICalculatorManager {
    
    //bmi계산 결과값을 보관하기 위한 변수
    var bmi: Double?
    
    //bmi계산하는 함수
    mutating func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = 0.0 // 값이 제대로 안들어오면 그냥 0.0 함수를 벗어남.
            return
        }
        var bmiNumber = w / (h * h) * 10000
        bmi = round(bmiNumber * 10) / 10 // 반올림처리 해주는 방법
    }
    
    
    // bmi결과값을 뱉어주는 함수
    func getBMIResult() -> Double {
        return bmi ?? 0.0 // Double?옵셔널 사용 하지 않으려면 기본값을 제시해주면 된다
    }
    
    
    // bmi 숫자에 맞게 결과페이지 레이블 백그라운드 컬러 변경하는 함수
    func getBackgroundColor () -> UIColor {
        guard let bmi = bmi else { return UIColor.black}
        switch bmi {
        case ..<18.6:
            return UIColor.red
        case 18.6..<23.0:
            return UIColor.orange
        case 23..<25.0:
            return UIColor.yellow
        case 25.0..<30.0:
            return UIColor.green
        case 30.0...:
            return UIColor.blue
        default:
            return UIColor.black
        }
    }
    
    // 문자열을 얻는 함수
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "" }
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
