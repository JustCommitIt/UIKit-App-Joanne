//
//  ViewController.swift
//  FirstNewApp
//
//  Created by 김요한 on 2023/05/01.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    var timer: Timer?
    
    var number: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    
    func configureUI() {
        mainLabel.text = "초를 선택하세요⏲️"
        
        //✅ 슬라이더 버튼을 가운데 오도록 설정
        slider.value = 0.5

    }

    // 📍 슬라이더가 변할때마다 아래의 함수가 실행 됨.
    @IBAction func sliderChanged(_ sender: UISlider) {
         //✅ 슬라이더의 벨류값을 가지고 메인레이블의 텍스트를 셋팅
        let seconds = Int(slider.value * 60)
        mainLabel.text = "\(seconds)초"
        number = seconds
    }
    
    
    
    @IBAction func startBtnTapped(_ sender: UIButton) {
        //✅ 1초씩 지나갈때마다 무언가를 실행
        
        timer?.invalidate()
        //❗️ 객체 내부에서 클로져를 사용할때는 self를 사용해주어야함.
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
            // 반복을 하고 싶은 코드
            
            if number > 0 {
                number -= 1
                // 1. 메인레이블의 숫자도 줄어들고
                // 2. 슬라이더도 왼쪽으로 움직이고
                slider.value = Float(number) / Float(60)
                mainLabel.text = "\(number)초"
            } else {
                number = 0
                mainLabel.text = "초를 선택하세요⏲️"
                // 3. 0에 수렴하면 알람소리도 울림. 그리고 타이머를 비활성화 해줘야하는것도 필수
                timer?.invalidate() //타이머 비활성화
                AudioServicesPlayAlertSound(SystemSoundID(1322))
            }
        }
    }
    
    
    @IBAction func resetBtnTapped(_ sender: UIButton) {
        //✅ 초기화 셋팅
        mainLabel.text = "초를 선택하세요⏲️"
        
        // ✅ 슬라이더 버튼을 가운데 오도록 설정
//        slider.setValue(0.5, animated: true)
        slider.value = 0.5
        number = 0
        timer?.invalidate() // 타이머 비활성화 "timer = nil" 로 대체 가능

    }
    
    
    
}

