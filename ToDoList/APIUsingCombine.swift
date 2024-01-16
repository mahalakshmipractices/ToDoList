//
//  APIUsingCombine.swift
//  ToDoList
//
//  Created by Mahalakshmi Srinivasan on 11/01/24.
//

import SwiftUI
import Combine

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private var cancellables: Set<AnyCancellable> = []

    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error \(error)")
                }
            }, receiveValue: {[weak self] posts in
                self?.posts = posts

            })
            .store(in: &cancellables)
    }

    func fetchData<T: Decodable>(
            from url: URL,
            decodingType: T.Type,
            handleResult: @escaping (Result<T, Error>) -> Void
        ) {
            //isLoading = true // Set loading state before making the request

            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: decodingType, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {  completion in
                    //self?.isLoading = false // Set loading state after receiving the result

                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        //self?.errorMessage = error.localizedDescription
                        handleResult(.failure(error))
                    }
                }, receiveValue: { result in
                    // Call the handleResult closure with the decoded result
                    handleResult(.success(result))
                })
                .store(in: &cancellables)
        }
}

struct APIUsingCombine: View {
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.posts, id: \.id) { post in
                VStack {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

            }
            .navigationTitle("Sample API Using Combine")
            .listStyle(.plain)
            .onAppear {
                //self.viewModel.fetchPosts()
                self.viewModel.fetchData(from: URL(string: "https://jsonplaceholder.typicode.com/posts")!, decodingType: [Post].self) { result in
                                    switch result {
                                    case .success(let decodedResult):
                                        self.viewModel.posts = decodedResult
                                    case .failure(let error):
                                        // Handle error appropriately (already handled in fetchData)
                                        break
                                    }
                                }            }
        }
    }
}

struct APIUsingCombine_Previews: PreviewProvider {
    static var previews: some View {
        APIUsingCombine()
    }
}
