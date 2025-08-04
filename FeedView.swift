import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.posts) { post in
                    if post.type == .text {
                        TextPostView(post: post)
                    } else if post.type == .image {
                        ImagePostView(post: post)
                    }

                    if post == viewModel.posts.last {
                        Color.clear
                            .onAppear {
                                viewModel.fetchPosts()
                            }
                    }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .refreshable {
                viewModel.refreshFeed()
            }
            .navigationTitle("Social Feed")
        }
    }
}
