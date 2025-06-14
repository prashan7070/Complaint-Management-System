package lk.ijse.gdse.dao;

import lk.ijse.gdse.model.EmployeeModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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


    public List<EmployeeModel> getAllComplains(int id){

        List<EmployeeModel> employeeList = new ArrayList<>();




    }




    public int updateComplain(EmployeeModel employeeModel) throws SQLException {

            Connection connection = dataSource.getConnection();
            PreparedStatement pstm = connection.prepareStatement("UPDATE complaints SET title = ?, description = ? WHERE complaint_id = ? AND user_id = ?");
            pstm.setString(1,employeeModel.getTitle());
            pstm.setString(2,employeeModel.getDescription());
            pstm.setInt(3,employeeModel.getComplaintId());
            pstm.setInt(4,employeeModel.getEmpId());

            return pstm.executeUpdate();


    }



    public int deleteComplain(int complaintId) throws SQLException {


        Connection connection = dataSource.getConnection();
        PreparedStatement pstm = connection.prepareStatement("DELETE FROM complaints WHERE complaint_id = ?");
        pstm.setInt(1,complaintId);
        return pstm.executeUpdate();


    }




}
