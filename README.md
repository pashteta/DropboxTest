# DropboxTest

For run Applications please just clone it there is no any additional specifications 

Architecture  

In this app user Architecture approach MVVM+Coordinator with RxSwift, for cache images we use SDWebImage, for caching Video i’ve create my own logic that stores in Utils -> Storage -> CacheManager. 
For app Security i’ve used KeychainAccesss storage so here i save my tokens, renew token and timestamp before next token updating.
For UI approach used SnapKit logic.
Network Layers works with SwiftDropbox api or Alamofire implementations.

![ezgif-1-6f4e042093](https://github.com/pashteta/DropboxTest/assets/47012765/b3773789-3c22-491e-8476-293f0fb74fe4)
