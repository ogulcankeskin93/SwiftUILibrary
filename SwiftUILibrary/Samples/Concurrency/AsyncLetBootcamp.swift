//
//  AsyncLetBootcamp.swift
//  SwiftUILibrary
//
//  Created by Ogulcan Keskin on 13/11/2022.
//

import SwiftUI

struct AsyncLetBootcamp: View {
    @State var images: [UIImage] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                    }
                }
            }
            .navigationTitle("Async Let 🥳")
            .onAppear {
                Task {
                    async let fetchImage = fetchImageOnline()
                    async let fetchImage2 = fetchImageOnline()
                    async let fetchImage3 = fetchImageOnline()

                    let (image, image2, image3) = await (try fetchImage, try fetchImage2, try fetchImage3)

                    images.append(image)
                    images.append(image2)
                    images.append(image3)

                }
            }
//            .onAppear {
//                Task {
//                    let image = try await fetchImage()
//                    images.append(image)
//
//                    let image2 = try await fetchImage()
//                    images.append(image2)
//
//                    let image3 = try await fetchImage()
//                    images.append(image3)
//                }
//            }
        }
    }


    func fetchImageOnline() async throws -> UIImage {
        print("Icerdeyim")
        do {
            let url = URL(string: "https://picsum.photos/200")!
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            if let image = UIImage (data: data) {
                return image
            } else {
                throw URLError.init(.badURL)
            }
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}

struct AsyncLetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncLetBootcamp()
    }
}
