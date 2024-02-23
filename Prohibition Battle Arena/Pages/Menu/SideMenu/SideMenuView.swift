//
//  SideMenuView.swift
//  Prohibition Battle Arena
//
//  Created by tamakimasato on 2024/01/06.
//

import SwiftUI
var screenWidth = UIScreen.main.bounds.width
var screenHeight = UIScreen.main.bounds.height
struct SideMenuView: View {
    /// メニュー開閉
    @Binding var isOpen: Bool
    @State private var offset = CGFloat.zero
    @State private var closeOffset = CGFloat.zero
    @State private var openOffset = CGFloat.zero
    @State private var isShowAccountView:Bool = false
    @State private var isShowRoomSelectView:Bool = false
    @State private var isShowLogoutView:Bool = false
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isOpen.toggle()
                        }
                    }
                    .opacity(isOpen ? 0.7 : 0)
                ZStack {
                    List {
                        Section {
                            //アカウント情報
                            Button(action: {
                                isShowAccountView.toggle()
                                isOpen.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "person")
                                    Text("アカウント情報")
                                }
                            }
                            .sheet(isPresented: $isShowAccountView) {
                                AccountView(isOpen: $isShowAccountView)
                            }
                            .foregroundColor(.black)
                            //ルーム選択
                            Button(action: {
                                isShowRoomSelectView.toggle()
                                isOpen.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "square.grid.3x3.topleft.filled")
                                    Text("ルーム選択")
                                }
                            }
                            .sheet(isPresented: $isShowRoomSelectView) {
                                RoomSelectView(isOpen: $isShowRoomSelectView)
                            }
                            .foregroundColor(.black)
                            //ログアウト
                            Button(action: {
                                isShowLogoutView.toggle()
                                isOpen.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "door.left.hand.open")
                                    Text("ログアウト")
                                }
                            }
                            .sheet(isPresented: $isShowLogoutView) {
                                LogoutView(isOpen: $isShowLogoutView)
                            }
                            .foregroundColor(.black)
                            HStack {
                                Image(systemName: "info.circle")
                                Text("アプリケーション情報")
                            }
                        }
                    }
                    VStack {
                        Spacer()
                        Text("developed by")
                            .font(.footnote)
                        Text("Cafe")
                            .font(.footnote)
                    }
                    .foregroundColor(.secondary)
                    .padding()
                }
                .padding(.trailing, geometry.size.width/4)
                .offset(x: isOpen ? 0+self.offset : -geometry.size.width)
            }
            
            .gesture(DragGesture(minimumDistance: 5)
                .onChanged{ value in
                    self.offset = value.translation.width
                }
                .onEnded { value in
                    if (-value.translation.width > geometry.size.width/4) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isOpen.toggle()
                        }
                        self.offset = self.closeOffset
                    } else {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.offset = self.closeOffset
                        }
                    }
                }
            )
        }
    }
}

struct SlideContentView_preview: PreviewProvider {
    static var previews: some View {
        SideMenuView(isOpen: Binding.constant(true))
    }
}
