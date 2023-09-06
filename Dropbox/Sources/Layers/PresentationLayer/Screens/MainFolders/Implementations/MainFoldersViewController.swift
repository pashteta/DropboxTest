//
//  MainFoldersViewController.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 30.08.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainFoldersViewController: BaseViewController<MainFoldersViewModel> {

    private let screenView = MainFoldersView()

    private var layouted: Bool = false

    // MARK: - Init
    override init(viewModel: MainFoldersViewModel) {
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
        bindIneractions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = "Shared Folders"
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

private extension MainFoldersViewController {

    func bindData() {
        _ = viewModel.getModel()
            .do(onNext: { [weak self] _ in
                self?.screenView.aivActivityIndicator.stopAnimating()
            })
            .map { $0.searchResults }
            .drive(screenView.tvDataSources.rx.items(cellIdentifier: MainFolderCell.identifier(),
                                                     cellType: MainFolderCell.self)) { index, folder, cell in
                cell.setupData(model: folder)
            }.disposed(by: disposeBag)
    }

    func bindIneractions() {
        screenView.btnLogout.rx.tap.subscribe(
            onNext: { [weak self] _ in
                self?.viewModel.moveToAuthFlow()
            }
        ).disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate

extension MainFoldersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onOpenSharedFolderDetails(index: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}
