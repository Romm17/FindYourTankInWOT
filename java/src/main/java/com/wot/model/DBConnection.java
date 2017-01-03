package com.wot.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Created by romm on 03.01.17.
 */
public class DBConnection {

    public static Connection dbConnect() {
        Connection c;
        try {
            Class.forName("org.sqlite.JDBC");
            c = DriverManager.getConnection("jdbc:sqlite:model.sqlite");
        } catch ( Exception e ) {
            throw new RuntimeException("Connection couldn't be established!\n" + e);
        }
        return c;
    }

    public static void dbDisconnect(Connection connection) {
        try {
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException("Connection couldn't be closed!\n" + e);
        }
    }

}
