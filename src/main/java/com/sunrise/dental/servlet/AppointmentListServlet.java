package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.AppointmentDAO;
import com.sunrise.dental.model.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/AppointmentListServlet")
public class AppointmentListServlet extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Appointment> all = appointmentDAO.getAll();

            String dentistFilter = request.getParameter("dentist");
            String statusFilter = request.getParameter("status");

            List<Appointment> filtered = all.stream()
                    .filter(a -> dentistFilter == null || dentistFilter.isEmpty() || a.getDentistName().equals(dentistFilter))
                    .filter(a -> statusFilter == null || statusFilter.isEmpty() || a.getStatus().equals(statusFilter))
                    .collect(Collectors.toList());

            request.setAttribute("appointments", filtered);
            request.setAttribute("dentistFilter", dentistFilter);
            request.setAttribute("statusFilter", statusFilter);
            request.setAttribute("dentistNames", all.stream().map(Appointment::getDentistName).distinct().sorted().collect(Collectors.toList()));

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Could not load appointments: " + e.getMessage());
        }
        request.getRequestDispatcher("appointment_list.jsp").forward(request, response);
    }
}
