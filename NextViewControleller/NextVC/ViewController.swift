//
//  ViewController.swift
//  NextVC
//
//  Created by Allen H on 2021/12/05.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // 1) 코드로 화면 이동 (다음화면이 코드로 작성되어있을때만 가능한 방법)
    @IBAction func codeNextButtonTapped(_ sender: UIButton) {
        // 인스턴스를 찍어 메모리에 올림!
        let firstVC = FirstViewController()
        
        firstVC.someString = "안녕"
        //        firstVC.mainLabel.text = "안녕".  // 이렇게 직접적으로 전달 가능하지만 문제가 많아서 사용 x. 스토리보드로 만들면 에러발생!
        
        // 애플이 미리 만들어둔 함수(화면 넘어갈떄 사용)
        firstVC.modalPresentationStyle = .fullScreen // 전체화면 띄우기
        present(firstVC, animated: true, completion: nil) // completion 에는 화면이 넘어가면 어떤것을 실행할지 코딩함. 일반적으로 화면이 넘어갈때는 넘어가기만 하면 되니까 nil
        
    }
    
    // 2) 코드로 스토리보드 객체를 생성해서, 화면 이동
    @IBAction func storyboardWithCodeButtonTapped(_ sender: UIButton) {
        // 실패확률이 없다면 as!로 강제 타입캐스팅해도 됨. ⬇️
        //        let secondVC = storyboard?.instantiateViewController(identifier: "secondVC") as! SecondViewController
        //        present(secondVC, animated: true, completion: nil)
        
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? SecondViewController else { return }
        
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.someString = "반가워"
        //        secondVC.mainLabel.text = "오잉". // 에러 오지남 절대 ❌ 생성되는 순서가 꼬여서 그러함. 메모리에 스토리보드가 올라가고, 코드가 올라가기때문. 코드 스토리보드 연결 전에 되는것이라 에러임.
        
        present(secondVC, animated: true, completion: nil)
        
    }
    
    // 3) 스토리보드에서의 화면 이동
    @IBAction func storyboardWithSegueButtonTapped(_ sender: UIButton) {
        
        // 애플이 미리 구현해놓음. performSegue() - 간접 세그웨이 (화면전체)
        performSegue(withIdentifier: "toThirdVC", sender: self)
        
    }
    
    // 세그웨이에서 데이터를 전달하기 위해 애플이 구현해둔 기능 . prepare()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toThirdVC" {
            let thirdVC = segue.destination as! ThirdViewController
            // 데이터 전달
            thirdVC.someString = "잘 지냈어?😆"
            thirdVC.modalPresentationStyle = .fullScreen
            
        }
        if segue.identifier == "toFourthVC" {
            let fourthVC = segue.destination as! FourthViewController
            fourthVC.someString = "잘 지내!😆"
            fourthVC.modalPresentationStyle = .fullScreen
        }
        
    }
    
    // 스토리보드 객체(버튼)에서 직접적으로 연결한 직접 세그웨이에서만 사용 가능.
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // 세그웨이를 실행할지 말지 결정할 수 있음. 조건에 따라서!
        if true {
            return true
            
        } else {
            return false
            
        }
    }
    
    
    
}

