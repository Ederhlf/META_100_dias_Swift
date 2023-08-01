
import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
    var mapView = MKMapView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        alertMapType()

    }
 
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        
        let identifier = "Capital"
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(
                withIdentifier: identifier
               ) as? MKPinAnnotationView else {
                let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView.pinTintColor = UIColor.orange
            annotationView.canShowCallout = true
            mapView.mapType = .satellite
            return annotationView
        }
        
        annotationView.annotation = annotation
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func alertMapType() {
        let alertvc = UIAlertController(
            title: "MapTYpe",
            message: "escolha o estilo de visualizacao",
            preferredStyle: .alert
        )
        
        let actionSatelite = UIAlertAction(title: "Satelite", style: .default, handler: {_ in
            self.mapView.mapType = .satellite
        })
        
        let actionhybrid = UIAlertAction(title: "Hybrid", style: .default, handler: {_ in
            self.mapView.mapType = .hybrid
        })
        
        let actionstandard = UIAlertAction(title: "Standart", style: .default, handler: {_ in
            self.mapView.mapType = .standard
        })
        
        alertvc.addAction(actionSatelite)
        alertvc.addAction(actionhybrid)
        alertvc.addAction(actionstandard)
        present(alertvc, animated: true, completion: nil)
        
    }
}

