# Epargn_Plus

Epargn_Plus is a Java application for managing financial contributions. The application allows users to create and manage accounts, record contributions, and generate reports.

## Features

- Create and manage accounts for multiple users
- Record financial contributions for each account
- Generate reports to track contributions and account balances

## Requirements

- Java 8 or higher
- MySQL 5.7 or higher

## Installation

1. Clone the repository to your local machine.
2. Create a MySQL database for the application.
3. Import the database schema from the `database` directory.
4. Edit the `application.properties` file in the `src/main/resources` directory to configure your database connection.
5. Run the application using your preferred Java development environment (e.g., Eclipse, IntelliJ IDEA).
6. if you are running the application on netbean you will build the .war file.
7. Configure (create) the jdbc driver for this app by going to JDBC, then JDBC resources and then new (this is in the glassfish server admin console). You can now enter the name for the new jdbc (eg jdbc/[choosen name]).
8. Deploy the.war file in the GlassFish server and view it.

## Usage

1. Launch the application.
2. Create a new account for each user.
3. Record financial contributions for each account.
4. Generate reports to track contributions and account balances.

## Contributing

Contributions to Epargn_Plus are welcome! If you'd like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Commit your changes to the new branch.
4. Create a pull request.

## Credits

Epargn_Plus was created by [Your Name], [Your Email], [Your Github].

## License

Epargn_Plus is released under the [MIT License](https://opensource.org/licenses/MIT).
