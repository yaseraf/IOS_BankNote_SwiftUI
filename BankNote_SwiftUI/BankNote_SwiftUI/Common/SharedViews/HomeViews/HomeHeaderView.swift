//
//  HomeHeaderView.swift
//  QSC
//
//  Created by FIT on 16/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeHeaderView: View {
    @State var isArabic: Bool = AppUtility.shared.isRTL

    @ObservedObject  var viewModel = HomeConfigViewModel.shared
//    var listSearch:Binding<[GetCompaniesLookupsUIModel]?>
//    var companiesLookups:Binding<[GetCompaniesLookupsUIModel]?>

    var onTextChange:((String)->Void)
    var onSearchAction:(()->Void)
    var notificationsCount: Int
    var alertsCount: Int
    
    @State private var searchInputValue: String = ""
    @State private var toggleSearchView: Bool = false
    @State private var hasClearedSerach: Bool = true

var onUserTap:(()->Void)
    var body: some View {
        
        if toggleSearchView {
            searchView
                .padding(.horizontal,16)
                .padding(.top,16)
            
            Divider().ignoresSafeArea()
                .padding(.top,16)
        }
        
        if  !searchInputValue.isEmpty || !hasClearedSerach{
//            getSearchViewResult()
//                .padding(.top,24)
//                .padding(.horizontal,16)

        }
        
        HStack{
            Button {
                onUserTap()
            } label: {
                leftView
            }
            Spacer()

            rightView
        }
    }

    var leftView:some View {
        HStack(spacing: 8){
//            Image(AppUtility.shared.currentUserModel().profile.image)
              Image("")
                    .resizable()
                    .frame(width: 32)
                    .frame(height: 32)
                    .background(
                Circle()
                    .fill(LinearGradient(colors: Color.userGradientsColor, startPoint: .top, endPoint: .bottom))
                    )

            VStack(alignment: .leading,spacing: 0){
                Text("\("welcome".localized)")
                    .font(.apply(size:13))
                    .foregroundStyle(Color.colorTextTertiary)

                HStack {

                    Text("\(AppUtility.shared.isRTL ? UserDefaultController().nameFullNameA?.components(separatedBy: " ").first ?? "" : UserDefaultController().nameFullNameE?.components(separatedBy: " ").first ?? "")")
                        .font(.apply(.semiBold,size:13))
                        .foregroundStyle(Color.colorTextPrimary)

                    Image("ic_downArrow").resizable()
                        .renderingMode(.template)
                        .frame(width: 24)
                        .frame(height:  24)
                        .tint(Color.colorFGQuinary)

                }
                
                Text(isArabic ? UserDefaultController().selectedUserAccount?.ClientNameA ?? "-" : UserDefaultController().selectedUserAccount?.ClientNameE ?? "-")
                    .font(.apply(size:13))
                    .foregroundStyle(Color.colorTextTertiary)

            }
        }
    }
    var rightView:some View {

        HStack(spacing:8){
            Button {
                searchAction()
            } label: {
                Image("ic_searchHome")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 15)
                    .frame(height: 15)
                    .foregroundStyle(Color.colorFGPrimary)
                    .padding(6)
                    .background(
                        Circle()
                            .fill(Color.colorQuaternary)
                    )

            }

            Button {
                notificationAction()
            } label: {
                ZStack{
                    Image("ic_notificationHome")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 15)
                        .frame(height: 15)
                        .foregroundStyle(Color.colorFGPrimary)
                        .padding(6)
                        .background(
                            Circle()
                                .fill(Color.colorQuaternary)
                        )
                    if notificationsCount > 0 || alertsCount > 0 {
                    Text("\(notificationsCount + alertsCount)")
                            .padding(4.5)
                            .foregroundStyle(Color.colorWhite)
                            .font(.apply(size: 11))
                            .background(
                                Circle().fill(Color.colorError)

                            )
                            .offset(y:-10)
                            .offset(x:12)
                    }

                }
            }

        }
    }
    
    private var searchView:some View {
            let binding = Binding<String>(get: {
                       self.searchInputValue
                   }, set: {

                       self.searchInputValue = $0
                       onTextChange( $0)
                       hasClearedSerach = false
                       // do whatever you want here
                   })

            return
        HStack(spacing:8){

            HStack(alignment: .center){
                Image("ic_search")
                    .resizable()
                    .frame(width: 20)
                    .frame(height:  20)

                TextField("", text: binding, prompt: Text("search_for_name".localized)
                    .font(.apply(size: 17))
                    .foregroundColor(.colorTextPlaceHolder)
                )
                .font(.apply(size: 17))
                .foregroundColor(.colorTextPrimary)
                
                if !searchInputValue.isEmpty{

                    Spacer()

                    Button(action: {
                        clearSearch()
                    },
                           label: {

                        Image("ic_xCircle")
                            .renderingMode(.template)
                            .frame(width: 20)
                            .frame(height:  20)
                            .foregroundStyle(Color.colorFGQuinary)

                    })
                }
            }

            .padding(.horizontal,16)
            .padding(.vertical,8)
            .background(RoundedRectangle(cornerRadius: 14)
                .fill(Color.colorBGTertiary)
            )
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.colorBorderPrimary, lineWidth: 2)
            )

            if !searchInputValue.isEmpty || !hasClearedSerach{
                
                Button {
                    clearSearch()
                    hasClearedSerach = true
                } label: {
                    
                    Text("cancel".localized)
                        .font(.apply(size: 15))
                        .foregroundStyle(Color.colorPrimary)
                }
            }


        }
    }

