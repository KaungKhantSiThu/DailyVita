 import SwiftUI

 struct FlowLayout: Layout {
    var spacing: CGFloat
    
    init(spacing: CGFloat = 8) {
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var position = CGPoint.zero
        var maxHeight: CGFloat = 0
        let containerWidth = proposal.width ?? .infinity
        
        // Calculate position for each subview
        for size in sizes {
            if position.x + size.width > containerWidth {
                // Move to next row
                position.x = 0
                position.y += size.height + spacing
            }
            
            position.x += size.width + spacing
            maxHeight = max(maxHeight, position.y + size.height)
        }
        
        return CGSize(width: containerWidth, height: maxHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var position = CGPoint(x: bounds.minX, y: bounds.minY)
        let containerWidth = bounds.width
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if position.x + size.width > containerWidth {
                // Move to next row
                position.x = bounds.minX
                position.y += size.height + spacing
            }
            
            subview.place(
                at: CGPoint(x: position.x, y: position.y),
                proposal: ProposedViewSize(size)
            )
            
            position.x += size.width + spacing
        }
    }
}

// Preview provider for testing
struct FlowLayout_Previews: PreviewProvider {
    static var previews: some View {
        FlowLayout(spacing: 8) {
            ForEach(0..<10) { index in
                Text("Item \(index)")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}