import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    @Published var isLocationPermissionGranted = false
    private var manager: CLLocationManager
    
    override init() {
        self.manager = CLLocationManager()
        super.init()
        self.manager.delegate = self
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Location restricted/denied")
        case .authorizedAlways, .authorizedWhenInUse:
            isLocationPermissionGranted = true
            lastKnownLocation = manager.location?.coordinate
        @unknown default:
            print("Location service disabled")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
