package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.AppointmentDAO;
import com.sunrise.dental.dao.DentistDAO;
import com.sunrise.dental.dao.TreatmentDAO;
import com.sunrise.dental.model.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Time;

@WebServlet("/RegisterAppointmentServlet")
public class RegisterAppointmentServlet extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final DentistDAO dentistDAO = new DentistDAO();
    private final TreatmentDAO treatmentDAO = new TreatmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadFormReferenceData(request);
        request.getRequestDispatcher("register_appointment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String patientName = trim(request.getParameter("patientName"));
        String address = trim(request.getParameter("address"));
        String contactNumber = trim(request.getParameter("contactNumber"));
        String dentistIdStr = request.getParameter("dentistId");
        String treatmentIdStr = request.getParameter("treatmentId");
        String dateStr = request.getParameter("appointmentDate");
        String timeStr = request.getParameter("appointmentTime");

        // ---- Server-side validation (never trust the browser alone) ----
        StringBuilder errors = new StringBuilder();
        if (isEmpty(patientName)) errors.append("Patient name is required. ");
        if (isEmpty(contactNumber)) errors.append("Contact number is required. ");
        else if (!contactNumber.matches("^[0-9+\\-\\s]{7,15}$")) errors.append("Contact number looks invalid. ");
        if (isEmpty(dentistIdStr)) errors.append("Please select a dentist. ");
        if (isEmpty(treatmentIdStr)) errors.append("Please select a treatment type. ");
        if (isEmpty(dateStr)) errors.append("Appointment date is required. ");
        if (isEmpty(timeStr)) errors.append("Appointment time is required. ");

        if (errors.length() > 0) {
            request.setAttribute("errorMessage", errors.toString());
            repopulate(request, patientName, address, contactNumber, dentistIdStr, treatmentIdStr, dateStr, timeStr);
            loadFormReferenceData(request);
            request.getRequestDispatcher("register_appointment.jsp").forward(request, response);
            return;
        }

        try {
            int dentistId = Integer.parseInt(dentistIdStr);
            int treatmentId = Integer.parseInt(treatmentIdStr);
            Date date = Date.valueOf(dateStr);       // expects yyyy-MM-dd from <input type="date">
            Time time = Time.valueOf(timeStr + ":00"); // expects HH:mm from <input type="time">

            if (date.toLocalDate().isBefore(java.time.LocalDate.now())) {
                request.setAttribute("errorMessage", "Appointment date cannot be in the past.");
                repopulate(request, patientName, address, contactNumber, dentistIdStr, treatmentIdStr, dateStr, timeStr);
                loadFormReferenceData(request);
                request.getRequestDispatcher("register_appointment.jsp").forward(request, response);
                return;
            }

            // ---- Double-booking guard (fixes the clinic's stated problem) ----
            if (appointmentDAO.isSlotTaken(dentistId, date, time, 0)) {
                request.setAttribute("errorMessage",
                        "This dentist already has an appointment at the selected date and time. Please choose a different slot.");
                repopulate(request, patientName, address, contactNumber, dentistIdStr, treatmentIdStr, dateStr, timeStr);
                loadFormReferenceData(request);
                request.getRequestDispatcher("register_appointment.jsp").forward(request, response);
                return;
            }

            Patient patient = new Patient();
            patient.setPatientName(patientName);
            patient.setAddress(address);
            patient.setContactNumber(contactNumber);

            String appointmentNo = appointmentDAO.registerAppointment(patient, dentistId, treatmentId, date, time);

            response.sendRedirect(request.getContextPath() +
                    "/SearchAppointmentServlet?appointmentNo=" + appointmentNo + "&justRegistered=1");

        } catch (IllegalArgumentException e) {
            
            request.setAttribute("errorMessage", "One or more fields have an invalid format. Please check the date and time.");
            repopulate(request, patientName, address, contactNumber, dentistIdStr, treatmentIdStr, dateStr, timeStr);
            loadFormReferenceData(request);
            request.getRequestDispatcher("register_appointment.jsp").forward(request, response);
        } catch (SQLIntegrityConstraintViolationException e) {
            
            request.setAttribute("errorMessage",
                    "This dentist already has an appointment at the selected date and time. Please choose a different slot.");
            repopulate(request, patientName, address, contactNumber, dentistIdStr, treatmentIdStr, dateStr, timeStr);
            loadFormReferenceData(request);
            request.getRequestDispatcher("register_appointment.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred while saving the appointment: " + e.getMessage());
            loadFormReferenceData(request);
            request.getRequestDispatcher("register_appointment.jsp").forward(request, response);
        }
    }

    private void loadFormReferenceData(HttpServletRequest request) throws ServletException {
        try {
            request.setAttribute("dentists", dentistDAO.getAllActiveDentists());
            request.setAttribute("treatments", treatmentDAO.getAllActiveTreatments());
        } catch (SQLException e) {
            throw new ServletException("Could not load dentists/treatments", e);
        }
    }

    private void repopulate(HttpServletRequest req, String name, String address, String contact,
                             String dentistId, String treatmentId, String date, String time) {
        req.setAttribute("f_patientName", name);
        req.setAttribute("f_address", address);
        req.setAttribute("f_contactNumber", contact);
        req.setAttribute("f_dentistId", dentistId);
        req.setAttribute("f_treatmentId", treatmentId);
        req.setAttribute("f_date", date);
        req.setAttribute("f_time", time);
    }

    private boolean isEmpty(String s) { return s == null || s.trim().isEmpty(); }
    private String trim(String s) { return s == null ? null : s.trim(); }
}
