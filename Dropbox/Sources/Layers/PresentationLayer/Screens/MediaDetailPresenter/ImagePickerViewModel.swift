//
//  ImagePickerViewModel.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import RxCocoa
import RxSwift

protocol ImagePickerViewModel {

    var mediaPath: String { get }
    var name: String { get }
    var description: String { get }

    func getModel() -> Driver<ImagePickerModel>
}

