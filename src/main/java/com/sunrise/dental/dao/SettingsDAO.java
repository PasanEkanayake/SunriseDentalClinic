package com.sunrise.dental.dao;

import com.sunrise.dental.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;

public class SettingsDAO {

    public BigDecimal getConsultationFee() throws SQLException {
        String sql = "SELECT consultation_fee FROM clinic_settings WHERE setting_id = 1";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getBigDecimal("consultation_fee");
            }
        }
        return BigDecimal.ZERO;
    }

    /** Updates the clinic-wide consultation fee (Admin-only). Affects all bills generated after the change. */
    public void updateConsultationFee(BigDecimal fee) throws SQLException {
        String sql = "UPDATE clinic_settings SET consultation_fee = ? WHERE setting_id = 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBigDecimal(1, fee);
            ps.executeUpdate();
        }
    }
}
