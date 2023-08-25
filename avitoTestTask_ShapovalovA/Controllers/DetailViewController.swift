//
//  DetailViewController.swift
//  avitoTestTask_ShapovalovA
//
//  Created by Aleksandr Shapovalov on 25/08/23.
//

import UIKit

class DetailViewController: UIViewController {

    var coordinator: MainCoordinator?
    var product: Product?

    var state: ViewControllerState = .loading {
        didSet {
            updateUI(for: state)
        }
    }

    var loadingIndicator: UIActivityIndicatorView!
    var errorMessageLabel: UILabel!
    var detailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // UI setup
        setupUI()

        // Fetch data
        fetchData()
    }

    private func setupUI() {
        // Initialize loading indicator
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false

        // Initialize error message label
        errorMessageLabel = UILabel()
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .red

        // Initialize detail label
        detailLabel = UILabel()
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.textAlignment = .left
        detailLabel.numberOfLines = 0 // allow multiple lines

        // Add subviews and setup constraints
        self.view.addSubview(loadingIndicator)
        self.view.addSubview(errorMessageLabel)
        self.view.addSubview(detailLabel)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

            errorMessageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            errorMessageLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

            detailLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            detailLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            detailLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16)
        ])
    }

    private func fetchData() {
        guard let productId = product?.id else { return }

        state = .loading
        NetworkManager.shared.fetchProductDetail(for: productId) { [weak self] (productDetail, error) in
            if let error = error {
                self?.state = .error(error.localizedDescription)
                return
            }

            if let productDetail = productDetail {
                self?.detailLabel.text = """
                Name: \(productDetail.name)
                Price: \(productDetail.price)
                Description: \(productDetail.description)
                """
                self?.state = .content
            }
        }
    }

    func updateUI(for state: ViewControllerState) {
        switch state {
        case .loading:
            loadingIndicator.startAnimating()
            errorMessageLabel.isHidden = true
            detailLabel.isHidden = true
        case .error(let message):
            loadingIndicator.stopAnimating()
            errorMessageLabel.text = message
            errorMessageLabel.isHidden = false
            detailLabel.isHidden = true
        case .content:
            loadingIndicator.stopAnimating()
            errorMessageLabel.isHidden = true
            detailLabel.isHidden = false
        }
    }
}
