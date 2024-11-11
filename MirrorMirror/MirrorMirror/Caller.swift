//
//  Caller.swift
//  MirrorMirror
//
//  Created by Jake Barberine on 11/10/24.
//

import Foundation
import UIKit

class APIService {
    private let apiKey: String
    private let endpoint: String

    init(apiKey: String, endpoint: String) {
        self.apiKey = apiKey
        self.endpoint = endpoint
    }
    
    func removeBackground(from imagePath: String, with imageData: Data, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let apiUrl = URL(string:  "\(endpoint)/computervision/imageanalysis:segment?api-version=2023-02-01-preview&mode=backgroundRemoval") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
//        guard let imageData = try? Data(contentsOf: URL(fileURLWithPath: imagePath)) else {
//            completion(.failure(NSError(domain: "Failed to read image file", code: -2, userInfo: nil)))
//            return
//        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.httpBody = readFileData(from: imagePath)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                print("Response: \(httpResponse.statusCode)")
                let fileManager = FileManager.default
                let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
                let outputPath = documentsURL.appendingPathComponent("background_removed_image.png")
                
                do {
                    try data.write(to: outputPath)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "Invalid response", code: -3, userInfo: nil)))
            }
        }
        
        task.resume()
    }
    
    func readFileData(from path: String) -> Data? {
        let fileManager = FileManager.default
        let fileURL = URL(fileURLWithPath: path)

        do {
            let fileData = try Data(contentsOf: fileURL)
            return fileData
        } catch {
            print("Error reading file at \(path): \(error.localizedDescription)")
            return nil
        }
    }
}
