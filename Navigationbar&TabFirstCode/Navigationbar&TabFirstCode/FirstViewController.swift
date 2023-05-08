//
//  ViewController.swift
//  Navigationbar&TabFirstCode
//
//  Created by 김요한 on 2023/05/08.
//

import UIKit

// present를 통한 화면 전환은 이전화면이 그대로 메모리상 유지되는 것인데 로그인 화면을 굳이 유지할 필요가 있는가!
// 첫화면 자체를 기본 앱화면으로 설정하고 로그인 유무에 따라 로그인창을 띄워주는것이 합리적임.

// 이 자체에 네비케이션 컨트롤러와 텝바 컨트롤러를 넣는다.
class FirstViewController: UIViewController {
    
    // 로그인 여부에 관련된 참/거짓 저장하는 속성
    var isLoggedIn = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
        
        // ⭐️ 로그인이 되어있지 않다면 로그인화면 띄우기
        // =====> viewDidAppear가 더 정확한 시점 (뷰가 뜬 다음으로 코드 옮기기) ⭐️⭐️⭐️
        
//        if !isLoggedIn {
//            let vc = LoginViewController()
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: false, completion: nil)
//        }
    }
    
    // 다음화면을 띄우는 더 정확한 시점 ⭐️⭐️⭐️
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ⭐️로그인이 되어 있지 않다면 로그인 화면 띄우기
        if !isLoggedIn {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc,animated: false, completion: nil)
        }
    }

    
    
    func makeUI() {
        view.backgroundColor = .gray
        
        // (네비게이션바 설정관련) iOS버전 업데이트 되면서 바뀐 설정⭐️⭐️⭐️
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        //appearance.backgroundColor = .brown     // 색상설정
        
        //appearance.configureWithTransparentBackground()  // 투명으로
        
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        title = "Main"
    }
    

    
}

