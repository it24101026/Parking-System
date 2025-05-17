package lk.sliit.parkingsystem.parkingsystem.model;

public class Admin extends User {
    public Admin(String username, String password, String fullName, String contact) {
        super(username, password, fullName, contact, "admin");
    }

    // For loading existing admins
    public Admin(String id, String username, String password, String fullName, String contact) {
        super(id, username, password, fullName, contact, "admin");
    }
}