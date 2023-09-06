//
//  BaseViewModel.swift
//  Dropbox
//
//
//  Base ViewModel to lower boiler plate and unite model handling
//
//  Provides disposeBag and associated model
//  Associated model needs to conform BaseEmptyModel
//  and has to be struct otherwise changes on model wont go through chain.
//  To save new value to model simple change any propery and change
//  will be distribed via rx chain to getModel
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

import Foundation
import RxCocoa
import RxSwift

open class BaseViewModel<T: BaseEmptyModel> {
    // MARK: - Aliases
   public typealias Model = T

    // MARK: - Properties
    public let disposeBag = DisposeBag()

    private let modelRelay = BehaviorRelay<Model>(value: Model.createEmpty())

    ///Holds current model, any changes to it will be propagated to modelRelay
    public var model: Model {
        didSet {
            modelRelay.accept(model)
        }
    }

    // MARK: - Init
    public init() {
        model = Model.createEmpty()
    }

    /// Subscribe to recieve changes on model
    public func getModel() -> Driver<Model> {
        modelRelay.asObservable().asDriver(onErrorJustReturn: Model.createEmpty())
    }
}

