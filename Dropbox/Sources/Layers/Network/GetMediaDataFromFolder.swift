//
//  GetMediaDataFromFolder.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 04.09.2023.
//

import Alamofire
import RxCocoa
import RxSwift
import SwiftyDropbox
import Foundation

protocol GetMediaDataFromFolder {

    func getListOfFolders(path: String) -> Observable<Data>
}

class GetMediaDataFromFolderNetworkServiceImpl: GetMediaDataFromFolder {
    
    var client: DropboxClient = DropboxClient(accessToken: "")
    
    init() {
        let secureStorage = SecureStorage()
        guard let token = secureStorage.getDataFromKeychain()?.accessToken else { return }
        
        client = DropboxClient(accessToken: token)
    }
    
    func getListOfFolders(path: String) -> Observable<Data> {
        
        return Observable.create { [weak self] observer  in
            
            self?.client.files.download(path: path).response { [weak self] response, error in
                
                if let (_, data) = response {
                    observer.onNext(data)
                } else {
                    print("erorrs", error)
                }
            }
            
            return Disposables.create()
        }
    }
}

