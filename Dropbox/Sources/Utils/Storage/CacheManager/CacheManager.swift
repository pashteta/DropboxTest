//
//  CacheManager.swift
//  Dropbox
//
//  Created by Pavel Okhrimenko on 05.09.2023.
//

import RxCocoa
import RxSwift
import UIKit
import Foundation

enum CacheError: Error {
    case directoryCreationFailed
    case invalidCacheDirectory
}

class CacheManager {

    static let shared = CacheManager()

    private let fileManager = FileManager.default

    private lazy var cacheDirectoryUrl: URL? = {
        let cacheDirectory = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return cacheDirectory.appendingPathComponent("Videos")
    }()

    func getCachedVideoURL(forKey key: String) -> URL? {
        guard let cacheDirectoryURL = cacheDirectoryUrl else {
            return nil
        }

        let fileURL = cacheDirectoryURL.appendingPathComponent(key)
        return fileManager.fileExists(atPath: fileURL.path) ? fileURL : nil
    }

    func saveVideoData(_ data: Data, forKey key: String, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let cacheDirectoryURL = cacheDirectoryUrl else {
            completion(.failure(CacheError.invalidCacheDirectory))
            return
        }

        let fileURL = cacheDirectoryURL.appendingPathComponent(key)

        do {
            /// Create intermediate directories if they don't exist
            let intermediateDirectory = fileURL.deletingLastPathComponent()
            try fileManager.createDirectory(at: intermediateDirectory, withIntermediateDirectories: true, attributes: nil)

            try data.write(to: fileURL, options: .atomic)
            completion(.success(fileURL))
        } catch {
            completion(.failure(error))
        }
    }

    private func createCacheDirectoriesIfNeeded() throws {
        guard let cacheDirectoryURL = cacheDirectoryUrl else {
            throw CacheError.invalidCacheDirectory
        }

        if !fileManager.fileExists(atPath: cacheDirectoryURL.path) {
            do {
                try fileManager.createDirectory(at: cacheDirectoryURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                throw CacheError.directoryCreationFailed
            }
        }
    }

    func clear() {
        do {
            try CacheManager.shared.clearCache()
            print("Cache cleared successfully.")
        } catch {
            print("Failed to clear cache: \(error)")
        }
    }

    private func clearCache() throws {
        guard let cacheDirectoryURL = cacheDirectoryUrl else {
            throw CacheError.invalidCacheDirectory
        }

        /// Check if the cache directory exists
        guard fileManager.fileExists(atPath: cacheDirectoryURL.path) else {
            return /// Cache directory is already empty or doesn't exist
        }

        do {
            /// Remove the cache directory and its contents
            try fileManager.removeItem(at: cacheDirectoryURL)
        } catch {
            throw error
        }
    }
}
