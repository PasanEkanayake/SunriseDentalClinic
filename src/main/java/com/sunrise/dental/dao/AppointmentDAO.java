package com.sunrise.dental.dao;

import com.sunrise.dental.model.Appointment;
import com.sunrise.dental.model.Patient;
import com.sunrise.dental.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    private final PatientDAO patientDAO = new PatientDAO();

    /**
     * Checks whether the given dentist already has a SCHEDULED appointment
     * at the exact date/time requested. This is the application-level
     * guard against double-booking; the database's UNIQUE constraint on
     * (dentist_id, appointment_date, appointment_time) is the safety net
     * underneath it in case of a race condition.
     *
     * @param excludeAppointmentId pass 0 when registering a new appointment;
     *                             pass the current appointment's ID when
     *                             editing, so it doesn't collide with itself.
     */
    public boolean isSlotTaken(int dentistId, Date date, Time time, int excludeAppointmentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM appointment " +
                "WHERE dentist_id = ? AND appointment_date = ? AND appointment_time = ? " +
                "AND status <> 'CANCELLED' AND appointment_id <> ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, dentistId);
            ps.setDate(2, date);
            ps.setTime(3, time);
            ps.setInt(4, excludeAppointmentId);
            try (ResultSet rs = ps.executeQuery()) {
                rs.next();
                return rs.getInt(1) > 0;
            }
        }
    }

    /**
     * Registers a brand-new appointment. Re-uses an existing patient record
     * (matched on name + contact number) if one exists, otherwise creates a
     * new patient. Runs as a single transaction so a failure part-way
     * through never leaves an orphaned patient or half-written appointment.
     *
     * @return the generated, human-readable appointment number (e.g. APT-000007)
     */
    public String registerAppointment(Patient patientInput, int dentistId, int treatmentId,
                                       Date date, Time time) throws SQLException {
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // 1. Find or create the patient
            Patient existing = patientDAO.findByNameAndContact(patientInput.getPatientName(), patientInput.getContactNumber());
            int patientId;
            if (existing != null) {
                patientId = existing.getPatientId();
            } else {
                patientId = patientDAO.insertPatient(patientInput, con);
            }

            // 2. Insert the appointment (appointment_no set to a temporary placeholder first)
            String insertSql = "INSERT INTO appointment " +
                    "(appointment_no, patient_id, dentist_id, treatment_id, appointment_date, appointment_time, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, 'SCHEDULED')";
            int appointmentId;
            try (PreparedStatement ps = con.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, "PENDING");
                ps.setInt(2, patientId);
                ps.setInt(3, dentistId);
                ps.setInt(4, treatmentId);
                ps.setDate(5, date);
                ps.setTime(6, time);
                ps.executeUpdate();
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    keys.next();
                    appointmentId = keys.getInt(1);
                }
            }

            // 3. Turn the numeric ID into a friendly appointment number, e.g. APT-000007
            String appointmentNo = String.format("APT-%06d", appointmentId);
            try (PreparedStatement ps = con.prepareStatement(
                    "UPDATE appointment SET appointment_no = ? WHERE appointment_id = ?")) {
                ps.setString(1, appointmentNo);
                ps.setInt(2, appointmentId);
                ps.executeUpdate();
            }

            con.commit();
            return appointmentNo;

        } catch (SQLException e) {
            if (con != null) con.rollback();
            throw e;
        } finally {
            if (con != null) {
                con.setAutoCommit(true);
                con.close();
            }
        }
    }

    /** Full detail lookup used by "Display Appointment Details". */
    public Appointment getByAppointmentNo(String appointmentNo) throws SQLException {
        String sql = joinSql() + " WHERE a.appointment_no = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, appointmentNo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        }
        return null;
    }

    public Appointment getById(int appointmentId) throws SQLException {
        String sql = joinSql() + " WHERE a.appointment_id = ?";
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

    public List<Appointment> getAll() throws SQLException {
        List<Appointment> list = new ArrayList<>();
        String sql = joinSql() + " ORDER BY a.appointment_date DESC, a.appointment_time DESC";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    public void updateAppointment(int appointmentId, int dentistId, int treatmentId,
                                   Date date, Time time, String status) throws SQLException {
        String sql = "UPDATE appointment SET dentist_id = ?, treatment_id = ?, " +
                "appointment_date = ?, appointment_time = ?, status = ? WHERE appointment_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, dentistId);
            ps.setInt(2, treatmentId);
            ps.setDate(3, date);
            ps.setTime(4, time);
            ps.setString(5, status);
            ps.setInt(6, appointmentId);
            ps.executeUpdate();
        }
    }

    public void updateStatus(int appointmentId, String status) throws SQLException {
        String sql = "UPDATE appointment SET status = ? WHERE appointment_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, appointmentId);
            ps.executeUpdate();
        }
    }

    public int countToday() throws SQLException {
        String sql = "SELECT COUNT(*) FROM appointment WHERE appointment_date = CURDATE() AND status <> 'CANCELLED'";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            rs.next();
            return rs.getInt(1);
        }
    }

    public List<Appointment> getTodaySchedule() throws SQLException {
        List<Appointment> list = new ArrayList<>();
        String sql = joinSql() + " WHERE a.appointment_date = CURDATE() AND a.status <> 'CANCELLED' " +
                "ORDER BY a.appointment_time";
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    private String joinSql() {
        return "SELECT a.*, p.patient_name, p.address, p.contact_number, " +
                "d.dentist_name, t.treatment_name, t.cost AS treatment_cost " +
                "FROM appointment a " +
                "JOIN patient p ON a.patient_id = p.patient_id " +
                "JOIN dentist d ON a.dentist_id = d.dentist_id " +
                "JOIN treatment_type t ON a.treatment_id = t.treatment_id";
    }

    private Appointment map(ResultSet rs) throws SQLException {
        Appointment a = new Appointment();
        a.setAppointmentId(rs.getInt("appointment_id"));
        a.setAppointmentNo(rs.getString("appointment_no"));
        a.setPatientId(rs.getInt("patient_id"));
        a.setDentistId(rs.getInt("dentist_id"));
        a.setTreatmentId(rs.getInt("treatment_id"));
        a.setAppointmentDate(rs.getDate("appointment_date"));
        a.setAppointmentTime(rs.getTime("appointment_time"));
        a.setStatus(rs.getString("status"));
        a.setPatientName(rs.getString("patient_name"));
        a.setAddress(rs.getString("address"));
        a.setContactNumber(rs.getString("contact_number"));
        a.setDentistName(rs.getString("dentist_name"));
        a.setTreatmentName(rs.getString("treatment_name"));
        a.setTreatmentCost(rs.getBigDecimal("treatment_cost"));
        return a;
    }
    
    /**
     * Search appointments by patient name (case-insensitive partial match).
     */
    public List<Appointment> getByPatientName(String patientName) throws SQLException {
        List<Appointment> list = new ArrayList<>();
        String sql = joinSql() + " WHERE LOWER(p.patient_name) LIKE LOWER(?) " +
                     "ORDER BY a.appointment_date DESC, a.appointment_time DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + patientName.trim() + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        }
        return list;
    }
}
