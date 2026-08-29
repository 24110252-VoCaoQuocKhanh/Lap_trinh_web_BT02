package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public Connection getConnection() throws Exception {
        String url = "jdbc:mysql://localhost:3306/ServletCRUDMVC?useUnicode=true&characterEncoding=UTF-8";
        String user = "root";
        String password = "Khanh12345@";
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, password);
    }
}