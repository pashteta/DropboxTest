//
//  GetListOfFoldersdNetworkServiceImpl.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 28.08.2023.
//

import Alamofire
import RxCocoa
import RxSwift
import SwiftyDropbox

protocol GetListOfSharedFolders {

    func getListOfFolders() -> Observable<Sharing.ListFoldersResult>
}

class GetListOfSharedFoldersNetworkServiceImpl: GetListOfSharedFolders {

    var client: DropboxClient = DropboxClient(accessToken: "")

    init() {
        let secureStorage = SecureStorage()
        guard let token = secureStorage.getDataFromKeychain()?.accessToken else { return }

        client = DropboxClient(accessToken: token)
    }
    
    func getListOfFolders() -> Observable<Sharing.ListFoldersResult> {
        
        return Observable.create { [weak self] observer  in

            self?.client.sharing.listFolders().response { response, error in
                if let result = response {
                    observer.onNext(result)
                }  else if let error = error {
                    print("Error: \(error)")
                }
            }
            
            return Disposables.create()
        }
    }
}

