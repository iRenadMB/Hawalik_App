
import SwiftUI
import MapKit
import CoreLocation
import Firebase
import FirebaseDatabase

struct MapViewContainer: View {
    
    @State private var showLoginAlert = false
    @State private var isLoggingIn = true
    @State private var showLogInPage = false
    @State private var showSignUpPage = false
    @State private var centerCoordinate = CLLocationCoordinate2D(latitude: 24.774265, longitude: 46.738586)
    @State private var annotations = [MKPointAnnotation]()
    @State private var showingCarDetailsView = false
    @State private var savedLocations = [CLLocationCoordinate2D]()

    var body: some View {
        
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, annotations: $annotations)
                .onTapGesture {
                    showingCarDetailsView = true
                    ignoresSafeArea()
                }
        }
        .onAppear {
            annotations.append(MKPointAnnotation())

            // Get saved locations from Firebase
            let ref = Database.database().reference()
            ref.child("locations").observe(.value, with: { snapshot in
                guard let value = snapshot.value as? [String: Any] else { return }
                var newSavedLocations = [CLLocationCoordinate2D]()

                for (_, location) in value {
                    guard let locationDict = location as? [String: Any],
                          let latitude = locationDict["latitude"] as? CLLocationDegrees,
                          let longitude = locationDict["longitude"] as? CLLocationDegrees else { continue }
                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotations.append(annotation)
                    newSavedLocations.append(coordinate)
                }
                savedLocations = newSavedLocations
            })

            // Get user's current location
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
            if let location = locationManager.location {
                centerCoordinate = location.coordinate
            }
        }
        .sheet(isPresented: $showingCarDetailsView) {
            
            VStack(alignment: .leading, spacing: 10){
                SheetDetilCar()
            }
    
            .presentationDetents([.height(230), .medium])
        }
    }
}

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var annotations: [MKPointAnnotation]
    @State private var showingAlert = false

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Annotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }

        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if let annotation = view.annotation {
                print(annotation.title ?? "")
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.centerCoordinate = centerCoordinate

        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        view.setRegion(region, animated: true)

        let currentAnnotations = view.annotations.filter { $0 is MKPointAnnotation }
        view.removeAnnotations(currentAnnotations)
        view.addAnnotations(annotations)
    }
}

struct ContentView1: View {
    var body: some View {
        NavigationView {
            FormPage()
                .navigationTitle("Car Details")
        }
    }
}

struct MapViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        MapViewContainer()
    }
}
