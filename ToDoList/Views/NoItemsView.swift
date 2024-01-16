//
//  NoItemsView.swift
//  ToDoList
//
//  Created by Mahalakshmi Srinivasan on 16/01/24.
//

import SwiftUI

struct NoItemsView: View {
    @State var animate: Bool = false
    let secondayAccentColor = Color("SecondaryAccentColor")

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("There are no items in your do to list")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Do you want to add an item")
                    .padding(.bottom, 20)
                NavigationLink(
                    destination: AddView(),
                    label: {
                        Text("Add Something")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(animate ? secondayAccentColor : Color.accentColor)
                            .cornerRadius(10)
                    })
                .padding(.horizontal, animate ? 30 : 50)
                .shadow(
                    color: animate ? secondayAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                    radius: animate ? 30 : 10,
                    x: 0.0,
                    y: animate ? 50 : 30)
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)

            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    NavigationView {
        NoItemsView()
            .navigationTitle("Title")
    }

}
