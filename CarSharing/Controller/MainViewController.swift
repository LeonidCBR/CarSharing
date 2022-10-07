//
//  ViewController.swift
//  CarSharing
//
//  Created by Яна Латышева on 06.10.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }

}

/*

//--------------------------------------

protocol CarsharingProvider {
    static let apiUrl
    cars: [Car]
    color: Double
    parse(from data: Data) // or init???
}

class YandexDriveCarsharing: CarsharingProvider {
    static let apiUrl = "yandex.ru"

    struct Models {
        model_id: String,
        imageUrl: String, // json key "image"
        name: String
    }

    private models: Models // cotainer

    cars: [YandexDriveCar] = []

    init() {}

    parse(from data: Data) {
        cars = JSONDecoder.decode(YandexDriveCarsharing.self, from: data)
    }
}

class CityDriveCarsharing: CarsharingProvider {
    cars: [CityDriveCar] = []
}

//----------------------------------------

class ApiClient {
    urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    downloadData(withUrl url: URL) -> Result<Data, Error>{
        ...
    }
}

class CarsViewModel {
    private(set) let carsharingProviders: [CarsharingProvider]
    //cars: [Car] {
    //    return carsharingProviders.cars.flatMap { $0 } // return all cars
    //}
    private cars: [Car]
    apiClient: ApiClient

    countOfCars: Int {
        return cars.count
    }

    init(carsharingProviders: [CarsharingProvider] = [YandexDriveCarsharing(), CityDriveCarsharing()], apiClient: ApiClient = ApiCLient()) {
        self.carsharingProviders = carsharingProviders
        self.apiClient = apiClient
    }

    func fetchCars() throws {
        carsharingProviders.forEach { carsharingProvider in // forEach
            let result = apiClient.downloadData(withUrl: carsharingProvider.url)
            if case .success(let data) {
                carsharingProvider.parse(from: data)
                //return carsharingProvider
            } else {
                // throw error
                fatalError("!!!")
            }

        }
    }
}


class ViewController {
    //carsharingProviders: [CarsharingProvider] = []
    carsViewModel: CarViewModel

    viewDidLoad() {
        fetchData()
        updateUI()
    }

    init(withCarsViewModel: carsViewModel) {
        self.carsViewModel = carsViewModel
    }

    fetchData() {
        carsViewModel = carsViewModel()
        // viewDidAppear ???
        carsViewModel.fetchCars()
    }

    updateUI() {
        // todo: for each provider -> show cars on the map
    }
}
*/
