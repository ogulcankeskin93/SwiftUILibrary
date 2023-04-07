import Foundation
import MapKit
import SwiftUI

final class LocationViewModel: ObservableObject {

    @Published var locationList: [Location]

    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    @Published var showLocationList = false

    init() {
        let locations = LocationsDataService.locations
        self.locationList = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: mapLocation)
    }

    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan
            )
        }
    }

    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }

    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }

    func nextButtonPressed() {
        guard let currentIndex = locationList.firstIndex(of: mapLocation).map({ Int($0) })  else { return }
        let nextIndex = (currentIndex + 1) % (locationList.count)
        showNextLocation(location: locationList[nextIndex])
    }
}
