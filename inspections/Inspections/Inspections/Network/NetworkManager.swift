//
//  NetworkManager.swift
//  Inspections
//
//  Created by ERP on 29/07/2024.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private let session: URLSession

    private init() {
        session = URLSession(configuration:
                .default)
    }

    func fetchInspectionData(url: String, completion: @escaping (Result<InspectionData, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let inspectionData = try JSONDecoder().decode(InspectionData.self, from: data)
                completion(.success(inspectionData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func sendPostRequest(urlString: String, dictionary: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            request.httpBody = jsonData
        } catch {
            // Handle the error
            print("Error fetching data: \(error)")
        }
        
        
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain:
                                                "No data received", code: -1, userInfo: nil)))
            }
        }
        task.resume()
    }
    
    func sendPostRequest(urlString: String, data: Data, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain:
                                                "No data received", code: -1, userInfo: nil)))
            }
        }
        task.resume()
    }
}
