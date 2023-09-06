//
//  ImagePickerView.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import SnapKit
import SwiftyDropbox
import SDWebImage
import UIKit

final class ImagePickerView: UIView {

    // MARK: - Views

    lazy var scrollView: UIScrollView = {
        let scrl = UIScrollView()
        scrl.delegate = self
        scrl.minimumZoomScale = 1.0
        scrl.maximumZoomScale = 4.0
        scrl.zoomScale = 1.0
        return scrl
    }()

    lazy var lblName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16.0)
        lbl.textAlignment = .center
        return lbl
    }()

    lazy var lblPath: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16.0)
        lbl.textAlignment = .center
        return lbl
    }()

    lazy var userImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()

    // MARK: - Init
    init() {
        super.init(frame: .zero)

        setupViews()
        addSubViews()
        layoutViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ImagePickerView Extensions -

private extension ImagePickerView {

    // MARK: - Setup
    func setupViews() {
        backgroundColor = UIColor.white
    }

    func addSubViews() {
        scrollView.addSubview(userImageView)

        addSubviews([lblName,
                     scrollView,
                     lblPath])
    }

    func layoutViews() {
        lblName.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(0.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.height.equalTo(44.0)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(lblName.snp.bottom).offset(20.0)
            $0.leading.trailing.equalToSuperview().offset(0.0)
        }

        userImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.height.equalToSuperview()
        }

        lblPath.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom).offset(0.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.bottom.equalToSuperview().offset(-20.0)
            $0.height.equalTo(44.0)
        }
    }
}

// MARK: - UIScrollViewDelegate -
extension ImagePickerView: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return userImageView
    }
}

extension ImagePickerView {

    func setupImage(with data: Data?, path: String) {
        guard let data = data else { return }
        
        let fullSizeImage = UIImage(data: data)
        userImageView.image = fullSizeImage

        if SDImageCache.shared.imageFromCache(forKey: path) == nil {
            SDImageCache.shared.store(fullSizeImage, forKey: path)
        }
    }

    func setupImage(with cache: UIImage) {
        userImageView.image = cache
    }
}
