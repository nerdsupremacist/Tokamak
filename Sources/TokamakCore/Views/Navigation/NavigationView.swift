// Copyright 2020 Tokamak contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//  Created by Jed Fox on 06/30/2020.
//

final class NavigationContext: ObservableObject {
  @Published var destination = NavigationLinkDestination(EmptyView())
  @Published var title: String? = nil
  @Published var toolbar = AnyView(EmptyView())
}

public struct NavigationView<Content>: View where Content: View {
  let content: Content

  @ObservedObject var context = NavigationContext()

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  public var body: Never {
    neverBody("NavigationView")
  }
}

/// This is a helper class that works around absence of "package private" access control in Swift
public struct _NavigationViewProxy<Content: View>: View {
  public let subject: NavigationView<Content>

  public init(_ subject: NavigationView<Content>) { self.subject = subject }

  public var title: String? { subject.context.title }

  public var body: some View {
    subject.content
      .environmentObject(subject.context)
      .onPreferenceChange(NavigationTitleKey.self) {
        subject.context.title = $0
      }
      .onPreferenceChange(ToolbarKey.self) {
        subject.context.toolbar = $0.content
      }
  }

  public var destination: some View {
    subject.context.destination.view
      .environmentObject(subject.context)
  }

  public var toolbar: AnyView { subject.context.toolbar }
}
