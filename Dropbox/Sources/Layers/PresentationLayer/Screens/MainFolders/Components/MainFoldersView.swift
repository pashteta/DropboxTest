//
//  MainFoldersView.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 30.08.2023.
//

import SnapKit
import UIKit

final class MainFoldersView: UIView {

    // MARK: - Views

    lazy var tvDataSources: UITableView = {
        let tableView = UITableView()
        tableView.register(MainFolderCell.self, forCellReuseIdentifier: MainFolderCell.identifier())
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0)
        return tableView
    }()

    lazy var aivActivityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.isHidden = false
        aiv.hidesWhenStopped = true
        aiv.color = .darkGray
        return aiv
    }()

    lazy var btnLogout: UIButton = {
        let btn = UIButton()
        btn.setTitle("Logout", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.blue
        btn.snp.makeConstraints {
            $0.height.equalTo(54.0)
        }
        return btn
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

private extension MainFoldersView {

    // MARK: - Setup
    func setupViews() {
        backgroundColor = UIColor.white
    }

    func addSubViews() {
        addSubviews([tvDataSources,
                     aivActivityIndicator,
                     btnLogout])
    }

    func layoutViews() {
        aivActivityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200.0)
            $0.height.equalTo(80.0)
        }

        tvDataSources.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100.0)
            $0.leading.trailing.equalToSuperview().offset(0.0)
        }

        btnLogout.snp.makeConstraints {
            $0.top.equalTo(tvDataSources.snp.bottom).offset(20.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-20.0)
            $0.height.equalTo(54.0)
        }
    }
}
