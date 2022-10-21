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
    }

    private func showCars(_ cars: [Car]) {
        let annotations = cars.map { CarAnnotation(with: $0) }
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
        guard let annotation = annotation as? CarAnnotation else { return nil }
        let annotationId = "AnnotationIdentifier"
        let annotationView: MKAnnotationView
        if let annotationV = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) {
            annotationV.annotation = annotation
            annotationView = annotationV
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
            annotationView.canShowCallout = true
        }
        switch annotation.provider {
        case .yandexDrive:
            annotationView.image = UIImage(named: "steering-wheel-blue")
        case .cityDrive:
            annotationView.image = UIImage(named: "steering-wheel-green")
        }
        annotationView.frame.size = CGSize(width: 20, height: 20)
        return annotationView
    }

}
