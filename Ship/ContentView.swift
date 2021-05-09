// MARK: ContentView.swift
/**
 SOURCE :
 https://www.hackingwithswift.com/books/ios-swiftui/filtering-fetchrequest-using-nspredicate
 
 When we use SwiftUI’s `@FetchRequest` property wrapper ,
 we can provide an array of sort descriptors
 to control the ordering of results ,
 but we can also provide an `NSPredicate`
 to control which results should be shown .
 Predicates are simple tests ,
 and the test will be applied to each object in our Core Data entity
 — only objects that pass the test
 will be included in the resulting array .
 */

import SwiftUI
import CoreData



struct ContentView: View {
    
     // ////////////////////////
    //  MARK: PROPERTY WRAPPERS
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity : Ship.entity() ,
                  sortDescriptors : [] ,
                  // Ask for ships that are from Star Wars :
                  // predicate : NSPredicate(format : "universe == 'Star Wars'")
                  /**
                  That gets complicated if your data includes quote marks ,
                  so it is more common to use special syntax instead :
                  `%@` means _insert some data here_ ,
                  and allows us to provide that data as a parameter to the predicate
                  rather than inline .
                  */
                  // predicate : NSPredicate(format: "universe == %@", "Star Wars")
                  /**
                  As well as `==` ,
                  we can also use comparisons such as `<` and `>`
                  to filter our objects .
                  For example
                  this will return _Defiant, Enterprise, and Executor_ :
                  */
                  // predicate : NSPredicate(format: "name < %@" , "F")
                  /**
                  We could use an `IN` predicate
                  to check whether the universe is one of three options from an array ,
                  like this :
                  */
                  // predicate : NSPredicate(format: "universe IN %@" , ["Aliens" , "Firefly" , "Star Trek"])
                  /**
                  We can also use predicates
                  to examine part of a string ,
                  using operators such as `BEGINSWITH` and `CONTAINS` .
                  For example , this will return all ships that start with a capital `E` :
                  */
                  // predicate : NSPredicate(format: "name BEGINSWITH %@" , "E")
                  /**
                  That predicate is case-sensitive ;
                  if you want to ignore case
                  you need to modify it to this :
                  */
                  // predicate : NSPredicate(format : "name BEGINSWITH[c] %@" , "e")
                  /**
                  `CONTAINS[c]` works similarly ,
                  except rather than starting with your substring
                  it can be anywhere inside the attribute :
                  */
                  // predicate : NSPredicate(format : "name CONTAINS[c] %@" , "e")
                  /**
                  Finally ,
                  you can flip predicates around using `NOT` ,
                  to get the inverse of their regular behavior .
                  For example ,
                  this finds all ships that _don’t start_ with an `E` :
                  */
                  predicate : NSPredicate(format : "NOT name BEGINSWITH[c] %@" , "e")
                  /**
                  If you need more complicated predicates ,
                  join them using `AND`
                  to build up as much precision as you need ,
                  or add an import for Core Data
                  and take a look at `NSCompoundPredicate`
                  — it lets you build one predicate out of several smaller ones .
                  */
    ) var ships: FetchedResults<Ship>
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var body: some View {
        
        VStack {
            List {
                ForEach(ships , id : \.self) { (ship: Ship) in
                    Text(ship.name ?? "N/A")
                }
            }
            Button("Create ships") {
                let ship1 = Ship(context : managedObjectContext)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context : managedObjectContext)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context : managedObjectContext)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context : managedObjectContext)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? managedObjectContext.save()
            }
            .padding()
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
    }
}
