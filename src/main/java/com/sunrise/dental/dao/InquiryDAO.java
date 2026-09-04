package com.sunrise.dental.dao;

import com.sunrise.dental.model.Inquiry;
import com.sunrise.dental.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InquiryDAO {

    /** Stores a message submitted through the public site's Contact Us form. No login required to call this. */
    public void insertInquiry(String fullName, String email, String phone, String message) throws SQLException {
        String sql = "INSERT INTO inquiry (full_name, email, phone, message) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, message);
            ps.executeUpdate();
        }
    }

    /** All inquiries, newest first - for the Admin > Inquiries screen. */
    public List<Inquiry> getAllInquiries() throws SQLException {
        List<Inquiry> list = new ArrayList<>();
        String sql = "SELECT * FROM inquiry ORDER BY submitted_at DESC";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    public int countUnread() throws SQLException {
        String sql = "SELECT COUNT(*) FROM inquiry WHERE is_read = 0";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            rs.next();
            return rs.getInt(1);
        }
    }

    public void markAsRead(int inquiryId) throws SQLException {
        String sql = "UPDATE inquiry SET is_read = 1 WHERE inquiry_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, inquiryId);
            ps.executeUpdate();
        }
    }

    private Inquiry map(ResultSet rs) throws SQLException {
        Inquiry i = new Inquiry();
        i.setInquiryId(rs.getInt("inquiry_id"));
        i.setFullName(rs.getString("full_name"));
        i.setEmail(rs.getString("email"));
        i.setPhone(rs.getString("phone"));
        i.setMessage(rs.getString("message"));
        i.setRead(rs.getBoolean("is_read"));
        i.setSubmittedAt(rs.getTimestamp("submitted_at"));
        return i;
    }
}
