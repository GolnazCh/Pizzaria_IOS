//
//  ContentView.swift
//  Golnaz_Pizza
//
//  Created by Golnaz Chehrazi on 2023-06-05.
//

import SwiftUI

struct ContentView: View {
    
    @State private var linkSelction : Int? = nil
    @State private var typeFromUI : Int = 1
    @State private var sizeFromUI : Int = 1
    @State private var quantityFromUI : Int = 1
    @State private var customerNameFromUI : String = ""
    @State private var phoneNumberFromUI : String = ""
    @State private var couponCodeFromUI : String = ""
    @State private var errorMsg : String? = nil
    private var newOrder: PizzaOrder = PizzaOrder()
    
    var body: some View {
        
        // Mark: Navigation View
        NavigationView{
            VStack(spacing:20){
                
                // MARK: Navigation Link
                NavigationLink(destination: UserReceipt().environmentObject(self.newOrder), tag: 1, selection: self.$linkSelction){}
                
                // MARK: showing an image of pizza
                Image("pizza-g90519f17b_640")
                    .resizable()
                    .frame(width:350, height:200)
                    .border(Color.gray, width:1.0)
                
                Text("Customize Your Order").bold().foregroundColor(Color.green).font(.title)
                
                // MARK: showing the error msg if we have any error
                if let msg = errorMsg{
                    Text("Error: \(msg)").foregroundColor(Color.red).bold()
                }
                
                // MARK:select the type
                HStack{
                    Picker("", selection: self.$typeFromUI ){
                        Text("Vegetarian").tag(0)
                        Text("Non-Vegetarian").tag(1)
                    }.pickerStyle(.segmented)
                }
                
                // MARK: select the size
                HStack{
                    Text("Size:")
                    Spacer()
                    Picker("", selection: self.$sizeFromUI ){
                        Text("small").tag(0)
                        Text("medium").tag(1)
                        Text("large").tag(2)
                    }
                }
                
                // MARK: select the Quantity
                Stepper("Quantity: \(quantityFromUI)", value:$quantityFromUI, in:1...5)
                
                // MARK: enetering name, phone number and coupon code
                Group{
                    TextField("Enter your name", text: self.$customerNameFromUI).textFieldStyle(.roundedBorder).keyboardType(.namePhonePad).autocorrectionDisabled(true)
                    TextField("Enter a phone number", text: self.$phoneNumberFromUI).textFieldStyle(.roundedBorder).keyboardType(.phonePad)
                    TextField("Coupon Code", text: self.$couponCodeFromUI).textFieldStyle(.roundedBorder)
                }
                
                // MARK: Place order
                Button(action:{
                    
                    // MARK: check from Validation
                    if(!checkFromValidation()){
                        return
                    }
                    
                    placeOrder()
                    errorMsg = nil
                    self.linkSelction = 1
                    
                }){
                    Image(systemName: "fork.knife.circle").resizable()
                        .frame(width: 32, height: 32).foregroundColor(Color.white)
                    Text("Place Order").bold()
                }.buttonStyle(.borderedProminent)
                
                Spacer()
            }//VSatck
            .padding()
            .navigationTitle(Text("GHAA Pizzeria"))
            // MARK: toolbar with 2 buttons for Reset and Daily Special
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    HStack{
                        Button("Daily Special", action:{
                            dailySpecialSettings()
                        }).buttonStyle(.bordered)
                        
                        // MARK: Reset Button
                        Button("Reset", action:{
                            resetForm()
                        }).buttonStyle(.bordered)
                    }//HStack
                }//ToolbarItem
            }//Toolbar
        }//Navigation View
    }//body
    
    // Mark: Function for Reseting the form
    func resetForm(){
        self.sizeFromUI = 1
        self.quantityFromUI = 1
        self.typeFromUI = 1
        self.errorMsg = nil
        self.couponCodeFromUI = ""
        self.customerNameFromUI = ""
        self.phoneNumberFromUI = ""
    }
    
    // MARK: function for setting daily special
    func dailySpecialSettings(){
        self.sizeFromUI = 2
        self.quantityFromUI = 2
        self.typeFromUI = 1
    }
    
    // MARK: function for cheking form validation
    func checkFromValidation() -> Bool{
        // MARK: check for phone number, Phone number in mandatory
        if(self.phoneNumberFromUI.isEmpty){
            self.errorMsg = "Enter a phone number!!!"
            return false
        }
        
        // MARK: check the coupon code 1. is privided or not 2. if provided, is valid or not
        if(!self.couponCodeFromUI.isEmpty && !self.couponCodeFromUI.lowercased().hasPrefix("offer"))
        {
            self.couponCodeFromUI = ""
            self.errorMsg = "Invalid Coupon Code!!!"
            return false
        }
        return true
    }
    
    // MARK: function for placing an order
    func placeOrder(){
        self.newOrder.customerInfo.0 = self.customerNameFromUI
        self.newOrder.customerInfo.1 =  self.phoneNumberFromUI
        self.newOrder.pizzaSize  = self.sizeFromUI
        self.newOrder.pizzaType =  self.typeFromUI
        self.newOrder.quantity = self.quantityFromUI
        self.newOrder.couponApplied = !self.couponCodeFromUI.isEmpty
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
