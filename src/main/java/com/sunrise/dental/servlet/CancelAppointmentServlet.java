package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.AppointmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/CancelAppointmentServlet")
public class CancelAppointmentServlet extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("staffRole") : null;

        if (!"ADMIN".equals(role)) {
            request.setAttribute("errorMessage", "Only administrators can cancel appointments.");
            request.getRequestDispatcher("appointment_list.jsp").forward(request, response);
            return;
        }

        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            appointmentDAO.updateStatus(appointmentId, "CANCELLED");
            response.sendRedirect(request.getContextPath() + "/AppointmentListServlet?cancelled=1");
        } catch (NumberFormatException | SQLException e) {
            request.setAttribute("errorMessage", "Could not cancel the appointment: " + e.getMessage());
            request.getRequestDispatcher("appointment_list.jsp").forward(request, response);
        }
    }
}
