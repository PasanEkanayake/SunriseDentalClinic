package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.AppointmentDAO;
import com.sunrise.dental.model.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/SearchAppointmentServlet")
public class SearchAppointmentServlet extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String appointmentNo = request.getParameter("appointmentNo");
        String patientName = request.getParameter("patientName");

        boolean hasApptNo = appointmentNo != null && !appointmentNo.trim().isEmpty();
        boolean hasPatientName = patientName != null && !patientName.trim().isEmpty();

        // If no search query submitted, just load the search page
        if (!hasApptNo && !hasPatientName) {
            request.getRequestDispatcher("search_appointment.jsp").forward(request, response);
            return;
        }

        try {
            // 1. Search by Appointment Number (Exact Match)
            if (hasApptNo) {
                Appointment appt = appointmentDAO.getByAppointmentNo(appointmentNo.trim());
                if (appt == null) {
                    request.setAttribute("errorMessage", "No appointment found with number \"" + appointmentNo + "\".");
                    request.getRequestDispatcher("search_appointment.jsp").forward(request, response);
                    return;
                }
                if ("1".equals(request.getParameter("justRegistered"))) {
                    request.setAttribute("successMessage", "Appointment registered successfully! Please note the appointment number below for future reference.");
                }
                request.setAttribute("appointment", appt);
                request.getRequestDispatcher("appointment_details.jsp").forward(request, response);
                return;
            }

            // 2. Search by Patient Name (Partial Match)
            List<Appointment> results = appointmentDAO.getByPatientName(patientName.trim());
            if (results.isEmpty()) {
                request.setAttribute("errorMessage", "No appointments found for patient matching \"" + patientName + "\".");
                request.getRequestDispatcher("search_appointment.jsp").forward(request, response);
                return;
            }

            // If exactly 1 match found, go straight to details
            if (results.size() == 1) {
                request.setAttribute("appointment", results.get(0));
                request.getRequestDispatcher("appointment_details.jsp").forward(request, response);
            } else {
                // Multiple matches: stay on search page and display results table
                request.setAttribute("searchResults", results);
                request.setAttribute("searchedName", patientName);
                request.getRequestDispatcher("search_appointment.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred while searching: " + e.getMessage());
            request.getRequestDispatcher("search_appointment.jsp").forward(request, response);
        }
    }
}