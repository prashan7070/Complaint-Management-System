package lk.ijse.gdse.dao;

import lk.ijse.gdse.model.EmployeeModel;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {


    private DataSource dataSource;

    public AdminDAO(DataSource dataSource){
        this.dataSource = dataSource;
    }


    public int updateComplainByAdmin(EmployeeModel employeeModel) throws SQLException {


        Connection connection = dataSource.getConnection();
        PreparedStatement pstm = connection.prepareStatement("UPDATE complaints SET status = ?, remark = ? WHERE complaint_id = ?");

        pstm.setString(1,employeeModel.getStatus());
        pstm.setString(2,employeeModel.getRemarks());
        pstm.setInt(3,employeeModel.getComplaintId());

        return pstm.executeUpdate();


    }

    public int deleteComplaint(String complainId) throws SQLException {

        Connection connection = dataSource.getConnection();
        PreparedStatement pstm = connection.prepareStatement("DELETE FROM complaints WHERE complaint_id = ?");
        pstm.setInt(1, Integer.parseInt(complainId));
        return pstm.executeUpdate();

    }


    public List<EmployeeModel> getAllComplains() throws SQLException {

        List<EmployeeModel> employeeList = new ArrayList<>();
        Connection connection = dataSource.getConnection();
        PreparedStatement pstm = connection.prepareStatement("SELECT * FROM complaints");
        ResultSet rs = pstm.executeQuery();

        while (rs.next()){

            EmployeeModel employeeModel = new EmployeeModel();
            employeeModel.setComplaintId(rs.getInt("complaint_id"));
            employeeModel.setEmpId(rs.getInt("user_id"));
            employeeModel.setTitle(rs.getString("title"));
            employeeModel.setDescription(rs.getString("description"));
            employeeModel.setStatus(rs.getString("status"));
            employeeModel.setCreatedDate(rs.getString("created_at"));
            employeeModel.setUpdatedDate(rs.getString("updated_at"));
            employeeModel.setRemarks(rs.getString("remark"));

            employeeList.add(employeeModel);

        }

        return employeeList;


    }

    public int[] getCountData() throws SQLException {

        Connection connection = dataSource.getConnection();

        PreparedStatement pstm = connection.prepareStatement("SELECT status, COUNT(*) AS count\n" +
                "FROM complaints\n" +
                "GROUP BY status;\n");

        ResultSet rs = pstm.executeQuery();

        int pending = 0, in_progress = 0 , resolved = 0;

        while (rs.next()){

            String status = rs.getString("status");
            int count = rs.getInt("count");

            switch (status){
                case "PENDING" -> pending = count;
                case "IN_PROGRESS" -> in_progress = count;
                case "RESOLVED" -> resolved = count;
            }

        }

        int total = pending + in_progress + resolved;

        return new int[]{total , pending , in_progress ,resolved};

    }



}
