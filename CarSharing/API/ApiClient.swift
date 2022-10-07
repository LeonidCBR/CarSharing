//
//  ApiClient.swift
//  CarSharing
//
//  Created by Яна Латышева on 06.10.2022.
//

import Foundation

class ApiClient: ApiClientProtocol {
    private let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func downloadData(withUrl url: URL,
                      completionHandler: @escaping (Result<Data, NetworkError>) -> Void) {
        let request = URLRequest(url: url)


        // TODO: set up headers and auth
        // ...

        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(.urlSessionError(error)))
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noResponse))
                }
                return
            }

            if !(200...299).contains(httpResponse.statusCode) {
                let code = httpResponse.statusCode
                DispatchQueue.main.async {
                    if code == 401 {
                        completionHandler(.failure(.unauthorized))
                    } else {
                        completionHandler(.failure(.unhandledError(code)))
                    }
                }
                return
            }

            guard let mimeType = httpResponse.mimeType,
                  (mimeType == "application/json") || ( mimeType.hasPrefix("image") ),
                  let data = data else {
                      DispatchQueue.main.async {
                          completionHandler(.failure(.unexpectedData))
                      }
                      return
                  }

            DispatchQueue.main.async {
                completionHandler(.success(data))
            }
        }
        dataTask.resume()
    }
}
