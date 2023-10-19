//
//  AnimationView.swift
//  CheckPointUI
//
//  Created by Pedro Rafael Madeira Vasconcelos on 02/09/23.
//

import SwiftUI

public var testeColor: Color = .black

struct AnimationView: View {
    @State private var isRotate = false
    @State private var isChangeOffset = false
    private let verticalLineWidth = 10.0
    private let verticalLineHeight = 40.0
    private let horizontalLineWidth = 40.0
    private let horizontalLineHeight = 10.0
    private let rotationDegree = -45.0

    var body: some View {
        ZStack() {
            Color.orange.edgesIgnoringSafeArea(.all)
            HStack(spacing: -2) {
                Rectangle()
                    .frame(width: horizontalLineWidth, height: horizontalLineHeight)
                    .cornerRadius(4)
                    .foregroundColor(testeColor)
                    .rotationEffect(.degrees(isRotate ? rotationDegree : 0),
                                    anchor: .center)
                    .offset(x: 0, y: isChangeOffset ? 10 : 0)

                Rectangle()
                    .frame(width: horizontalLineWidth, height: horizontalLineHeight)
                    .cornerRadius(4)
                    .foregroundColor(testeColor)
                    .rotationEffect(.degrees(isRotate ? rotationDegree : 0),
                                    anchor: .center)
                    .offset(x: isChangeOffset ? -10 : 0, y: isChangeOffset ? -18 : 0)
            }
            VStack(spacing: -2) {
                Rectangle()
                    .frame(width: verticalLineWidth, height: verticalLineHeight)
                    .cornerRadius(4)
                    .foregroundColor(testeColor)
                    .rotationEffect(.degrees(isRotate ? rotationDegree : 0),
                                    anchor: .center)
                    .offset(x: isChangeOffset ? -20 : 0, y: isChangeOffset ? 0 : 0)

                Rectangle()
                    .frame(width: verticalLineWidth, height: verticalLineHeight)
                    .cornerRadius(4)
                    .foregroundColor(testeColor)
                    .rotationEffect(.degrees(isRotate ? rotationDegree : 0),
                                    anchor: .center)
                    .offset(x: isChangeOffset ? 10 : 0, y: isChangeOffset ? -8 : 0)
            }
        }.animation(.linear(duration: 0.3))
            .frame(height: UIScreen.main.bounds.height)
            .onTapGesture {
                isRotate.toggle()
                changeColorWhite()
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isChangeOffset.toggle()
                        changeColorBlack()
                    }
                }
            }
    }
}

func changeColorWhite() {
    testeColor = .white
}

func changeColorBlack() {
    testeColor = .black
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}

