//
//  GetMediaDataUseCase.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import RxSwift
import Foundation

protocol GetMediaDataUseCase {

    func use(path: String) -> Observable<Data>
}
