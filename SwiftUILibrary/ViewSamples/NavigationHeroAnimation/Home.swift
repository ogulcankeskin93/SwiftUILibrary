//
//  Home.swift
//  SwiftUILibrary
//
//  Created by ogulcan keskin on 22.07.2023.
//

import SwiftUI

struct Home: View {
    
    @Binding var selectedProfile: Profile?
    @Binding var pushView: Bool
    
    var body: some View {
        List {
            ForEach(Profile.mocks) { profile in
                Button {
                    selectedProfile = profile
                    pushView.toggle()
                } label: {
                    HStack(spacing: 15) {
                        Color.clear
                            .frame(width: 60, height: 60)
                            .anchorPreference(
                                key: MNAnchorKey.self,
                                value: .bounds
                            ) { anchor in
                                return [profile.id: anchor]
                            }

                        VStack(alignment: .leading, spacing: 2) {
                            Text(profile.userName)
                                .fontWeight(.semibold)
                            
                            Text(profile.lastMsg)
                                .font(.callout)
                                .textScale(.secondary)
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(profile.lastActive)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .contentShape(.rect)
                }

            }
        }
        .overlayPreferenceValue(MNAnchorKey.self, { value in
            GeometryReader { geometry in
                ForEach(Profile.mocks) { profile in
                    if let anchor = value[profile.id], selectedProfile?.id != profile.id {
                        let rect = geometry[anchor]
                        ImageView(profile: profile, size: rect.size)
                            .offset(x: rect.minX, y: rect.minY)
                    }
                }
            }
        })
    }
}

struct DetailView: View {
    
    @Binding var selectedProfile: Profile?
    @Binding var pushView: Bool
    @Binding var hideView: (Bool, Bool)
    
    var body: some View {
        if let selectedProfile {
            VStack {
                GeometryReader { geometry in
                    let size = geometry.size
                    VStack {
                        if hideView.0 {
                            ImageView(profile: selectedProfile, size: size)
                                .overlay(alignment: .top) {
                                    Button {
                                        hideView.0 = false
                                        hideView.1 = false
                                        pushView = false
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                                            self.selectedProfile = nil
                                        })
                                        
                                    } label: {
                                        Image(systemName: "xmark")
                                            .foregroundStyle(.white)
                                            .padding(20)
                                            .background(.black, in: .circle)
                                            .contentShape(.circle)
                                    }
                                    .padding(15)
                                    .padding(.top, 30)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .opacity(hideView.1 ? 1 : 0)
                                    .animation(.snappy, value: hideView.1)
                                }
                                .onAppear(perform: {
                                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                                        hideView.1 = true
                                    })
                                })
                        } else {
                            Color.clear
                        }
                    }
                    .anchorPreference(
                        key: MNAnchorKey.self,
                        value: .bounds,
                        transform: { anchor in
                            return [selectedProfile.id: anchor]
                        })
                }
                .frame(height: 400)
                .ignoresSafeArea()
                
                Spacer(minLength: 0)
            }
            .toolbar(hideView.0 ? .hidden : .visible, for: .navigationBar)
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.45, execute: {
                    hideView.0 = true
                })
            })
        }
    }
}

struct ImageView: View {
    var profile: Profile
    var size: CGSize
    
    
    var body: some View {
        Image(profile.picture)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .clipShape(.rect(cornerRadius: size.width > 60 ? 0 : 30))
    }
}

#Preview {
    ContentNavigationHeroView()
}

struct ContentNavigationHeroView: View {
    
    @State var selectedProfile: Profile?
    @State var pushView: Bool = false
    @State var hideView: (Bool, Bool) = (false, false)

    var body: some View {
        NavigationStack {
            Home(selectedProfile: $selectedProfile, pushView: $pushView)
                .navigationTitle("Profiles")
                .navigationDestination(isPresented: $pushView) {
                    DetailView(
                        selectedProfile: $selectedProfile,
                        pushView: $pushView,
                        hideView: $hideView
                    )
                }
        }
        .overlayPreferenceValue(MNAnchorKey.self, { value in
            GeometryReader { geometry in
                if let selectedProfile,
                   let anchor = value[selectedProfile.id],
                   !hideView.0 {
                    let rect = geometry[anchor]
                    ImageView(profile: selectedProfile, size: rect.size)
                        .offset(x: rect.minX, y: rect.minY)
                        .animation(.snappy(duration: 0.35, extraBounce: 0), value: rect)
                }
            }
        })
    }
}
