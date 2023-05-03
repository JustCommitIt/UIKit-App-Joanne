//
//  ViewController.swift
//  LoginProject
//
//  Created by 김요한 on 2023/05/03.
//

import UIKit

//✅ 스토리보드 사용하지 않고 코딩만으로 앱만들기

// 관습적으로 final붙어야함!
final class ViewController: UIViewController {
    
    
    // MARK: - 이메일을 입력하는 텍스트뷰
    
    // 디테일한 설정 후 메모리에 올린것 뿐.
    //클로저 실행문을 실행한뒤 리턴을 한다.
    
    // 이메일 입력 텍스트뷰
    private lazy var emailTextFieldView: UIView = { // private 이 클래스 내부에서만 접근 가능하도록 하는 키워드, addSubView를 사용하려면 반드시 lazy var 로 선언
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        // ⭐️ 이메일 텍스트필드뷰위에 이메일입력필드, 이메일인포레이블을 올리는 개념.
        view.addSubview(emailTextField)
        view.addSubview(emailInfoLabel)
        return view
    }()
    
    // "이메일 또는 전화번호" 안내문구
    private var emailInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 주소 또는 전화번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return label
    }()
    
    // 로그인 - 이메일 입력 필드
    private lazy var emailTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none // 자동대문자
        tf.autocorrectionType = .no // 틀린문자 체크
        tf.spellCheckingType = .no // 스펠링 체크
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged) // editingChanged 값이 편할때마다 셀렉터에 기재된 함수 호출
        return tf
    }()
    
    // MARK: - 비밀번호를 입력하는 텍스트 뷰
    
    private lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        // ⭐️ 패스워드 텍스트필드뷰위에 패스워드입력필드, 패스워드인포레이블, 패스워드 시큐어버튼 올리는 개념.
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    //패스워드텍스트필드의 안내문구
    private var passwordInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return label
    }()
    
    // 로그인 - 이메일 입력 필드
    private lazy var passwordTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none // 자동대문자
        tf.autocorrectionType = .no // 틀린문자 체크
        tf.spellCheckingType = .no // 스펠링 체크
        tf.isSecureTextEntry = true // 비밀번호를 가리는 설정
        tf.clearsOnBeginEditing = false
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged) // editingChanged 값이 편할때마다 셀렉터에 기재된 함수 호출

        return tf
    }()
    
    // 패스워드필드에 "표시" 버튼 비밀번호 가리기 기능
    private var passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.addTarget(self, action: #selector(passwordSecureModeSetting), for: .touchUpInside)
        return button
    }()
    
    // MARK: - 로그인 버튼
    private var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.clipsToBounds = true  // 바운드내부로 잘라낸다. 윗줄의 코너레디우스와 세트
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false // 버튼을 동작하는지 마는지 . 우선은 활상화 안하는 코드.
        button.addTarget(self, action: #selector(logInButonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - 비밀번호 재설정 버튼
    private var passwordResetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("비밀번호 재설정", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    // 이메일텍스트필드, 패스워드텍스트필드, 버튼 까지 하나로 묶는 스텍
    lazy var stackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton])
        st.spacing = 18
        st.axis = .vertical  // 축 정렬. 스텍에 묶을때 세로로 있는것을 묶을지, 가로로 있는것을 묶을지
        st.distribution = .fillEqually  // 분배를 어떻게 할것인지
        st.alignment = .fill
        return st
    }()
    
    
    // MARK: -
    // 3개의 각 텍스트필드 및 로그인 버튼의 높이 설정
    private let textViewHeight: CGFloat = 48
    
    // 오토레이아웃 향후 변경을 위한 변수 (애니메이션)
    lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor)
    lazy var passwordInfoLabelCenterYContraint = passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //⭐️delegate 패턴을 사용할떄 필히!
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        makeUI()
        
        
        
    }
    
    // 오토레이아웃
    func makeUI() {
        view.backgroundColor = UIColor.black
        
        // 제일 큰 뷰에 스텍 뷰를 올린다 스텍뷰로 전부 묶었기때문에
        view.addSubview(stackView)
        view.addSubview(passwordResetButton)
        
        // 오토레이아웃 잡을때 필수로 지정해주어야함. 자동으로 레이아웃잡는것 false 처리
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8), // 앞쪽 정렬
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8), // 뒷쪽 정렬
//            emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor), // 가운데 세로 정렬. 1) 고정 값이라 애니메이션을 위해 삭제
            emailInfoLabelCenterYConstraint,  // 2) 오토레이아웃 애니메이션을 위한 설정
            
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15), // 텍스트박스뷰 내부에서 윗쪽 간격
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2), //텍스트박스뷰 내부에서 아랫쪽 간격
            
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
//            passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
            passwordInfoLabelCenterYContraint,
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: 8),
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: 2),
            
            passwordSecureButton.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordSecureButton.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -15),
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36),
            
            passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            passwordResetButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            passwordResetButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight),
            
        ])
        
    }
    
    // MARK: - 비밀번호 가리기 모드 켜고 끄기

    @objc func passwordSecureModeSetting() {
        // 이미 텍스트필드에 내장되어 있는 기능
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    
    @objc func logInButonTapped(){
        print("로그인 버튼 눌림")
    }
    
    
    // 재설정버튼을 텝하면 alert창이 뜨도록.
    @objc func resetButtonTapped() {
        //        print("리셋버튼 눌림")
        let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)
        
        let success = UIAlertAction(title: "확인", style: .default) { action in
            //확인버튼이 눌리면 발생할 일
            print("확인눌림")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) {cancel in
            //캔슬버튼이 눌리면 발생할 일
            print("취소눌림")
        }
        
        // alert창을 만들고 창위에 올린다.
        alert.addAction(success)
        alert.addAction(cancel)
        
        
        //다음화면으로 넘어가는 메서드
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - 화면 바깥을 터치하면 키보드가 내려가도록
    // 기본제공함수를 제정의하자
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    // MARK: - 텍스트필드 편집 시작할때의 설정 - 문구가 위로올라가면서 크기 작아지고, 오토레이아웃 업데이트
    //텍스트필드가 시작이 되면
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            // 오토레이아웃 업데이트
            emailInfoLabelCenterYConstraint.constant = -13
        }
        
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            passwordInfoLabel.font = UIFont.systemFont(ofSize: 11)
            //오토레이아웃 업데이트
            passwordInfoLabelCenterYContraint.constant = -13
        }
        
        UIView.animate(withDuration: 0.3) {
            //애니메이션을 0.2초동안 자연스럽게 움직이게함.
            self.stackView.layoutIfNeeded()
        }
    }
    
    
    
    // 텍스트필드 편집 종료되면 백그라운드 색 변경 (글자가 한개도 입력 안되었을때는 되돌리기)
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = UIColor.darkGray
            
            // 빈칸이면 원래로 되돌리기
            if emailTextField.text == "" {
                emailInfoLabel.font = UIFont.systemFont(ofSize: 18)
                emailInfoLabelCenterYConstraint.constant = 0
            }
        }
        if textField == passwordTextField {
            passwordTextFieldView.backgroundColor = UIColor.darkGray
            
            // 빈칸이면 원래로 되돌리기
            if passwordTextField.text == "" {
                passwordInfoLabel.font = UIFont.systemFont(ofSize: 18)
                passwordInfoLabelCenterYContraint.constant = 0
            }
        }
        UIView.animate(withDuration: 0.2) {
            //애니메이션을 0.2초동안 자연스럽게 움직이게함.
            self.stackView.layoutIfNeeded()
        }
    }
    
    // MARK: - 이메일텍스트필드, 비밀번호 텍스트필드 두가지 다 채워져 있을때, 로그인 버튼 빨간색으로 변경
    
    @objc func textFieldEditingChanged(textField: UITextField) { // 파라미터를 텍스트필드로. #selector 을 통하여
        if textField.text?.count == 1 { //한개의 글자라면
            if textField.text?.first == " " { // 빈문자열이나
                textField.text = "" // 공백일때
                return // 벗어남
            }
        }
        guard
            let email = emailTextField.text, !email.isEmpty, // 이메일의 텍스트가 있고, 빈문자열이 아닐때
            let password = passwordTextField.text, !password.isEmpty else {
            loginButton.backgroundColor = .clear
            loginButton.isEnabled = false
            return
        }
        loginButton.backgroundColor = .red
        loginButton.isEnabled = true
    }
}


