package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL =
            "jdbc:mysql://localhost:3306/ServletCRUDMVC"
          + "?useUnicode=true"
          + "&characterEncoding=UTF-8"
          + "&serverTimezone=Asia/Ho_Chi_Minh"
          + "&useSSL=false"
          + "&allowPublicKeyRetrieval=true";

    private static final String USER = "root";
    private static final String PASSWORD = "Khanh12345@";

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
