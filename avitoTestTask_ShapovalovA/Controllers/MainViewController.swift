//
//  MainViewController.swift
//  avitoTestTask_ShapovalovA
//
//  Created by Aleksandr Shapovalov on 25/08/23.
//

import UIKit

enum ViewControllerState {
    case loading
    case error(String)
    case content
}

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var coordinator: MainCoordinator?
    var products: [Product] = []
    var collectionView: UICollectionView!
    var loadingIndicator: UIActivityIndicatorView!
    var errorMessageLabel: UILabel!

    var state: ViewControllerState = .loading {
        didSet {
            updateUI(for: state)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // UI setup
        setupUI()

        // Fetch data
        fetchData()
    }

    private func setupUI() {
        // Initialize and set up UICollectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width / 2) - 15, height: self.view.frame.width / 2)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")

        // Initialize loading indicator
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false

        // Initialize error message label
        errorMessageLabel = UILabel()
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .red

        // Add subviews and setup constraints
        self.view.addSubview(collectionView)
        self.view.addSubview(loadingIndicator)
        self.view.addSubview(errorMessageLabel)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

            errorMessageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            errorMessageLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    private func fetchData() {
        state = .loading
        NetworkManager.shared.fetchProducts { [weak self] (fetchedProducts, error) in
            if let error = error {
                self?.state = .error(error.localizedDescription)
                return
            }

            if let fetchedProducts = fetchedProducts {
                self?.products = fetchedProducts
                self?.state = .content
                self?.collectionView.reloadData()
            }
        }
    }

    func updateUI(for state: ViewControllerState) {
        switch state {
        case .loading:
            loadingIndicator.startAnimating()
            errorMessageLabel.isHidden = true
            collectionView.isHidden = true
        case .error(let message):
            loadingIndicator.stopAnimating()
            errorMessageLabel.text = message
            errorMessageLabel.isHidden = false
            collectionView.isHidden = true
        case .content:
            loadingIndicator.stopAnimating()
            errorMessageLabel.isHidden = true
            collectionView.isHidden = false
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = products[indexPath.item]
        cell.nameLabel.text = product.name
        return cell
    }
}
