import SwiftUI
import MapKit

struct LocationMapAnnotationView: View {

    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(Color("AccentColor"))
                .cornerRadius(36)

            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundColor(Color("AccentColor"))
                .rotationEffect(.degrees(180))
                .offset(y: -3)
        }
    }
}
struct LocationView: View {

    @EnvironmentObject private var viewModel: LocationViewModel

    var body: some View {
        ZStack {
            mapLayer
            .ignoresSafeArea()

            VStack {
                header
                    .padding()
                Spacer()
                locationPreviewStack
            }
        }
    }
}

extension LocationView {

    private var header: some View {
        VStack(spacing: 0) {
            Button {
                viewModel.toggleLocationList()
            } label: {
                Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: viewModel.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees:  viewModel.showLocationList ? 180 : 0))
                    }
            }


            if viewModel.showLocationList {
                LocationListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }

    private var mapLayer: some View {
        Map(
            coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.locationList,
            annotationContent: { location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
                        .onTapGesture {
                            viewModel.showNextLocation(location: location)
                        }
                }
            }
        )
    }

    private var locationPreviewStack: some View {
        ZStack {
            ForEach(viewModel.locationList) { location in
                if viewModel.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            )
                        )
                }
            }
        }
    }
}


struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationViewModel())
    }
}
