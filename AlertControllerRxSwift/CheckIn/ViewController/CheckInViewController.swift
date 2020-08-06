//
//  CheckInViewController.swift
//  AlertControllerRxSwift
//
//  Created by Сычев Евгений Дмитриевич on 28.07.2020.
//  Copyright © 2020 Сычев Евгений Дмитриевич. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - CheckInViewController

final class CheckInViewController : UIViewController {
    
    // MARK: - Private properties

    private lazy var registrationLabel = UILabel()
    
    private lazy var loginHorizontallyStackView = UIStackView()
    private lazy var loginVerticallyStackView = UIStackView()
    private lazy var loginLabel = UILabel()
    private lazy var loginTextField = UITextField()
    private lazy var loginButton = UIButton()
    
    private lazy var passwordHorizontallyStackView = UIStackView()
    private lazy var passwordVerticallyStackView = UIStackView()
    private lazy var passwordLabel = UILabel()
    private lazy var passwordTextField = UITextField()
    private lazy var passwordButton = UIButton()
    
    private lazy var checkRegistrationButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    private var login = PublishSubject<String?>()
    private var password = PublishSubject<String?>()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setBinding()
        layout()
    }
    
    private func checkLoginAndPass() {
        if self.loginTextField.text == "login", self.passwordTextField.text == "password" {
            self.callAlert(title: "Молодцы", message: "Логин и пароль правельные")
            self.loginTextField.text = ""
            self.passwordTextField.text = ""
        } else {
            self.callAlert(title: "Ошибка", message: "Логин и пароль не верны")
            self.loginTextField.text = ""
            self.passwordTextField.text = ""
        }
    }
}


// MARK: - Setups

private extension CheckInViewController {
    
    func setViews() {
        
        addViews()
        addStack()
        
        setMainView()
        
        setRegistrationLabel()
        
        setLoginVerticallyStackView()
        setLoginHorizontallyStackView()
        setLoginLabel()
        setLoginButton()
        setLoginTextField()
        
        setPasswordVerticallyStackView()
        setPasswordHorizontallyStackView()
        setPasswordLabel()
        setPasswordButton()
        setPasswordTextField()
        
        setCheckRegistrationButton()
    }
    
    func setBinding() {
        loginButton
            .rx
            .tap
            .bind { [weak self] _ in
                guard let self = self else { return }
                
                self.callAlertBinding(title: "Данные", message: "Введите логин", text: self.login)
            }
            .disposed(by: disposeBag)
        
        login
            .asObserver()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                self.loginTextField.text = $0
            })
            .disposed(by: disposeBag)
        
        passwordButton
            .rx
            .tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                self.callAlertBinding(title: "Данные", message: "Введите пароль", text: self.password)
            }
            .disposed(by: disposeBag)
        
        password
            .asObserver()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                self.passwordTextField.text = $0
            })
            .disposed(by: disposeBag)
        
        checkRegistrationButton.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            
            self.checkLoginAndPass()
            
            }
            .disposed(by: disposeBag)   
    }
}

// MARK: - Setup View

private extension CheckInViewController {

    func addViews() {
        
        view.addSubview(registrationLabel)
        view.addSubview(loginVerticallyStackView)
        view.addSubview(passwordVerticallyStackView)
        view.addSubview(checkRegistrationButton)
    }
    
    func addStack() {
        
        loginVerticallyStackView.addArrangedSubview(loginLabel)
        loginVerticallyStackView.addArrangedSubview(loginHorizontallyStackView)
        loginHorizontallyStackView.addArrangedSubview(loginTextField)
        loginHorizontallyStackView.addArrangedSubview(loginButton)
        
        passwordVerticallyStackView.addArrangedSubview(passwordLabel)
        passwordVerticallyStackView.addArrangedSubview(passwordHorizontallyStackView)
        passwordHorizontallyStackView.addArrangedSubview(passwordTextField)
        passwordHorizontallyStackView.addArrangedSubview(passwordButton)
    }
    
    func setMainView() {
        
        view.backgroundColor = UIColor.mainViewColor
    }
    
    func setRegistrationLabel() {
        
        registrationLabel.text = Constants.registrationLabelText
        registrationLabel.textAlignment = .center
        registrationLabel.font = UIFont.systemFont(ofSize: Constants.registrationLabelFont, weight: .bold)
    }
    
