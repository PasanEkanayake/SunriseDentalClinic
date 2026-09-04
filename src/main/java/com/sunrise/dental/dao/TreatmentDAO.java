package com.sunrise.dental.dao;

import com.sunrise.dental.model.TreatmentType;
import com.sunrise.dental.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TreatmentDAO {

    /** Every treatment type, active and inactive - for the Manage Treatments admin screen and for editing past appointments. */
    public List<TreatmentType> getAllTreatments() throws SQLException {
        List<TreatmentType> list = new ArrayList<>();
        String sql = "SELECT * FROM treatment_type ORDER BY treatment_name";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    /** Only active treatment types - used on the "Register New Appointment" form so a
     *  retired treatment can't be booked for a new visit. */
    public List<TreatmentType> getAllActiveTreatments() throws SQLException {
        List<TreatmentType> list = new ArrayList<>();
        String sql = "SELECT * FROM treatment_type WHERE is_active = 1 ORDER BY treatment_name";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    public TreatmentType getById(int treatmentId) throws SQLException {
        String sql = "SELECT * FROM treatment_type WHERE treatment_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, treatmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    /** Adds a new treatment type (Admin-only). */
    public void insertTreatment(String name, BigDecimal cost) throws SQLException {
        String sql = "INSERT INTO treatment_type (treatment_name, cost) VALUES (?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setBigDecimal(2, cost);
            ps.executeUpdate();
        }
    }

    /** Activates or deactivates a treatment type without deleting its row/appointment history. */
    public void setActive(int treatmentId, boolean active) throws SQLException {
        String sql = "UPDATE treatment_type SET is_active = ? WHERE treatment_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, active);
            ps.setInt(2, treatmentId);
            ps.executeUpdate();
        }
    }

    private TreatmentType map(ResultSet rs) throws SQLException {
        TreatmentType t = new TreatmentType();
        t.setTreatmentId(rs.getInt("treatment_id"));
        t.setTreatmentName(rs.getString("treatment_name"));
        t.setCost(rs.getBigDecimal("cost"));
        t.setActive(rs.getBoolean("is_active"));
        return t;
    }
}
