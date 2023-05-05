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
    
    // 이 변수를 통해 데이터를 받는다
    var bmiNumber: Double?
    var adviceString: String?
    var bmiColor: UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()

    }
    func makeUI(){
        
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
        backBtn.clipsToBounds = true
        backBtn.layer.cornerRadius = 5
        backBtn.setTitle("다시 계산하기", for: .normal)

        guard let bmiNumber = bmiNumber else { return }
        bmiNumberLabel.text = String(bmiNumber)
        
        adviceLabel.text = adviceString
        bmiNumberLabel.backgroundColor = bmiColor
        
    }
    

    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    

}
