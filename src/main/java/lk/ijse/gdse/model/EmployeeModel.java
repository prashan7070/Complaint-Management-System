package lk.ijse.gdse.model;

public class EmployeeModel {

    private int complaintId;
    private int empId;
    private String title;
    private String description;
    private String status;
    private String createdDate;
    private String updatedDate;
    private String remarks;


    public EmployeeModel() {
    }

    public EmployeeModel(int complaintId, int empId, String title, String description, String status, String createdDate, String updatedDate, String remarks) {
        this.complaintId = complaintId;
        this.empId = empId;
        this.title = title;
        this.description = description;
        this.status = status;
        this.createdDate = createdDate;
        this.updatedDate = updatedDate;
        this.remarks = remarks;
    }




    public int getComplaintId() {
        return complaintId;
    }

    public void setComplaintId(int complaintId) {
        this.complaintId = complaintId;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(String updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }


}
