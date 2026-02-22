//
//  StyledView.swift
//  SwiftUI-StateAndDataManagement
//
//  Created by Anand Kumar on 2/21/26.
//

import SwiftUI

struct StyledView: ViewModifier {
    let backgroundColor: Color
    let strokeColor: Color
    let cornerRadius: CGFloat
    let padding: CGFloat
    let maxWidth: CGFloat?
    let alignment: Alignment

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .frame(maxWidth: maxWidth, alignment: alignment)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(strokeColor, lineWidth: 1)
            )
    }
}

extension View {
    func styledView(
        backgroundColor: Color,
        strokeColor: Color,
        cornerRadius: CGFloat = 12,
        padding: CGFloat = 12,
        maxWidth: CGFloat? = .infinity,
        alignment: Alignment = .leading
    ) -> some View {
        modifier(
            StyledView(
                backgroundColor: backgroundColor,
                strokeColor: strokeColor,
                cornerRadius: cornerRadius,
                padding: padding,
                maxWidth: maxWidth,
                alignment: alignment
            )
        )
    }
}
