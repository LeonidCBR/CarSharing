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
//    private var cars: [Car] = [] {
//        didSet {
//            updateUI()
//        }
//    }

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

        mapView.delegate = self

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

//    private func updateUI() {
        // TODO: Show the cars on the map
//        print("DEBUG: Got cars...")
//    }
    private func showCars(_ cars: [Car]) {
        print("DEBUG: Show \(cars.count) cars.")
        let annotations = cars.map { car -> MKPointAnnotation in
            let carLocation = CLLocationCoordinate2D(latitude: car.lat, longitude: car.lon)
            let carAnnotation = MKPointAnnotation()
            carAnnotation.title = car.model
            carAnnotation.subtitle = car.number
            carAnnotation.coordinate = carLocation

            // TODO: Consider to subclass MKPointAnnotation
            // and to add a field .provider

            return carAnnotation
        }
        mapView.showAnnotations(annotations, animated: false)
    }

}


// MARK: - CarsViewModelDelegate

extension MapViewController: CarsViewModelDelegate {
    func didGetCars(_ carsharingProvider: CarsharingProvider) {
        let carsCount = carsViewModel.numberOfCars(for: carsharingProvider)
        print("DEBUG: Get new cars (\(carsCount))")
//        let cars = carsViewModel.getCarsFor(carsharingProvider: carsharingProvider)
        let cars = carsViewModel.getCarsForRegion(lat: 55.920682, lon: 37.814619, delta: 0.01, carsharingProvider: carsharingProvider)
        showCars(cars)
    }

    func didGetError(_ carsharingProvider: CarsharingProvider, error: Error) {
        print("DEBUG: Error! \(error)")
    }
}


// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let annotationId = "AnnotationIdentifier"
        let annotationView: MKAnnotationView
        if let annotationV = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) {
            annotationV.annotation = annotation
            annotationView = annotationV
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
            annotationView.canShowCallout = true
        }
//        let pinImage = UIImage(systemName: "circle")?.withTintColor(.red, renderingMode: .alwaysTemplate)
//        annotationView.image = pinImage
//        annotationView.tintColor = .red
//        annotationView.backgroundColor = .red
        annotationView.image = UIImage(systemName: "circle")
        annotationView.layer.borderColor = UIColor.blue.cgColor
        annotationView.layer.borderWidth = 3.0
        annotationView.layer.cornerRadius = annotationView.frame.width / 2
        return annotationView
    }

}
