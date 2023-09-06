//
//  SignInView.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

import SnapKit
import UIKit

final class SignInView: UIView {

    // MARK: - Views

    lazy var lblBack: UILabel = {
        let label = UILabel()
        label.text = "Hi, Welcome Back!"
        return label
    }()

    lazy var lblSignIn: UILabel = {
        let label = UILabel()
        label.text = "Sign in to your account."
        label.textAlignment = .left
        return label
    }()

    lazy var btnLoginIn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.snp.makeConstraints {
            $0.height.equalTo(54.0)
        }
        return btn
    }()

    lazy var aivActivityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.isHidden = false
        aiv.hidesWhenStopped = true
        aiv.color = .darkGray
        return aiv
    }()

    // MARK: - Init
    init() {
        super.init(frame: .zero)

        setupViews()
        addSubViews()
        layoutViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: SignInView Extensions -
private extension SignInView {

    // MARK: - Setup
    func setupViews() {
        backgroundColor = UIColor.white
    }

    func addSubViews() {
        addSubviews([lblBack,
                     lblSignIn,
                     btnLoginIn,
                     aivActivityIndicator])
    }

    func layoutViews() {
        aivActivityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200.0)
            $0.height.equalTo(80.0)
        }

        lblBack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(75.0)
            $0.leading.equalToSuperview().offset(32.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.height.equalTo(32.0)
        }

        lblSignIn.snp.makeConstraints {
            $0.top.equalTo(lblBack.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().offset(32.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.height.equalTo(26.0)
        }

        btnLoginIn.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-20.0)
            $0.height.equalTo(54.0)
        }
    }
}
