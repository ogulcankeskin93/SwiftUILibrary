//
//  AsyncAwaitBootcamp.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 30.06.2022.
//

import SwiftUI

struct AsyncAwaitBootcamp: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        List(viewModel.dataArray, id: \.self) { text in
            Text(text)
        }
        .onAppear {
            /**
             Dispatch
             viewModel.mainThread()
             viewModel.backgroundThread()
             */
            
            
            Task {
                await viewModel.addAuthor()
                await viewModel.addSomething()
                
                let final = "Final: \(Thread.current)"
                viewModel.dataArray.append(final)
            }
        }
    }
}

extension AsyncAwaitBootcamp {
    class ViewModel: ObservableObject {
        @Published var dataArray = [String]()
        
        func mainThread() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dataArray.append("Title 1: \(Thread.current)")
            }
        }
        
        func backgroundThread() {
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                let title = "Title 2: \(Thread.current)"
                DispatchQueue.main.async {
                    self.dataArray.append(title)
                    let titleInner = "Title 3: \(Thread.current)"
                    self.dataArray.append(titleInner)
                }
            }
        }
        
        func addAuthor() async {
            let author = "Author 1: \(Thread.current)"
            self.dataArray.append(author)
            
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            
            let author2 = "Author 2: \(Thread.current)"
            self.dataArray.append(author2)

            await MainActor.run(body: {
                let author3 = "Author 2: \(Thread.current)"
                self.dataArray.append(author3)
            })
        }
        
        func addSomething() async {
            let something = "Something 1: \(Thread.current)"
            self.dataArray.append(something)
            
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            
            let something2 = "Something 2: \(Thread.current)"
            self.dataArray.append(something2)

            await MainActor.run(body: {
                let something3 = "Something 2: \(Thread.current)"
                self.dataArray.append(something3)
            })
        }
    }
}

struct AsyncAwaitBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwaitBootcamp()
    }
}
