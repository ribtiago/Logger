# LoggerKit

This LoggerKit swift package simplifies the use of Apple's OSLog and works as an aggregator for other frameworks.

## Getting Started

To start using LoggerKit, just add the Swift Package to the project and you're ready to start.

### Carthage

TODO: Do carthage

## Best practices

In general, we should:
- Think critically about what we log and whether that log message is really required to debug in production
- Log as little information as is possible while still facilitating client debugging (i.e. stick to text instead of full objects)

Under absolutely no circumstances should we ever log:
- Any personal data (firstnames, surnames, phone number, email address etc.)
- Any technical data that may uniquely identify a user (IMEI, cifId, IBAN, ip address etc.)
- Full objects (as this can contain sensitive data)
- Arbitrary API responses (these are sure to contain personal data)

Note: Even in testing it is forbidden to log any of the above data - forgetting to remove a line of code could potentially result in a data breach and result in fines and sanctions for our clients.

## Severity levels

Logger supports five severity levels: Debug, Verbose, Info, Warning and Error.

#### Debug

Never saved, only appears in the console. Very granular, contains the most detail. Will include params, model attributes etc. Considered audience is developers only.

#### Verbose

Very similar to Info. Verbose should be used over Info when the event is not considered a major event, it can also be viewed as an event that is more useful for a developer/tester i.e endpoint with headers etc.

#### Info

Normal logging that’s part of the general operation/flow of the app. Something happened but it’s trivial. Consider the audience to be non technical. For example; button clicked, new user created, new payment, payment status change etc.

#### Warning

Something thats concerning but not causing the app to stop working. By analysing warning logs, we should get a good picture of the health/performance of the app etc. Examples include, network retry attempts, timeouts etc.

#### Error

Error occurred but it was recoverable. App won’t crash but fix should be high priority.

#### Info v Debug/Verbose

It’s difficult to distinguish between Info and Debug/Verbose. A general rule of thumb is to use a debug/verbose if a message contains some dynamic data i.e the developer/tester will more than likely be interested in this. On the other hand use info if it is plain text.

In most cases an action/event will begin with an info log, describing the event and be followed with a verbose log detailing how its being done.


Example: Financial cards app creating a physical card
```
[Cards] INFO: Creating physical card
[Networking] VERBOSE: Request: (POST) https://api.com/card -> Body: User(name: John Doe)
[Networking] DEBUG: Headers: Authorization: Bearer Itul6OhXwiJzO
[Networking] VERBOSE: Response: (200) -> Card(id: 123, name: John Doe)
[Cards] INFO: Physical card created.
```
Note: This is an illustrative example only. Response data and tokens etc. should not be logged.

### OSLog mapping

Apple's OSLog severity levels are a bit different than the usual.
Below is a table with the mapping in the Logger:

Logger  | OSLog
------- | -----:
debug   | debug
verbose | info
info    | default
warning | error
error   | fault

## Usage

### Importing

Import the LoggerKit into your AppDelegate file.

```
import LoggerKit
```

Hint: to make Logger available throughout your files without importing it everywhere, use typealias and rename Logger to AppLogger. Start using AppLogger everywhere 👌🏼

```
typealias AppLogger = Logger
```

### Logging

To quickly start logging a certain severity level, just use the default category like the examples below.

#### Debug

```
Logger.default.debug("Your debug message here.")
```

#### Verbose

```
Logger.default.verbose("Your verbose message here.")
```

#### Info

```
Logger.default.info("Your info message here.")
```

#### Warning

```
Logger.default.warning("Your warning message here.")
```

#### Error

```
Logger.default.error("Your error message here.")
```

### Categories

In Logger categories require a new logger instance.
Out of the box, Logger supports the `default` category by using `Logger.default`.

To create a new Logger with a category for `ui` you can do:

```
let uiLogger = Logger(category: "ui")
```

Instead of creating a categorized logger every time it's needed and to simplify the access throughout the app, you can extend the Logger with a static variable. Example:

```
extension Logger {

  static let ui = Logger(category: "ui")
}
```

You'll now be able to access it by using `Logger.ui`

### Logging Entities

A logging entity is defined by the protocol `LoggingEntity` and allows the usage of external logger frameworks by registering them into the Logger.

There are usually two types of loggers in the most common logging frameworks. One is a static method based logger, that uses class static methods to log. The other one is a class based logger, that uses object methods to log.

#### Registering a static method logger

To support this type of loggers, we should wrap their logic into a wrapper that implements `LoggingEntity`.

```
struct StaticExternalLoggerWrapperEntity: LoggingEntity {

  // this is optional: create an init that configures the logger.
  init(apiKey: String) {
    StaticExternalLogger.register(apiKey: apiKey)
  }

  func debug(_ log: String) {
    StaticExternalLogger.debug(message: log)
  }

  func verbose(_ log: String) {
    StaticExternalLogger.verbose(message: log)
  }

  func info(_ log: String) {
    StaticExternalLogger.info(message: log)
  }

  func warning(_ log: String) {
    StaticExternalLogger.warning(message: log)
  }

  func error(_ log: String) {
    StaticExternalLogger.error(message: log)
  }
}
```

Note that the wrapper should also handle categories appropriately depending on the logger's definition of category.

We can now register the logger as a `LoggingEntity` of our Logger:

```
let externalLogger = StaticExternalLoggerWrapperEntity(apiKey: "API_KEY")
Logger.default.registerEntity(externalLogger)
```

#### Registering a class based logger

This can be supported using the same approach as above, but can also be supported by extending the original class and making it conform with `LoggingEntity`.

```
extension ClassExternalLogger: LoggingEntity {

  public func debug(_ log: String) {
    self.d(log)
  }

  public func verbose(_ log: String) {
    self.v(log)
  }

  public func info(_ log: String) {
    self.i(log)
  }

  public func warning(_ log: String) {
    self.w(log)
  }

  public func error(_ log: String) {
    self.e(log)
  }
}
```

Note that the example above uses different naming for each severity (e.g.: `debug` is `d`). If the logger uses the exact same names and parameters, all it has to be done is:

```
extension ClassExternalLogger: LoggingEntity { }
```

We register the logger as a `LoggingEntity` the same way:

```
// Initialization of the logger. Add any necessary steps
let externalLogger = ClassExternalLogger()
Logger.default.registerEntity(externalLogger)
```

Note that the loggers have to be register for all the categories you have.
Example:
```
extension Logger {

  static let ui = Logger(category: "ui")

  static let networking = Logger(category: "networking")
}

// ...

func setupLoggers() {

  // ui category
  let uiStaticExternalLogger = StaticExternalLoggerWrapperEntity(apiKey: "API_KEY_FOR_UI_CATEGORY")

  let uiClassExternalLogger = ClassExternalLogger()
  uiClassExternalLogger.setCategoryName("ui")

  Logger.ui.registerEntities([uiStaticExternalLogger, uiClassExternalLogger])

  // service category
  let serviceStaticExternalLogger = StaticExternalLoggerWrapperEntity(apiKey: "API_KEY_FOR_SERVICE_CATEGORY")

  let serviceClassExternalLogger = ClassExternalLogger()
  serviceClassExternalLogger.setCategoryName("service")

  Logger.ui.registerEntities([serviceStaticExternalLogger, serviceClassExternalLogger])
}
```
