import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

#if DEBUG
let debugmode = true
#else
let debugmode = false
#endif
public func configure(_ app: Application) throws {
    
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? secrets.dbAddr,
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? secrets.dbUserName,
        password: Environment.get("DATABASE_PASSWORD") ?? secrets.dbPasswd,
        database: Environment.get("DATABASE_NAME") ?? secrets.dbName
    ), as: .psql)

    app.migrations.add(CreateTodo())

    app.views.use(.leaf)
    
    let publicDirectory = DirectoryConfiguration.detect().publicDirectory
    let cssFilePath = publicDirectory.appending("index.css")
    let cssFileURL = URL(fileURLWithPath: cssFilePath)
    let absolutePath = cssFileURL.absoluteString


    // register routes
    try routes(app)
}
