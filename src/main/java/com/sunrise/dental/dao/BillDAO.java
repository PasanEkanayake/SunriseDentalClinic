package com.sunrise.dental.dao;

import com.sunrise.dental.model.Bill;
import com.sunrise.dental.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;

public class BillDAO {

    /** Returns the existing bill for an appointment, or null if none has been generated yet. */
    public Bill getByAppointmentId(int appointmentId) throws SQLException {
        String sql = "SELECT b.*, a.appointment_no, p.patient_name, d.dentist_name, t.treatment_name " +
                "FROM bill b " +
                "JOIN appointment a ON b.appointment_id = a.appointment_id " +
                "JOIN patient p ON a.patient_id = p.patient_id " +
                "JOIN dentist d ON a.dentist_id = d.dentist_id " +
                "JOIN treatment_type t ON a.treatment_id = t.treatment_id " +
                "WHERE b.appointment_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, appointmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    /**
     * Calculates and stores a new bill: total = consultation fee + treatment cost.
     */
    public Bill generateBill(int appointmentId, BigDecimal consultationFee, BigDecimal treatmentCost, int staffId) throws SQLException {
        BigDecimal total = consultationFee.add(treatmentCost);
        String sql = "INSERT INTO bill (appointment_id, consultation_fee, treatment_cost, total_amount, generated_by) " +
                "VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, appointmentId);
            ps.setBigDecimal(2, consultationFee);
            ps.setBigDecimal(3, treatmentCost);
            ps.setBigDecimal(4, total);
            ps.setInt(5, staffId);
            ps.executeUpdate();
        }
        return getByAppointmentId(appointmentId);
    }

    private Bill map(ResultSet rs) throws SQLException {
        Bill b = new Bill();
        b.setBillId(rs.getInt("bill_id"));
        b.setAppointmentId(rs.getInt("appointment_id"));
        b.setConsultationFee(rs.getBigDecimal("consultation_fee"));
        b.setTreatmentCost(rs.getBigDecimal("treatment_cost"));
        b.setTotalAmount(rs.getBigDecimal("total_amount"));
        b.setGeneratedAt(rs.getTimestamp("generated_at"));
        b.setGeneratedBy(rs.getInt("generated_by"));
        b.setAppointmentNo(rs.getString("appointment_no"));
        b.setPatientName(rs.getString("patient_name"));
        b.setDentistName(rs.getString("dentist_name"));
        b.setTreatmentName(rs.getString("treatment_name"));
        return b;
    }
}
