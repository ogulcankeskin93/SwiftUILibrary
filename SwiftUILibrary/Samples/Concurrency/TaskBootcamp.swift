//
//  TaskBootCamp.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 03/08/2022.
//

import SwiftUI

struct TaskBootcamp: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            ForEach(viewModel.images, id: \.self) {
                Image(uiImage: $0)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.fetchImage()
        }
        .onAppear {
            Task {
                await viewModel.fetchImage()
            }

            Task {
                await viewModel.fetchImage()
            }
        }
    }
}


extension TaskBootcamp {

    class ViewModel: ObservableObject {
        @Published var images = [UIImage]()

        func fetchImage() async {
            do {
                guard let url = URL(string: "https://picsum.photos/200") else { return }
                let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
                await MainActor.run {
                    if let image = UIImage (data: data) {
                        self.images.append(image)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


struct TaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TaskBootcamp()
    }
}
