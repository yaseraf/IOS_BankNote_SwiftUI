/*
See the License.txt file for this sample’s licensing information.
*/

import SwiftUI

struct ViewfinderView: View {
    
    
    @Binding var image: Image?
    var isLiveness: Bool
    
    var body: some View {
        GeometryReader { geometry in
            if let image = image {
                if !isLiveness {
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        image
                            .resizable()
                            .cornerRadius(24)
                            .aspectRatio(contentMode: .fill)
    //                        .scaledToFill()
                            .mask (
                                RoundedRectangle(cornerRadius: 24)
                                    .blendMode(.normal)
                                    .frame(width: geometry.size.width - 10, height: geometry.size.height / 3.5)
                                    .padding(.bottom, 40)
                                    .offset(x: -85, y: 0)
                            )
                    } else if UIDevice.current.userInterfaceIdiom == .pad {
                        image
                            .resizable()
                            .cornerRadius(24)
                            .aspectRatio(contentMode: .fill)
    //                        .scaledToFill()
                            .mask (
                                RoundedRectangle(cornerRadius: 24)
                                    .blendMode(.normal)
                                    .frame(width: 642, height: 365)
                                    .padding(.bottom, 60)
                            )
                    }
                    
                } else {
//                    image
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}

struct ViewfinderView_Previews: PreviewProvider {
    static var previews: some View {
        ViewfinderView(image: .constant(Image(systemName: "pencil")), isLiveness: false)
    }
}
