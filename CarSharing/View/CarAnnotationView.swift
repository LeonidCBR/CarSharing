//
//  CarAnnotationView.swift
//  CarSharing
//
//  Created by Яна Латышева on 21.10.2022.
//

import Foundation
import MapKit

class CarAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        didSet {
            updateUI()
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8)
        return label
    }()

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: bottomAnchor).isActive = true

        updateUI()
    }

    private func updateUI() {
        titleLabel.text = annotation?.title ?? ""

        guard let provider = (annotation as? CarAnnotation)?.provider else { return }
        switch provider {
        case .yandexDrive:
            image = UIImage(named: "steering-wheel-blue")
        case .cityDrive:
            image = UIImage(named: "steering-wheel-green")
        }
        frame.size = CGSize(width: 20, height: 20)
    }
}
