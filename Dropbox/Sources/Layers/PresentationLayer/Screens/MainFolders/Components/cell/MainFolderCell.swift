//
//  MainFolderCell.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 02.09.2023.
//

import SnapKit
import UIKit

class MainFolderCell: UITableViewCell {

    // MARK: - Views
    private lazy var imgFolder: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "img_folder_icon")
        img.snp.makeConstraints {
            $0.size.equalTo(44.0)
        }
        return img
    }()

    private lazy var lblFolderName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16.0)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.minimumScaleFactor = 0.8
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        layoutViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
    }

    private func layoutViews() {
        addSubviews([imgFolder,
                     lblFolderName])

        imgFolder.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.0)
            $0.centerY.equalToSuperview()
        }

        lblFolderName.snp.makeConstraints {
            $0.leading.equalTo(imgFolder.snp.trailing).offset(10.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.centerY.equalTo(imgFolder.snp.centerY)
        }
    }
}

// MARK: - Data binding
extension MainFolderCell {

    func setupData(model: SharedFolders) {
        lblFolderName.text = model.folderName
    }
}
