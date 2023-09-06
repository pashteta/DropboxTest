//
//  MainFoldersViewModelTest.swift
//  DropboxTests
//
//  Created by Pavel Okhrimenko on 06.09.2023.
//

import XCTest
import RxSwift

@testable import Dropbox
final class MainFoldersViewModelTests: XCTestCase {
    
    var viewModel: MainFoldersViewModelImpl!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        viewModel = MainFoldersViewModelImpl()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        viewModel = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testViewModelInitialization() {
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.model.searchResults.count, 0)
        XCTAssertFalse(viewModel.openDetailFolder.hasObservers)
        XCTAssertFalse(viewModel.openAuthPublishSubject.hasObservers)
    }
    
    func testFetchingListOfSharedFolders() {
        // Create a mock GetListOfSharedFoldersUseCase implementation for testing
        let mockUseCase = MockGetListOfSharedFoldersUseCase()
        viewModel.getListOfSharedFoldersUseCase = mockUseCase
        
        // Simulate the use case returning data
        let testData = [SharedFolders(folderName: "Folder1"),
                        SharedFolders(folderName: "Folder2")]
        
        mockUseCase.mockResult = .just(testData)
        
        // Create an expectation
        let expectation = XCTestExpectation(description: "Fetch shared folders")
        
        // Trigger the setup method to fetch data
        viewModel.setup()
        
        viewModel.getModel()
            .drive(onNext: { model in
                XCTAssertEqual(model.searchResults, testData)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        // Wait for the expectation
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testMoveToAuthFlow() {
        var authFlowTriggered = false
        
        // Subscribe to the openAuthPublishSubject
        viewModel.openAuthPublishSubject.subscribe(onNext: {
            authFlowTriggered = true
        }).disposed(by: disposeBag)
        
        // Trigger the moveToAuthFlow method
        viewModel.moveToAuthFlow()
        
        XCTAssertTrue(authFlowTriggered)
    }
    
    class MockGetListOfSharedFoldersUseCase: GetListOfSharedFoldersUseCase {
        var mockResult: Observable<[SharedFolders]> = .just([])
        
        func use() -> Observable<[SharedFolders]> {
            return mockResult
        }
    }
}

