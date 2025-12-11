//
//  CommentField.swift
//  Flow
//
//  Created by Darking Almas on 09.12.2025.
//

import SwiftUI

struct CommentField: View {
    @Binding var comment: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Комментарий")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            TextField("Введите комментарий", text: $comment)
                .font(.system(size: 16))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.9))
                )
        }
    }
}

