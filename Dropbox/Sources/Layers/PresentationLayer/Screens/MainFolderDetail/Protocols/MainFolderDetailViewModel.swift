//
//  MainFolderDetailViewModel.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import RxCocoa
import RxSwift
import Foundation

protocol MainFolderDetailViewModel {

    var isLoading: BehaviorRelay<Bool> { get set }

    var openVideoPlaySubject: PublishSubject<(URL)> { get set }
    var openMediaImageSubject: PublishSubject<(MainFolderMediaContentModel)> { get set }

    func getModel() -> Driver<MainFolderMediaModel>

    func onOpenMediaDetailScreen(index: Int)
}

