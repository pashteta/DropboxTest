//
//  GetSharedFolderMedia.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import Alamofire
import RxCocoa
import RxSwift
import SwiftyDropbox

protocol GetSharedFolderMedia {

    func getListOfMedia(for folder: String) -> Observable<Files.ListFolderResult>
}

class GetSharedFolderMediaNetworkServiceImpl: GetSharedFolderMedia {

    var client: DropboxClient = DropboxClient(accessToken: "")

    init() {
        let secureStorage = SecureStorage()
        guard let token = secureStorage.getDataFromKeychain()?.accessToken else { return }

        client = DropboxClient(accessToken: token)
    }
    
    func getListOfMedia(for folder: String) -> Observable<Files.ListFolderResult> {

        return Observable.create { [weak self] observer in

            self?.client.files.listFolder(path: "/" + folder).response { response, error in
                if let result = response {
                    observer.onNext(result)
                } else if let err = error {
                    print("Error: \(err)")
                }
            }

            return Disposables.create()
        }
    }
}