//    private func getSearchViewResult()-> some View{
//        
//        
//        return VStack(alignment:.leading,spacing: nil){
//            Text("stocks_and_mutual_funds".localized)
//                .font(.apply(.semiBold,size: 20))
//                .foregroundStyle(Color.colorTextPrimary)
//
//            if listSearch.wrappedValue?.isEmpty == true{
//                ScrollView{
//                    LazyVStack{
////                        DiscoverSearchEmptyView(searchWord: searchInputValue)
////                    Spacer()
//                    }
//                }
//            }else{
//                
//                if !searchInputValue.isEmpty {
//                    List(listSearch.wrappedValue ?? [], id: \.symbolID) { element in
//                        cellTopGainersView(list:listSearch.wrappedValue ?? [],model:element)
//                    }
//                    .listStyle(.plain)
//
//                } else {
////                    List(companiesLookups.wrappedValue ?? [], id: \.symbolID) { element in
////                        cellTopGainersView(list:companiesLookups.wrappedValue ?? [],model:element)
////                    }
////                    .listStyle(.plain)
//
//                }
//                
////                LazyVStack(){
////                    ForEach(listSearch.wrappedValue ?? [], id: \.symbolID) {element in
////                        cellTopGainersView(list:listSearch.wrappedValue ?? [],model:element)
////
////                    }
////                }
//            }
//                
//
//       }.frame(maxWidth: .infinity)
//    }
    
//    private func cellTopGainersView(list:[GetCompaniesLookupsUIModel], model:GetCompaniesLookupsUIModel) -> some View {
//      return  HStack(spacing:16){
//
//          //Image(model.symbolID ?? "")
//          WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(model.symbol).png")) { phase in
//              switch phase {
//              case .success(let image):
//                  image
//                      .padding(.horizontal, 4)
//                      .foregroundStyle(.gray)
//              case .failure:
//                  Image("ic_selectStock")
//                      .padding(.horizontal, 4)
//                      .foregroundStyle(.gray)
//              case .empty:
//                  Image("ic_selectStock")
//                      .padding(.horizontal, 4)
//                      .foregroundStyle(.gray)
//              @unknown default:
//                  Image("ic_selectStock")
//                      .padding(.horizontal, 4)
//                      .foregroundStyle(.gray)
//              }
//          }
//
//          LazyVStack {
//              HStack {
//                  VStack(alignment: .leading,spacing:2){
//                      Text("\(isArabic ? model.symbolCompanyA : model.symbolCompanyE ?? "")")
//                          .foregroundColor(.black)
//                          .font(.apply(.semiBold,size:15))
//
//                      Text("\(model.symbol)")
//                          .foregroundColor(.gray)
//                          .font(.apply(size:12))
//                  }
//
//                  Spacer()
//
//                  VStack(alignment: .leading,spacing:2){
////                      Text("\(model.precision ?? "")")
////                          .foregroundColor(.gray)
////                          .font(.apply(.medium,size:15))
//
////                      Text("\(model.moneyTransactionType?.rawValue ?? "") \(model.amount)")
////                          .foregroundColor((model.moneyTransactionType ?? .plus) == .plus ?  .colorSuccess2 : .colorError)
////                          .font(.apply(.regular,size:13))
//                  }
//
//
//              }.padding(.vertical,16)
//
////              if index < list.count - 1{
////                  SeparatorCustomView()
////                      .frame(maxWidth: .infinity)
////
////              }
//          }
//        }
//    }
    
    private func clearSearch(){
        searchInputValue = ""
        onTextChange("")
    }

    func searchAction() {
        //toggleSearchView.toggle()
        onSearchAction()
    }

    func notificationAction() {
//        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getMahfaztyCoordinator().openNotificationAlertScene(tabSelect: .notification)

    }
    
}

//#Preview {
//    HomeHeaderView(onUserTap: {})
//}
