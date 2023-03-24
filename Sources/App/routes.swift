import Fluent
import Vapor


func routes(_ app: Application) throws {
    app.get { req async throws in
        
        try await req.view.render("index", ["DEBUG": debugmode])
    }
    
    app.get("render") { req -> EventLoopFuture<View> in
        let responce = try homePageContentHandler(req)
      
        return req.view.render("index", responce)
    }
    

    try app.register(collection: TodoController())
}

func homePageContentHandler(_ req: Request) throws -> HomePageContent {
    
    return HomePageContent(
        title: "Welcome to My Website",
        subtitle: "This is a demo website created with Vapor and Leaf",
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        
    )
}