    func setLoginVerticallyStackView() {
        
        loginVerticallyStackView.axis = .vertical
        loginVerticallyStackView.alignment = .fill
        loginVerticallyStackView.distribution = .fillEqually
        loginVerticallyStackView.spacing = Constants.loginVerticallyStackViewSpacing
    }
    
    func setLoginHorizontallyStackView() {
        
        loginHorizontallyStackView.axis = .horizontal
        loginHorizontallyStackView.alignment = .fill
        loginHorizontallyStackView.distribution = .fillProportionally
        loginHorizontallyStackView.spacing = Constants.loginHorizontallyStackViewSpacing
    }
    
    func setLoginLabel() {
        
        loginLabel.text = Constants.loginLabelText
        loginLabel.font = UIFont.systemFont(ofSize: Constants.loginLabelFontOfSize, weight: .regular)
        loginLabel.backgroundColor = Constants.loginLabelBackgroundColor
    }
    
    func setLoginButton() {
        
        loginButton.backgroundColor = Constants.loginButtonBackgroundColor
        loginButton.setTitle(Constants.loginButtonTitle, for: .normal)
        loginButton.layer.cornerRadius = Constants.loginButtonCornetRadius
    }
    
    func setLoginTextField() {
        
        loginTextField.backgroundColor = Constants.loginTextFieldBackgroundColor
        loginTextField.placeholder = Constants.loginTextFieldPlaceholder
    }
    
    func setPasswordVerticallyStackView() {
        
        passwordVerticallyStackView.axis = .vertical
        passwordVerticallyStackView.alignment = .fill
        passwordVerticallyStackView.distribution = .fillEqually
        passwordVerticallyStackView.spacing = Constants.loginVerticallyStackViewSpacing
    }
    
    func setPasswordHorizontallyStackView() {
        
        passwordHorizontallyStackView.axis = .horizontal
        passwordHorizontallyStackView.alignment = .fill
        passwordHorizontallyStackView.distribution = .fillProportionally
        passwordHorizontallyStackView.spacing = Constants.loginHorizontallyStackViewSpacing
    }
    
    func setPasswordLabel() {
        
        passwordLabel.text = Constants.loginLabelText
        passwordLabel.font = UIFont.systemFont(ofSize: Constants.loginLabelFontOfSize, weight: .regular)
        passwordLabel.backgroundColor = Constants.loginLabelBackgroundColor
    }
    
    func setPasswordButton() {
        
        passwordButton.backgroundColor = Constants.loginButtonBackgroundColor
        passwordButton.setTitle(Constants.loginButtonTitle, for: .normal)
        passwordButton.layer.cornerRadius = Constants.loginButtonCornetRadius
    }
    
    func setPasswordTextField() {
        
        passwordTextField.backgroundColor = Constants.loginTextFieldBackgroundColor
        passwordTextField.placeholder = Constants.loginTextFieldPlaceholder
    }
    
    func setCheckRegistrationButton() {
        
        checkRegistrationButton.backgroundColor = Constants.checkRegistrationButtonBackgroundColor
        checkRegistrationButton.setTitle(Constants.chechRegistrationButtonTitle, for: .normal)
        checkRegistrationButton.layer.cornerRadius = Constants.checkRegistrationButtonCornerRadius
    }
}

// MARK: - Layout

private extension CheckInViewController {
    
