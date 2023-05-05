//
//  ViewController.swift
//  BMICalculator
//
//  Created by 김요한 on 2023/05/04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculatorBtn: UIButton!
    
  
    // 모델과 의사소통을 하기 위한 인스턴스 생성_ bmi 계산로직
    var bmiManager = BMICalculatorManager() //bmiManager을 이용하여 접근
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ⭐️ 텍스트필드는 델리게이트 패턴 필수 지정 요소
        heightTextField.delegate = self
        weightTextField.delegate = self
        makeUI()
    }
    
    func makeUI() {
  
        mainLabel.text = "키와 몸무게를 입력해주세요"
        calculatorBtn.clipsToBounds = true
        calculatorBtn.layer.cornerRadius = 5
        calculatorBtn.setTitle("BMI 계산하기", for: .normal)
        heightTextField.placeholder = "cm 단위로 입력해주세요"
        weightTextField.placeholder = "kg 단위로 입력해주세요"
        
        heightTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
        weightTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
        heightTextField.returnKeyType = .done
        weightTextField.returnKeyType = .done

    }

    
    @IBAction func calculatorBtnTapped(_ sender: UIButton) {
        // 버튼을 눌렀을때 입력받은 값을 bmiManager한테 전달만 하면 됨
        bmiManager.calculateBMI(height: heightTextField.text!, weight: weightTextField.text!)
            }
    
    // 직접세그웨이 구현시 자동으로 불려오는 매커니즘 ⭐️
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // 다음화면으로 넘어가는 것을 허락할지 말지
        if heightTextField.text == "" || weightTextField.text == "" { // 필드 두개가 빈문자열이면
            mainLabel.text = "키와 몸무게를 입력하셔야만 합니다"
            mainLabel.textColor = UIColor.red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해주세요"
        mainLabel.textColor = UIColor.black
        return true
    }
    
    // 데이터 전달하기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            // SecondViewController 타입캐스팅... 접근할 수 있도록
            let secondVC = segue.destination as! SecondViewController
            
            // 계산된 결과값을 다음화면으로 전달
            secondVC.bmiNumber = bmiManager.getBMIResult()
            secondVC.bmiColor = bmiManager.getBackgroundColor()
            secondVC.adviceString = bmiManager.getBMIAdviceString()
        }
        
        // 다음화면으로 넘어가기 전에 텍스트필드 비우기
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    
    
    
}

// 텍스트필드 델리게이트 패턴 ⭐️
extension ViewController: UITextFieldDelegate {
    
    // 텍스트필드에 글자가 하나하나 입력되는것을 감지하는 메소드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if Int(string) != nil || string == "" {
            return true  // 글자입력 허용
        }
        return false // 글자입력 허용 안함
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //두개의 텍스트필드를 모두 종료 (키보드 내려가기)
        if heightTextField.text != "", weightTextField.text != "" { //키텍스트필드가 빈칸이 아니고, 체중텍스트필드가 빈칸이 아니라면
            weightTextField.resignFirstResponder() // 첫번쨰 응답자의 역할을 해제. 키보드를 내리겠다.
            return true
        } else if heightTextField.text != "" { // 키텍스트필드가 빈칸이 아니면,
            weightTextField.becomeFirstResponder() // 체중텍스트필드에 첫번째 응답자 역할을 하겠다.
            return true
        }
         return false
        
    }
    
    // 화면밖을 터치하면 키보드 내려가게 하는 메소드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
}
