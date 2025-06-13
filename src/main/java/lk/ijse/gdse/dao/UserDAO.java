package lk.ijse.gdse.dao;

import lk.ijse.gdse.model.UserModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    private DataSource dataSource;

    public UserDAO(DataSource dataSource) {
        this.dataSource = dataSource;
    }


    public int saveUser(UserModel userModel) throws SQLException {

        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(
                "INSERT INTO users (full_name , username, password, role) VALUES (?, ?, ?, ?)");

        preparedStatement.setString(1,userModel.getName());
        preparedStatement.setString(2, userModel.getUsername());
        preparedStatement.setString(3, userModel.getPassword());
        preparedStatement.setString(4, userModel.getRole());

        return preparedStatement.executeUpdate();

    }





}
