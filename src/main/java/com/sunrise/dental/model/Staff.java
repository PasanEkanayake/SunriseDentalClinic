package com.sunrise.dental.model;

import java.sql.Timestamp;

public class Staff {
    private int staffId;
    private String username;
    private String password; // hashed
    private String fullName;
    private String role; // ADMIN or RECEPTIONIST
    private boolean active = true;
    private Timestamp createdAt;

    public Staff() {}

    public Staff(int staffId, String username, String fullName, String role) {
        this.staffId = staffId;
        this.username = username;
        this.fullName = fullName;
        this.role = role;
    }

    public int getStaffId() { return staffId; }
    public void setStaffId(int staffId) { this.staffId = staffId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public boolean isAdmin() { return "ADMIN".equalsIgnoreCase(role); }
}
