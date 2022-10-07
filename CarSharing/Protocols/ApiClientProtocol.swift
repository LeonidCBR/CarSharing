//
//  ApiClientProtocol.swift
//  CarSharing
//
//  Created by Яна Латышева on 07.10.2022.
//

import Foundation

protocol ApiClientProtocol {
    func downloadData(withUrl url: URL,
                      completionHandler: @escaping (Result<Data, NetworkError>) -> Void)
}
