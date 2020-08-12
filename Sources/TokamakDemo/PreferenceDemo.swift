//
//  File.swift
//
//
//  Created by Carson Katri on 8/12/20.
//

import TokamakShim

struct TestPref: PreferenceKey {
  static let defaultValue = "No value"
  static func reduce(value: inout String, nextValue: () -> String) {
    value = nextValue()
  }
}

struct PreferenceDemo: View {
  @State private var value: String = "No value"
  @State private var flip = false

  let branches = Array([
    AnyView(
      ABranch()
        .padding()
        .background(Color.blue)
    ),
    AnyView(
      BBranch()
        .padding()
        .background(Color.green)
    ),
  ].enumerated())

  var body: some View {
    VStack {
      Text("TestPref value: \(value)")
      Text("(the reduce function should always take the last value)")
      Button("Flip") { flip.toggle() }
      ForEach(flip ? branches.reversed() : branches, id: \.offset) { _, branch in
        branch
      }
    }
    .onPreferenceChange(TestPref.self) {
      value = $0
      print("Root received: ", $0)
    }
  }

  struct ABranch: View {
    @State private var value: String = "No value"

    var body: some View {
      VStack {
        Text("A Branch")
        Text("If the following is 'B', we failed: \(value)")
      }
      .preference(key: TestPref.self, value: "A")
      .onPreferenceChange(TestPref.self) {
        print("A received: ", $0, "(was", value, ")")
        value = $0
      }
    }
  }

  struct BBranch: View {
    @State private var value: String = "No value"

    var body: some View {
      VStack {
        Text("B Branch")
        Text("If the following is 'A', we failed: \(value)")
      }
      .preference(key: TestPref.self, value: "B")
      .onPreferenceChange(TestPref.self) {
        print("B received: ", $0, "(was", value, ")")
        value = $0
      }
    }
  }
}
