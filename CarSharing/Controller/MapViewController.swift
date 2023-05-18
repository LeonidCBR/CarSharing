//
//  ViewController.swift
//  CarSharing
//
//  Created by Яна Латышева on 06.10.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    private var mapView: MKMapView!
    private var searchController: UISearchController!
    private let carsViewModel: CarsViewModel
    private var carAnnotations: [CarAnnotation] = []
    /// The threshold of longitude delta is used to consider
    /// whether cars are shown on the map or not
    private let threshold: CLLocationDegrees = 0.03

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
        carsViewModel.delegate = self
        configureMap()
        configureSearchController()
    }

    private func configureMap() {
        mapView = MKMapView()
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        // TODO: - Show user's location

        let centerCoordinate = CLLocationCoordinate2D(latitude: 55.918953,
                                                          longitude: 37.815211)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: false)
    }

    private func configureSearchController() {
        searchController = UISearchController()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func fetchCars() {
        carsViewModel.fetchCars()
    }

    private func updateCarAnnotations(for cars: [Car], with providerType: ProviderType) {
        carAnnotations.removeAll { return $0.providerType == providerType }
        let newCarAnnotations = cars.map { CarAnnotation(with: $0) }
        carAnnotations.append(contentsOf: newCarAnnotations)
        showAppropriateCars()
    }

    private func showAppropriateCars() {
        guard mapView.region.span.longitudeDelta < threshold else {
            removeAllCarsFromMap()
            return
        }

        let latitudeDelta = mapView.region.span.latitudeDelta
        let longitudeDelta = mapView.region.span.longitudeDelta
        let center = mapView.region.center

        let appropriateCarAnnotations = carAnnotations.filter { carAnnotation in
            return (carAnnotation.coordinate.latitude < center.latitude + latitudeDelta)
            && (carAnnotation.coordinate.latitude > center.latitude - latitudeDelta)
            && (carAnnotation.coordinate.longitude < center.longitude + longitudeDelta)
            && (carAnnotation.coordinate.longitude > center.longitude - longitudeDelta)
        }

        // TODO: Consider to remove other cars outside the map
        // ...

        // This affects to blink car views
//        removeAllCarsFromMap()

        mapView.addAnnotations(appropriateCarAnnotations)
    }

    private func removeAllCarsFromMap() {
        mapView.removeAnnotations(mapView.annotations)
        /*
         https://stackoverflow.com/questions/3027392/how-to-delete-all-annotations-on-a-mkmapview

         However the previous line of code will remove all map annotations "PINS" from the map,
         including the user location pin "Blue Pin".
         */
    }

    private func search(for queryString: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = queryString

        // TODO: - Search only in the RUSSIA

//        searchRequest.region = MKCoordinateRegion( RUSSIA )
//        searchRequest.resultTypes = .address

        let search = MKLocalSearch(request: searchRequest)
        search.start { [unowned self] response, error in
            if let error = error {

                // TODO: Show the error

                print("DEBUG: ERROR \(error.localizedDescription)")
                return
            }

            guard let response = response else { return }
//            let mapItems = response.mapItems
//            for item in mapItems {
//                print("DEBUG: Item \(item.name ?? "") \(item.phoneNumber ?? "")")
//            }
            self.mapView.setRegion(response.boundingRegion, animated: true)
        }
    }
}


// MARK: - CarsViewModelDelegate

extension MapViewController: CarsViewModelDelegate {
    func didGetCars(_ cars: [Car]) {
        // TODO: Implement the method
    }

    func didGetError(_ error: Error) {
        // TODO: Implement the method
    }

//    func didGetCars(_ carsharingProvider: CarsharingProvider) {
//        let carsCount = carsViewModel.numberOfCars(for: carsharingProvider)
//        print("DEBUG: Get new cars (\(carsCount)) by provider \(carsharingProvider.provider)")
//        let cars = carsViewModel.getAllCarsFor(carsharingProvider: carsharingProvider)
//        updateCarAnnotations(for: cars, with: carsharingProvider.provider)
//    }
/*
    func didGetError(_ carsharingProvider: CarsharingProvider, error: Error) {
        print("DEBUG: ERROR! \(error)")
        let alertController = UIAlertController(title: "ERROR (\(carsharingProvider.provider))",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)

        /*
         if it's already presented
         2022-10-26 10:14:18.076552+1000 CarSharing[2782:1062478] [Presentation]
         Attempt to present <UIAlertController: 0x101a35a00>
         on <CarSharing.MapViewController: 0x100f0acc0>
         (from <CarSharing.MapViewController: 0x100f0acc0>)
         which is already presenting <UIAlertController: 0x101a06600>.
         */
        present(alertController, animated: true)
    }
*/
}


// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let carAnnotation = annotation as? CarAnnotation else { return nil }
        let annotationId = "AnnotationIdentifier"
        let annotationView: CarAnnotationView
        if let annotationV = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId) as? CarAnnotationView {
            annotationV.annotation = carAnnotation
            annotationView = annotationV
        } else {
            annotationView = CarAnnotationView(annotation: carAnnotation, reuseIdentifier: annotationId)
            annotationView.canShowCallout = true
        }
        return annotationView
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        /* https://medium.com/@dmytrobabych/getting-actual-rotation-and-zoom-level-for-mapkit-mkmapview-e7f03f430aa9
         */

        // TODO: Add delay, because we want to wait while user is interacting with the map

        showAppropriateCars()
    }

}


// MARK: - UISearchBarDelegate

extension MapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        if let queryText = searchBar.text, !queryText.isEmpty {
            search(for: queryText)
        }
    }
}
