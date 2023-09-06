# DropboxTest

For run Applications please just clone it there is no any additional specifications 

Architecture  

In this app user Architecture approach MVVM+Coordinator with RxSwift, for cache images we use SDWebImage, for caching Video i’ve create my own logic that stores in Utils -> Storage -> CacheManager. 
For app Security i’ve used KeychainAccesss storage so here i save my tokens, renew token and timestamp before next token updating.
For UI approach used SnapKit logic.
Network Layers works with SwiftDropbox api or Alamofire implementations.

![ezgif-1-6f4e042093](https://github.com/pashteta/DropboxTest/assets/47012765/ed892770-35cd-450f-81c2-74b0a2d6268e)
