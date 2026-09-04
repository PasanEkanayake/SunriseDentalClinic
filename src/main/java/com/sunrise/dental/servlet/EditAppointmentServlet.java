package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.AppointmentDAO;
import com.sunrise.dental.dao.DentistDAO;
import com.sunrise.dental.dao.TreatmentDAO;
import com.sunrise.dental.model.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Time;

@WebServlet("/EditAppointmentServlet")
public class EditAppointmentServlet extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final DentistDAO dentistDAO = new DentistDAO();
    private final TreatmentDAO treatmentDAO = new TreatmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int appointmentId = Integer.parseInt(request.getParameter("id"));
            Appointment appt = appointmentDAO.getById(appointmentId);
            if (appt == null) {
                request.setAttribute("errorMessage", "Appointment not found.");
                request.getRequestDispatcher("search_appointment.jsp").forward(request, response);
                return;
            }
            request.setAttribute("appointment", appt);
            request.setAttribute("dentists", dentistDAO.getAllDentists());
            request.setAttribute("treatments", treatmentDAO.getAllTreatments());
            request.getRequestDispatcher("edit_appointment.jsp").forward(request, response);
        } catch (NumberFormatException | SQLException e) {
            request.setAttribute("errorMessage", "Could not load the appointment for editing.");
            request.getRequestDispatcher("appointment_list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            int dentistId = Integer.parseInt(request.getParameter("dentistId"));
            int treatmentId = Integer.parseInt(request.getParameter("treatmentId"));
            Date date = Date.valueOf(request.getParameter("appointmentDate"));
            Time time = Time.valueOf(request.getParameter("appointmentTime") + ":00");
            String status = request.getParameter("status");

            if (appointmentDAO.isSlotTaken(dentistId, date, time, appointmentId)) {
                request.setAttribute("errorMessage",
                        "This dentist already has another appointment at the selected date and time.");
                request.setAttribute("appointment", appointmentDAO.getById(appointmentId));
                request.setAttribute("dentists", dentistDAO.getAllDentists());
                request.setAttribute("treatments", treatmentDAO.getAllTreatments());
                request.getRequestDispatcher("edit_appointment.jsp").forward(request, response);
                return;
            }

            appointmentDAO.updateAppointment(appointmentId, dentistId, treatmentId, date, time, status);
            response.sendRedirect(request.getContextPath() + "/AppointmentListServlet?updated=1");

        } catch (IllegalArgumentException | SQLIntegrityConstraintViolationException e) {
            request.setAttribute("errorMessage", "Could not update the appointment - please check the values entered.");
            request.getRequestDispatcher("appointment_list.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred: " + e.getMessage());
            request.getRequestDispatcher("appointment_list.jsp").forward(request, response);
        }
    }
}
