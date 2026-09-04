package com.sunrise.dental.dao;

import com.sunrise.dental.model.Dentist;
import com.sunrise.dental.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DentistDAO {

    /** Every dentist, active and inactive - for the Manage Dentists admin screen and for editing past appointments. */
    public List<Dentist> getAllDentists() throws SQLException {
        List<Dentist> list = new ArrayList<>();
        String sql = "SELECT * FROM dentist ORDER BY dentist_name";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    /** Only active dentists - used on the "Register New Appointment" form so a
     *  deactivated dentist can't be booked for a new visit. */
    public List<Dentist> getAllActiveDentists() throws SQLException {
        List<Dentist> list = new ArrayList<>();
        String sql = "SELECT * FROM dentist WHERE is_active = 1 ORDER BY dentist_name";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    public Dentist getById(int dentistId) throws SQLException {
        String sql = "SELECT * FROM dentist WHERE dentist_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, dentistId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    /** Adds a new dentist (Admin-only). */
    public void insertDentist(String name, String specialization, String contactNumber) throws SQLException {
        String sql = "INSERT INTO dentist (dentist_name, specialization, contact_number) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, specialization);
            ps.setString(3, contactNumber);
            ps.executeUpdate();
        }
    }

    /** Activates or deactivates a dentist without deleting their row/appointment history. */
    public void setActive(int dentistId, boolean active) throws SQLException {
        String sql = "UPDATE dentist SET is_active = ? WHERE dentist_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, active);
            ps.setInt(2, dentistId);
            ps.executeUpdate();
        }
    }

    private Dentist map(ResultSet rs) throws SQLException {
        Dentist d = new Dentist();
        d.setDentistId(rs.getInt("dentist_id"));
        d.setDentistName(rs.getString("dentist_name"));
        d.setSpecialization(rs.getString("specialization"));
        d.setContactNumber(rs.getString("contact_number"));
        d.setActive(rs.getBoolean("is_active"));
        return d;
    }
}
