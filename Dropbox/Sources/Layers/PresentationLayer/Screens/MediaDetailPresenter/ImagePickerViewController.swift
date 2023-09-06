//
//  ImagePickerViewController.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import UIKit
import SnapKit
import SwiftyDropbox
import SDWebImage

final class ImagePickerViewController: BaseViewController<ImagePickerViewModel> {

    private let screenView = ImagePickerView()

    // MARK: - Init
    override init(viewModel: ImagePickerViewModel) {
        super.init(viewModel: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false 
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - Setup
    private func setupViews() {
        view = screenView
    }
}

// MARK: - Data binding
private extension ImagePickerViewController {

    func bindData() {
        if let cachedImage = SDImageCache.shared.imageFromCache(forKey: viewModel.mediaPath) {
            screenView.setupImage(with: cachedImage)
            screenView.lblName.text = viewModel.name
            screenView.lblPath.text = viewModel.description
            return
        } else if let cachedImage = SDImageCache.shared.imageFromCache(forKey: viewModel.mediaPath + AppConstants.thumnbailsCachePath) {
            screenView.setupImage(with: cachedImage)
        }

        viewModel.getModel()
            .drive(onNext: { [weak self] model in
                self?.setupData(with: model)
            })
            .disposed(by: disposeBag)
    }

    func setupData(with model: ImagePickerModel) {
        screenView.setupImage(with: model.imageData, path: viewModel.description)
        screenView.lblName.text = viewModel.name
        screenView.lblPath.text = viewModel.description
    }
}
