//
//  ViewController.swift
//  CarSharing
//
//  Created by Яна Латышева on 06.10.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    private let mapView = MKMapView()
    private let carsViewModel: CarsViewModel
    private var cars: [Car] = [] {
        didSet {
            updateUI()
        }
    }

    init(with carsViewModel: CarsViewModel) {
        self.carsViewModel = carsViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchCars()
    }

    private func configureUI() {
        view.backgroundColor = .white
        configureMap()
        carsViewModel.delegate = self
    }

    private func configureMap() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        let centerCoordinate = CLLocationCoordinate2D(latitude: 55.7558,
                                                          longitude: 37.6173)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: false)
    }

    private func fetchCars() {
        carsViewModel.fetchCars()
//        carsViewModel.fetchCars { [weak self] result in
//            guard let self = self else {
//                return
//            }
//
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let fetchedCars):
//                    self.cars = fetchedCars
//                case .failure(let error):
//                    // TODO: Show the error
//                    print("DEBUG: Show error \(error)")
//                }
//            }
//        }
    }

    private func updateUI() {
        // TODO: Show the cars on the map
        print("DEBUG: Got cars...")
    }

}

extension MapViewController: CarsViewModelDelegate {
    func didGetCars(_ carsharingProvider: CarsharingProvider) {
        let carsCount = carsViewModel.numberOfCars(for: carsharingProvider)
        print("DEBUG: Get new cars (\(carsCount))")
    }

    func didGetError(_ carsharingProvider: CarsharingProvider, error: Error) {
        print("DEBUG: Error! \(error)")
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
