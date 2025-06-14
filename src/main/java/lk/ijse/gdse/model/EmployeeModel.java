package lk.ijse.gdse.model;

public class EmployeeModel {

    private int empId;
    private String title;
    private String description;

    public EmployeeModel() {
    }

    public EmployeeModel(int empId, String title, String description) {
        this.empId = empId;
        this.title = title;
        this.description = description;
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



}
