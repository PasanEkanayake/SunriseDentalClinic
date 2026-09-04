package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.AppointmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("todayCount", appointmentDAO.countToday());
            request.setAttribute("todaySchedule", appointmentDAO.getTodaySchedule());
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Could not load dashboard data: " + e.getMessage());
        }
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
