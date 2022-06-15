//
//  DropDownView.swift
//  Increment
//
//  Created by Lusine on 5/20/22.
//

import SwiftUI

struct DropdownView<T: DropDownItemProtocol>: View {
    @Binding var viewModel: T
    
    var actionSheet: ActionSheet {
     ActionSheet(title: Text("Select"),
                    buttons: viewModel.options.map { option in
                        
                    return .default(Text(option.formatted)) {
                            viewModel.selectedOption = option
                        }
                    })
    }
    var body: some View{
        VStack{
            HStack {
                Text(viewModel.headerTittle)
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            }.padding(.vertical, 10)
            Button(action:{
                viewModel.isSelected = true
            }) {
                HStack {
                    Text(viewModel.dropDownTittle)
                        .font(.system(size: 28, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                }
            } .buttonStyle(PrimaryButtonStyle())
        }
        .actionSheet(isPresented: $viewModel.isSelected) {
        actionSheet
        }
        .padding(15)
    }
}

//struct DropdownView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            DropdownView()
//        }
//        NavigationView {
//            DropdownView()
//        }.environment(\.colorScheme, .dark)
//    }
//}
