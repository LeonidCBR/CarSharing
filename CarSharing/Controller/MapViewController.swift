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
    private var carAnnotations: [CarAnnotation] = []
    private let threshold: CLLocationDegrees = 0.03 // 0.02

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

        // TODO: - Show user's location

        let centerCoordinate = CLLocationCoordinate2D(latitude: 55.918953,
                                                          longitude: 37.815211)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: false)
    }

    private func showAppropriateCars() {
        let latitudeDelta = mapView.region.span.latitudeDelta
        let longitudeDelta = mapView.region.span.longitudeDelta
        let center = mapView.region.center

        let appropriateCarAnnotations = carAnnotations.filter { carAnnotation in
            return (carAnnotation.coordinate.latitude < center.latitude + latitudeDelta)
            && (carAnnotation.coordinate.latitude > center.latitude - latitudeDelta)
            && (carAnnotation.coordinate.longitude < center.longitude + longitudeDelta)
            && (carAnnotation.coordinate.longitude > center.longitude - longitudeDelta)
        }

        // TODO: Consider to remove other cars
        // ...

        // This affects to blink car views
//        removeAllCarsFromMap()

        mapView.addAnnotations(appropriateCarAnnotations)
    }

    private func fetchCars() {
        carsViewModel.fetchCars()
    }

    private func updateCarAnnotations(for cars: [Car], with provider: Provider) {
        carAnnotations.removeAll { return $0.provider == provider }
        let newCarAnnotations = cars.map { CarAnnotation(with: $0) }
        carAnnotations.append(contentsOf: newCarAnnotations)
        showAppropriateCars()
    }

    private func removeAllCarsFromMap() {
        mapView.removeAnnotations(mapView.annotations)
        /*
         https://stackoverflow.com/questions/3027392/how-to-delete-all-annotations-on-a-mkmapview

         However the previous line of code will remove all map annotations "PINS" from the map,
         including the user location pin "Blue Pin".
         */
    }

}


// MARK: - CarsViewModelDelegate

extension MapViewController: CarsViewModelDelegate {
    func didGetCars(_ carsharingProvider: CarsharingProvider) {
        let carsCount = carsViewModel.numberOfCars(for: carsharingProvider)
        print("DEBUG: Get new cars (\(carsCount)) by provider \(carsharingProvider.provider)")
        let cars = carsViewModel.getAllCarsFor(carsharingProvider: carsharingProvider)
        updateCarAnnotations(for: cars, with: carsharingProvider.provider)
    }

    func didGetError(_ carsharingProvider: CarsharingProvider, error: Error) {
        print("DEBUG: Error! \(error)")
    }
}


// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        print("DEBUG: \(#function)")
        guard mapView.region.span.longitudeDelta < threshold else { return nil }

        guard let carAnnotation = annotation as? CarAnnotation else { return nil }
        let annotationId = "AnnotationIdentifier"
        let annotationView: CarAnnotationView
        if let annotationV = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) as? CarAnnotationView {
//            print("DEBUG: Reuse annotation view")
            annotationV.annotation = carAnnotation
            annotationView = annotationV
        } else {
//            print("DEBUG: New annotation view")
            annotationView = CarAnnotationView(annotation: carAnnotation, reuseIdentifier: annotationId)
            annotationView.canShowCallout = true
        }
        return annotationView
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        /* https://medium.com/@dmytrobabych/getting-actual-rotation-and-zoom-level-for-mapkit-mkmapview-e7f03f430aa9
         */

        // TODO: Add delay, because we want to wait while user is interacting with the map

        print("DEBUG: Region did change. Longitude delta = \(mapView.region.span.longitudeDelta)")

        if mapView.region.span.longitudeDelta < threshold {
            showAppropriateCars()
        } else {
            removeAllCarsFromMap()
        }
    }

}

