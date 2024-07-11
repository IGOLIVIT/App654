//
//  ParticipantsView.swift
//  App654
//
//  Created by IGOR on 01/07/2024.
//

import SwiftUI

struct ParticipantsView: View {

    @StateObject var viewModel = ParticipantsViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Participants")
                    .foregroundColor(.white)
                    .font(.system(size: 29, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                
                if viewModel.participantss.isEmpty {
                    
                    VStack(spacing: 20) {
                        
                        Text("Empty")
                            .foregroundColor(.white)
                            .font(.system(size: 28, weight: .medium))
                        
                        Text("Add a participants, click +")
                            .foregroundColor(.white.opacity(0.6))
                            .font(.system(size: 15, weight: .regular))
                        
                    }
                    .frame(maxHeight: .infinity)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            
                            ForEach(viewModel.participantss, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedParticipant = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                    }
                                    
                                }, label: {
                                    
                                    VStack(spacing: 7) {
                                        
                                        Image(index.parPhoto ?? "")
                                            .resizable()
                                            .frame(width: 70, height: 70)
                                        
                                        Text(index.parName ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 18, weight: .medium))
                                        
                                        Text(index.parSpec ?? "")
                                            .foregroundColor(.white.opacity(0.4))
                                            .font(.system(size: 13, weight: .regular))
                                        
                                        Text(index.parStatus ?? "")
                                            .foregroundColor(Color("bg"))
                                            .font(.system(size: 12, weight: .regular))
                                            .padding(4)
                                            .padding(.horizontal, 5)
                                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                                })
                            }
                        })
                    }
                }
                
            }
            .padding()
            
            VStack {
                
                Spacer()
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                }, label: {
                    
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .regular))
                        .padding()
                        .background(Circle().fill(Color("prim")))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
        }
        .onAppear{
            
            viewModel.fetchParticipants()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddParticipant(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            PartDetail(viewModel: viewModel)
        })
    }
}

#Preview {
    ParticipantsView()
}
