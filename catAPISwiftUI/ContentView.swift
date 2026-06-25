//
//  ContentView.swift
//  catAPISwiftUI
//
//  Created by Aluno ISTEC on 05/01/2026.
//

import SwiftUI

struct Fact: Decodable {
    let fact: String
    let length: Int
}

struct ContentView: View {
    @State var fact: String = "The facts will appear here"
    @State var catImg: String = "cat1"
    var body: some View {
        VStack {
            Text(fact)
                .bold()
                .font(.largeTitle)
                .frame(maxWidth: 300)
            Spacer()
            Image(catImg)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 400)
                .clipShape(.containerRelative)
                .shadow(radius: 5)
            Spacer()
            Button {
                print("Button clicked")
                
                Task {
                    await fetchFact()
                }
            } label: {
                Text("Get Factq")
                    .frame(width: 200, height: 42)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(.buttonBorder)
            }
            Spacer()

        }
        
    }
    
    private func alterCatImg() {
        catImg = "cat\(Int.random(in: 1...6))"
    }
    
    private func fetchFact() async {
        guard let url = URL(string: "https://catfact.ninja/fact?max_length=30") else {
            return
        }
        defer {
            alterCatImg()
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedFact = try? JSONDecoder().decode(Fact.self, from: data) {
                fact = decodedFact.fact
            }
        } catch {
            print("Erro ao carregar")
        }
    }
}

#Preview {
    ContentView()
}
