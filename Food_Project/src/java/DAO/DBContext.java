/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DBContext {
    
    /*USE BELOW METHOD FOR YOUR DATABASE CONNECTION FOR BOTH SINGLE AND MULTILPE SQL SERVER INSTANCE(s)*/
    /*DO NOT EDIT THE BELOW METHOD, YOU MUST USE ONLY THIS ONE FOR YOUR DATABASE CONNECTION*/
     public Connection getConnection()throws Exception {        
        String url = "jdbc:sqlserver://"+serverName+":"+portNumber +
                ";databaseName="+dbName +
                ";encrypt=true;trustServerCertificate=true;";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");         
        return DriverManager.getConnection(url, userID, password);
//        return DriverManager.getConnection(url);
    }
    
    /**
     * Checks if a connection to the database can be established using the current settings.
     * Prints error details to the console if connection fails.
     *
     * @return true if the connection is successful, false otherwise.
     */
    public static boolean checkConnection() {
        Connection conn = null;
        try {
            DBContext dbContext = new DBContext(); // Create instance to use its getConnection
            System.out.println("Attempting to connect using configured settings...");
            conn = dbContext.getConnection();
            System.out.println("Database connection successful!");
            return true;
        } catch (Exception e) {
            System.err.println("Error: Could not connect to the database.");
            System.err.println("Server: " + new DBContext().serverName); // Show server name from config
            System.err.println("Database: " + new DBContext().dbName);   // Show db name from config
            System.err.println("Port: " + new DBContext().portNumber);     // Show port from config
            System.err.println("User: " + new DBContext().userID);       // Show user from config
            System.err.println("Exception Type: " + e.getClass().getName());
            System.err.println("Message: " + e.getMessage());
            // e.printStackTrace(); // Uncomment for full stack trace if needed
            return false;
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    System.out.println("Database connection closed after check.");
                } catch (SQLException e) {
                    System.err.println("Error closing the database connection after check.");
                    // e.printStackTrace(); // Uncomment for full stack trace if needed
                }
            }
        }
    }

    /*Insert your other code right after this comment*/

    // Example usage (can be run directly)
    public static void main(String[] args) {
        System.out.println("--- Running Database Connection Check ---");
        if (DBContext.checkConnection()) {
            System.out.println("Result: Connection Check PASSED");
        } else {
            System.out.println("Result: Connection Check FAILED");
        }
        System.out.println("----------------------------------------");
    }

    /*Change/update information of your database connection, DO NOT change name of instance variables in this class*/
    private final String serverName = "QUYDAM\\QUYDAM";
    private final String dbName = "dbN3";
    private final String portNumber = "1433";
    private final String userID = "sa";
    private final String password = "12345";
}
