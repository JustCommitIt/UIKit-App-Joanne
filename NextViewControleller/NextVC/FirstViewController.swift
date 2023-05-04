//
//  FirstViewController.swift
//  NextVC
//
//  Created by 김요한 on 2023/05/04.
//

//📍 코드를 통한 화면 생성



import UIKit

class FirstViewController: UIViewController {
    
    // 1. 레이블을 메모리에 올림
    let mainLabel = UILabel()
    
    // 클로저의 실행문을 통해 버튼을 만들어보자_ 선호도에 따라 다름
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // mainLabel에 데이터를 전달받는 함수. 일반적으로 옵셔널로 받아옴.
    var someString: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        makeAutoUI()

    }
    
    func configureUI(){
        mainLabel.text = someString //옵셔널이지만 언래핑하지 않아도 됨. text자체가 옵셔널
        mainLabel.font = UIFont.systemFont(ofSize: 22)
        
        // 2. 뷰위에 메인레이블뷰를 서브뷰로 올림
        view.addSubview(mainLabel)
        view.addSubview(backButton)
        
        view.backgroundColor = .gray
    }
    
    func makeAutoUI(){
        // 3. 오토레이아웃 잡아주기 (위치선정)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    

    @objc func backButtonTapped() {
        // 애플이 제공하는 뒤로가기 기능
        dismiss(animated: true, completion: nil)
    }

}