    func layout() {
        
        registrationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            registrationLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: Constants.registrationLabelTopAnchor),
            registrationLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.registrationLabelLeadingAnchor),
            registrationLabel.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.registrationLabelTrailingAnchor),
            registrationLabel.heightAnchor.constraint(
                equalToConstant: Constants.registrationLabelHeightAnchor)])
        
        loginVerticallyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginVerticallyStackView.topAnchor.constraint(
                equalTo: registrationLabel.bottomAnchor,
                constant: Constants.loginStackVerticallyViewTopAnchor),
            loginVerticallyStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.loginStackVerticallyViewLeadingAnchor),
            loginVerticallyStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.loginStackVerticallyViewTrailingAnchor),
            loginVerticallyStackView.heightAnchor.constraint(
                equalToConstant: Constants.loginStackVerticallyViewHeightAnchor)])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.widthAnchor.constraint(
                equalToConstant: Constants.loginButtonWidthAnchor)])
        
        passwordVerticallyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordVerticallyStackView.topAnchor.constraint(
                equalTo: loginVerticallyStackView.bottomAnchor,
                constant: Constants.passwordStackVerticallyViewTopAnchor),
            passwordVerticallyStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.passwordStackVerticallyViewLeadingAnchor),
            passwordVerticallyStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.passwordStackVerticallyViewTrailingAnchor),
            passwordVerticallyStackView.heightAnchor.constraint(
                equalToConstant: Constants.passwordStackVerticallyViewHeightAnchor)])
        
        passwordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordButton.widthAnchor.constraint(
                equalToConstant: Constants.passwordButtonWidthAnchor)])
        
        checkRegistrationButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkRegistrationButton.topAnchor.constraint(
                equalTo: passwordVerticallyStackView.bottomAnchor,
                constant: Constants.checkRegistrationStackVerticallyViewTopAnchor),
            checkRegistrationButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.checkRegistrationStackVerticallyViewLeadingAnchor),
            checkRegistrationButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.checkRegistrationStackVerticallyViewTrailingAnchor),
            checkRegistrationButton.heightAnchor.constraint(
                equalToConstant: Constants.checkRegistrationStackVerticallyViewHeightAnchor)])
    }
}

// MARK: - Constants

private extension CheckInViewController {
    
    enum Constants {
        static let registrationLabelText: String = "Регистрация"
        
        static let registrationLabelTopAnchor: CGFloat = 70
        static let registrationLabelLeadingAnchor: CGFloat = 20
        static let registrationLabelTrailingAnchor: CGFloat = -20
        static let registrationLabelHeightAnchor: CGFloat = 30
        
        static let loginStackVerticallyViewTopAnchor: CGFloat = 30
        static let loginStackVerticallyViewLeadingAnchor: CGFloat = 30
        static let loginStackVerticallyViewTrailingAnchor: CGFloat = -30
        static let loginStackVerticallyViewHeightAnchor: CGFloat = 60
        
        static let loginButtonWidthAnchor: CGFloat = 60
        static let loginButtonBackgroundColor: UIColor? = .loginButtonColor
        static let loginButtonTitle: String = "Edit"
        static let loginButtonCornetRadius: CGFloat = 8
        
        static let registrationLabelFont: CGFloat = 20
        
        static let loginVerticallyStackViewSpacing: CGFloat = 0
        
        static let loginHorizontallyStackViewSpacing: CGFloat = 15
        
        static let loginLabelText: String = "Логин"
        static let loginLabelFontOfSize: CGFloat = 16
        static let loginLabelBackgroundColor: UIColor = .clear
        
        static let loginTextFieldBackgroundColor: UIColor = .white
        static let loginTextFieldPlaceholder: String = "click for edit"
        
        static let passwordStackVerticallyViewTopAnchor: CGFloat = 30
        static let passwordStackVerticallyViewLeadingAnchor: CGFloat = 30
        static let passwordStackVerticallyViewTrailingAnchor: CGFloat = -30
        static let passwordStackVerticallyViewHeightAnchor: CGFloat = 60
        
        static let passwordButtonWidthAnchor: CGFloat = 60
        static let passwordButtonBackgroundColor: UIColor? = .loginButtonColor
        static let passwordButtonTitle: String = "Edit"
        static let passwordButtonCornetRadius: CGFloat = 8
        
        static let passwordVerticallyStackViewSpacing: CGFloat = 0
        
        static let passwordHorizontallyStackViewSpacing: CGFloat = 15
        
        static let passwordLabelText: String = "Логин"
        static let passwordLabelFontOfSize: CGFloat = 16
        static let passwordLabelBackgroundColor: UIColor = .clear
        
        static let passwordTextFieldBackgroundColor: UIColor = .white
        static let passwordTextFieldPlaceholder: String = "click for edit"
        
        static let checkRegistrationStackVerticallyViewTopAnchor: CGFloat = 30
        static let checkRegistrationStackVerticallyViewLeadingAnchor: CGFloat = 30
        static let checkRegistrationStackVerticallyViewTrailingAnchor: CGFloat = -30
        static let checkRegistrationStackVerticallyViewHeightAnchor: CGFloat = 60
        static let checkRegistrationButtonBackgroundColor: UIColor? = .loginButtonColor
        static let chechRegistrationButtonTitle: String = "Login"
        static let checkRegistrationButtonCornerRadius: CGFloat = 8
    }
    
}
