//
//  ContentView.swift
//  SwiftData
//
//  Created by Manav Prakash on 14/06/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var context
  @Query var users: [User]
  @State var newUser: String = ""
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(users, id: \.self) { user in
          Text(user.name)
        }
        .onDelete(perform: delete)
        TextField("Enter a new name", text: $newUser)
          .autocorrectionDisabled()
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
            EditButton()
        }
        ToolbarItem {
          addButton
        }
      }
      .navigationTitle("Users")
      .navigationBarTitleDisplayMode(.large)
    }
  }
  
  var addButton: some View {
    Button(action: createUser) {
        Label("Add Item", systemImage: "plus")
    }
  }
  
  func delete(at offsets: IndexSet) {
    withAnimation {
      offsets.forEach { index in
        context.delete(users[index])
        try? context.save()
      }
    }
  }
  
  func createUser() {
    withAnimation {
      let user = User(id: UUID().uuidString, name: newUser)
      context.insert(user)
      try? context.save()
      newUser = ""
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
