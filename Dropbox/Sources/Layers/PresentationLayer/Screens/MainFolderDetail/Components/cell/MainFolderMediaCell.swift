//
//  MainFolderMediaCell.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 02.09.2023.
//

import SnapKit
import UIKit
import SwiftyDropbox
import SDWebImage

class MainFolderMediaCell: UITableViewCell {

    // MARK: - Views
    private lazy var imgFolder: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.snp.makeConstraints {
            $0.size.equalTo(50.0)
        }
        return img
    }()

    private lazy var lblFolderName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()

    private lazy var lblFolderDescriptions: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()

    private lazy var stckView: UIStackView = {
        let stck = UIStackView(arrangedSubviews: [lblFolderName, lblFolderDescriptions])
        stck.alignment = .fill
        stck.axis = .vertical
        stck.spacing = 2.0
        stck.distribution = .fillEqually
        return stck
    }()

    lazy var aiv: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.isHidden = false
        aiv.hidesWhenStopped = true
        aiv.color = .darkGray
        return aiv
    }()

    private var client: DropboxClient = DropboxClient(accessToken: "")

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        layoutViews()

        let secureStorage = SecureStorage()
        guard let token = secureStorage.getDataFromKeychain()?.accessToken else { return }

        client = DropboxClient(accessToken: token)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .white
    }

    private func layoutViews() {
        imgFolder.addSubview(aiv)
        addSubviews([imgFolder,
                     stckView])

        aiv.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        imgFolder.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(0.0)
            $0.centerY.equalToSuperview()
        }

        stckView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5.0)
            $0.leading.equalTo(imgFolder.snp.trailing).offset(10.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.bottom.equalToSuperview().offset(-5.0)
        }
    }
}

// MARK: - Data binding
extension MainFolderMediaCell {

    func setupData(model: MainFolderMediaContentModel) {
        lblFolderName.text = model.name

        if let description = model.path {
            lblFolderDescriptions.text = description
        }

        downloadThumbnailImage(thumbnailPath: model.path)
    }

    func downloadThumbnailImage(thumbnailPath: String?) {
        guard let path = thumbnailPath else { return }

        if let cachedImage = SDImageCache.shared.imageFromCache(forKey: path + AppConstants.thumnbailsCachePath) {
            self.imgFolder.image = cachedImage
            return
        }

        aiv.startAnimating()

        ///  Download the thumbnail image from Dropbox API
        client.files.getThumbnail(
            path: path,
            format: .jpeg,
            size: .w64h64
        ).response { [weak self] response, error in
            guard let self = self else { return }

            self.aiv.stopAnimating()

            if let (metadata, data) = response {
                let thumbnailImage = UIImage(data: data)
                self.imgFolder.image = thumbnailImage

                SDImageCache.shared.store(thumbnailImage, forKey: path + AppConstants.thumnbailsCachePath)
            } else {
                print("Error downloading Dropbox thumbnail: \(path)")
            }
        }
    }
}
