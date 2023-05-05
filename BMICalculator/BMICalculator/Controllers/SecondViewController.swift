//
//  SecondViewController.swift
//  BMICalculator
//
//  Created by 김요한 on 2023/05/04.
//

import UIKit

class SecondViewController: UIViewController {

 
    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    // 이 변수를 통해 전화면에서 데이터를 받는다.
    var bmi: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    func makeUI(){
        // UI셋팅
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
        backBtn.clipsToBounds = true
        backBtn.layer.cornerRadius = 5
        backBtn.setTitle("다시 계산하기", for: .normal)
        
        // 전화면에서 전달받은 BMI를 통해 셋팅
        bmiNumberLabel.text = "\(bmi?.value)"
        bmiNumberLabel.backgroundColor = bmi?.matchColor
        adviceLabel.text = bmi?.advice
        
    }
    

    @IBAction func backBtnTapped(_ sender: UIButton) {
        // 전화면으로 돌아가는 메서드
        self.dismiss(animated: true, completion: nil)
        
    }
    
    

}
