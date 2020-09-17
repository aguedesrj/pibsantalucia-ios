//
//  HomeViewController.swift
//  pibsantalucia
//
//  Copyright © 2020 André Lessa Guedes. All rights reserved.
//

import UIKit
import Kingfisher
import CoreLocation

class HomeViewController: BaseViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var tableViewPharmacy: UITableView!
    
    var user: UserModel!
    
    fileprivate var presenter: HomePresenter!
    fileprivate var listPharmacy: [PharmacyModel] = []
    fileprivate let locationManager = CLLocationManager()
    fileprivate var currentUserLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewPharmacy.register(UINib(nibName: "PharmacyTableViewCell", bundle: nil),
                                  forCellReuseIdentifier: "PharmacyTableViewCell")
        
        presenter = HomePresenter.init(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        layoutScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.determineMyCurrentLocation()
        
        self.showLoadingWithTextProgress(textProgress: "Obtendo as farmácias mais próximas...")
    }
}

extension HomeViewController {
    
    fileprivate func layoutScreen() {
        
        labelName.text = user.name
        imageViewPhoto.tintColor = Color.primary.value
        
        let sizeImageViewPhoto: CGSize = imageViewPhoto.frame.size
        imageViewPhoto.layer.cornerRadius = sizeImageViewPhoto.width / 2
        imageViewPhoto.layer.borderColor = Color.primary.value.cgColor
        imageViewPhoto.layer.borderWidth = 4
        imageViewPhoto.kf.indicatorType = .activity
        
        imageViewPhoto.kf.setImage(
            with: URL(string: user.photo),
            placeholder: UIImage(named: "iconPlaceholderUser"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.1))
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Sucesso: \(value.source.url?.absoluteString ?? "")")
                self.imageViewPhoto.image = value.image
            case .failure(let error):
                print("Erro: \(error.localizedDescription)")
            }
        }
    }
    
    fileprivate func determineMyCurrentLocation() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
}

extension HomeViewController: HomeViewProtocol {
    
    func success(listPharmacy: [PharmacyModel]) {
        self.listPharmacy = listPharmacy
        
        tableViewPharmacy.reloadData()
        
        self.hideLoading()
    }
    
    func error(message: String) {
        self.showAlert(message: message)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPharmacy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pharmacy: PharmacyModel = listPharmacy[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PharmacyTableViewCell",
                                                 for: indexPath) as! PharmacyTableViewCell
        
        cell.selectionStyle = .none
        cell.setValues(pharmacy: pharmacy)
        
        return cell
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last != nil {
            
            self.currentUserLocation = manager.location!
            presenter.nearestPharmacies(latitude: (manager.location?.coordinate.latitude)!,
                                        longitude: (manager.location?.coordinate.longitude)!)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = manager.location {
                self.currentUserLocation = location
                
                presenter.nearestPharmacies(latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)
            }
        case .denied, .restricted:
            self.showAlert(message: "Sem permissão de acessar minha localização!")
        default:
            break
        }
    }
}
