package com.sunrise.dental.dao;

import com.sunrise.dental.model.Staff;
import com.sunrise.dental.util.DBConnection;
import com.sunrise.dental.util.PasswordUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    /**
     * Returns the Staff record if username/password match AND the account
     * is active, otherwise null. Deactivated staff (see Admin > Manage
     * Staff) are blocked from logging in here, even with correct credentials.
     */
    public Staff authenticate(String username, String plainPassword) throws SQLException {
        String sql = "SELECT staff_id, username, full_name, role FROM staff " +
                "WHERE username = ? AND password = ? AND is_active = 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, PasswordUtil.hash(plainPassword));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Staff(
                            rs.getInt("staff_id"),
                            rs.getString("username"),
                            rs.getString("full_name"),
                            rs.getString("role"));
                }
            }
        }
        return null;
    }

    /** Every staff account, active and inactive, for the Manage Staff admin screen. */
    public List<Staff> getAllStaff() throws SQLException {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT * FROM staff ORDER BY full_name";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    public Staff getById(int staffId) throws SQLException {
        String sql = "SELECT * FROM staff WHERE staff_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    /**
     * Creates a new staff login (Admin-only). The username's uniqueness is
     * enforced by the database's UNIQUE constraint - callers should catch
     * SQLIntegrityConstraintViolationException for a friendly "already taken" message.
     */
    public void insertStaff(String username, String plainPassword, String fullName, String role) throws SQLException {
        String sql = "INSERT INTO staff (username, password, full_name, role) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, PasswordUtil.hash(plainPassword));
            ps.setString(3, fullName);
            ps.setString(4, role);
            ps.executeUpdate();
        }
    }

    /** Activates or deactivates a staff login without deleting their row/history. */
    public void setActive(int staffId, boolean active) throws SQLException {
        String sql = "UPDATE staff SET is_active = ? WHERE staff_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, active);
            ps.setInt(2, staffId);
            ps.executeUpdate();
        }
    }

    private Staff map(ResultSet rs) throws SQLException {
        Staff s = new Staff();
        s.setStaffId(rs.getInt("staff_id"));
        s.setUsername(rs.getString("username"));
        s.setFullName(rs.getString("full_name"));
        s.setRole(rs.getString("role"));
        s.setActive(rs.getBoolean("is_active"));
        s.setCreatedAt(rs.getTimestamp("created_at"));
        return s;
    }
}
