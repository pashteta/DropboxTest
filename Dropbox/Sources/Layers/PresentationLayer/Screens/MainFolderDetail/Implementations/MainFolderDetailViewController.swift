//
//  MainFolderDetailViewController.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainFolderDetailViewController: BaseViewController<MainFolderDetailViewModelImpl> {

    private let screenView = MainFolderDetailView()

    private var layouted: Bool = false

    // MARK: - Init
    override init(viewModel: MainFolderDetailViewModelImpl) {
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
        bindInteractions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = "Shared Media"
        navigationController?.navigationBar.prefersLargeTitles = true

        if !layouted {
            screenView.aivActivityIndicator.startAnimating()
            layouted = true
        }
    }
    
    // MARK: - Setup
    private func setupViews() {
        view = screenView
        screenView.tvDataSources.delegate = self
    }
}

// MARK: - Data binding

private extension MainFolderDetailViewController {

    func bindData() {
        viewModel.isLoading
            .bind(to: screenView.aivActivityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        _ = viewModel.getModel()
            .do(onNext: { [weak self] _ in
                self?.screenView.aivActivityIndicator.stopAnimating()
            })
            .map { $0.searchResults }
            .drive(screenView.tvDataSources.rx.items(cellIdentifier: MainFolderMediaCell.identifier(),
                                                          cellType: MainFolderMediaCell.self)) { index, media, cell in
                cell.setupData(model: media)
            }.disposed(by: disposeBag)
    }

    func bindInteractions() { }
}

// MARK: - UITableViewDelegate

extension MainFolderDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onOpenMediaDetailScreen(index: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
