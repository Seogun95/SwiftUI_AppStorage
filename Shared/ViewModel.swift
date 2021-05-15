//
//  ViewModel.swift
//  SwiftUI_AppStorage
//
//  Created by Seogun Kim on 2021/05/15.
//

import SwiftUI


struct FruitModdel: Identifiable {
    var id: String = UUID().uuidString
    let name: String
    let count: Int
}

class FruitViewModel: ObservableObject {
    @Published var fruitArray: [FruitModdel] = []
    @Published var isLoading: Bool = false
    
    init() {
        getFruits()
    }
    func getFruits() {
        let fruit1 = FruitModdel(name: "사과", count: 3)
        let fruit2 = FruitModdel(name: "배", count: 4)
        let fruit3 = FruitModdel(name: "키위", count: 2)
        let fruit4 = FruitModdel(name: "딸기", count: 5)
        let fruit5 = FruitModdel(name: "바나나", count: 20)
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.fruitArray.append(fruit1)
            self.fruitArray.append(fruit2)
            self.fruitArray.append(fruit3)
            self.fruitArray.append(fruit4)
            self.fruitArray.append(fruit5)
            self.isLoading = false
        }
    }
    
    func deleteItme(index: IndexSet) {
        fruitArray.remove(atOffsets: index)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        fruitArray.move(fromOffsets: from, toOffset: to)
    }
}

struct ViewModel: View {
    //    @State var fruitArray: [FruitModdel] = []
    //    @ObservedObject var fruitViewModel: FruitViewModel = FruitViewModel()
    @StateObject var fruitViewModel: FruitViewModel = FruitViewModel()
    
    var body: some View {
        NavigationView {
            List {
                
                if fruitViewModel.isLoading {
                    ProgressView()
                } else {
                    ForEach(fruitViewModel.fruitArray) { fruit in
                        HStack {
                            Text(fruit.name)
                                .font(.headline)
                                .bold()
                            Text("\(fruit.count)개")
                                .foregroundColor(.red)
                        }
                    }
                    .onDelete(perform: fruitViewModel.deleteItme)
                    .onMove(perform: fruitViewModel.moveItem)
                }
            }
            .navigationBarTitle("과일 리스트")
            .navigationBarItems(leading: EditButton(),
                                trailing: NavigationLink(
                                    destination: RandomScreenView(fruitViewModel: fruitViewModel),
                                    label: {
                                        Image(systemName: "arrowshape.turn.up.right.fill")
                                            .foregroundColor(.primary)
                                            .imageScale(.large)
                                    }))
            .listStyle(GroupedListStyle())
            //            .onAppear {
            //                fruitViewModel.getFruits()
            //            }
        }
    }
}

struct RandomScreenView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var fruitViewModel: FruitViewModel
    
    var body: some View {
        ZStack() {
            
            Color.yellow.ignoresSafeArea()
         
            VStack {
                
                Button(action:{
                    
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .padding(.bottom, 20)
                }
                
                if fruitViewModel.isLoading {
                    ProgressView()
                } else {
                    ForEach(fruitViewModel.fruitArray) { fruit in
                        Text(fruit.name)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ViewModel_Previews: PreviewProvider {
    static var previews: some View {
        ViewModel()
    }
}
