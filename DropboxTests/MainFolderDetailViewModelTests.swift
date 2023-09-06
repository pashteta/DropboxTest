//
//  MainFolderDetailViewModelTests.swift
//  DropboxTests
//
//  Created by Pavel Okhrimenko on 06.09.2023.
//

import XCTest
import RxSwift

@testable import Dropbox
final class MainFolderDetailViewModelTests: XCTestCase {

    var viewModel: MainFolderDetailViewModelImpl!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        viewModel = MainFolderDetailViewModelImpl(sharedFolderName: "TestFolder")
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        viewModel = nil
        disposeBag = nil
        super.tearDown()
    }

    func testViewModelInitialization() {
        XCTAssertTrue(viewModel.isLoading.value)
        XCTAssertEqual(viewModel.model.searchResults.count, 0)
    }

    func testFetchingListOfSharedFolders() {
        // Create a mock GetListOfFoldersMediaUseCase implementation for testing
        let mockUseCase = MockGetListOfFoldersMediaUseCase()
        viewModel.getListOfSharedFoldersMediaUseCase = mockUseCase

        // Simulate the use case returning data
        let testData = [MainFolderMediaContentModel(name: "TestName", path: "TestPath")]
        mockUseCase.mockResult = .just(testData)

        // Create an expectation
        let expectation = XCTestExpectation(description: "Fetch shared folders")
        viewModel.setup(folderName: "TestFolder")

        // Observe the isLoading property to check for changes
        viewModel.isLoading.subscribe(onNext: { isLoading in
            if !isLoading {
                XCTAssertEqual(self.viewModel.model.searchResults, testData)
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }

    class MockGetListOfFoldersMediaUseCase: GetListOfFoldersMediaUseCase {
        var mockResult: Observable<[MainFolderMediaContentModel]> = .just([])

        func use(folder: String) -> Observable<[MainFolderMediaContentModel]> {
            return mockResult
        }
    }
}

