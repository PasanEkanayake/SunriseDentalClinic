package com.sunrise.dental.dao;

import com.sunrise.dental.model.Patient;
import com.sunrise.dental.util.DBConnection;

import java.sql.*;

public class PatientDAO {

    /**
     * Looks for an existing patient matched on name + contact number so a
     * returning patient's history stays under one record instead of being
     * duplicated (this is what fixes the clinic's "lost patient records"
     * problem). Returns null if no match is found.
     */
    public Patient findByNameAndContact(String name, String contact) throws SQLException {
        String sql = "SELECT * FROM patient WHERE patient_name = ? AND contact_number = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, contact);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    public Patient getById(int patientId) throws SQLException {
        String sql = "SELECT * FROM patient WHERE patient_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    /** Inserts a new patient and returns the generated patient_id. */
    public int insertPatient(Patient p, Connection con) throws SQLException {
        String sql = "INSERT INTO patient (patient_name, address, contact_number) VALUES (?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getPatientName());
            ps.setString(2, p.getAddress());
            ps.setString(3, p.getContactNumber());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        }
        throw new SQLException("Failed to insert patient, no ID obtained.");
    }

    public void updatePatient(Patient p) throws SQLException {
        String sql = "UPDATE patient SET patient_name = ?, address = ?, contact_number = ? WHERE patient_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getPatientName());
            ps.setString(2, p.getAddress());
            ps.setString(3, p.getContactNumber());
            ps.setInt(4, p.getPatientId());
            ps.executeUpdate();
        }
    }

    private Patient map(ResultSet rs) throws SQLException {
        Patient p = new Patient();
        p.setPatientId(rs.getInt("patient_id"));
        p.setPatientName(rs.getString("patient_name"));
        p.setAddress(rs.getString("address"));
        p.setContactNumber(rs.getString("contact_number"));
        return p;
    }
}
