package lk.ijse.gdse.dao;

import lk.ijse.gdse.model.EmployeeModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

public class EmployeeDAO {

    private DataSource dataSource;

    public EmployeeDAO(DataSource dataSource){

        this.dataSource = dataSource;

    }


    public int saveComplain(EmployeeModel employeeModel) throws SQLException {

        Connection connection = dataSource.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(
                "INSERT INTO complaints (user_id , title, description ) VALUES (?, ?, ?)");

        preparedStatement.setInt(1,employeeModel.getEmpId());
        preparedStatement.setString(2,employeeModel.getTitle());
        preparedStatement.setString(3,employeeModel.getDescription());

        return preparedStatement.executeUpdate();


    }


    public ArrayList<EmployeeModel> getComplains(){






    }





}
