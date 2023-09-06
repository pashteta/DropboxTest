//
//  MainFolderDetailView.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import SnapKit
import UIKit

final class MainFolderDetailView: UIView {

    // MARK: - Views

    lazy var tvDataSources: UITableView = {
        let tableView = UITableView()
        tableView.register(MainFolderMediaCell.self, forCellReuseIdentifier: MainFolderMediaCell.identifier())
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

private extension MainFolderDetailView {

    // MARK: - Setup
    func setupViews() {
        backgroundColor = UIColor.white
    }

    func addSubViews() {
        addSubviews([tvDataSources,
                     aivActivityIndicator])
    }

    func layoutViews() {
        aivActivityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200.0)
            $0.height.equalTo(80.0)
        }

        tvDataSources.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.bottom.equalToSuperview().offset(-16.0)
        }
    }
}
