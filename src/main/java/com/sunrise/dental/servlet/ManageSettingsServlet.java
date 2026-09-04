package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.SettingsDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet("/ManageSettingsServlet")
public class ManageSettingsServlet extends HttpServlet {

    private final SettingsDAO settingsDAO = new SettingsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("consultationFee", settingsDAO.getConsultationFee());
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Could not load clinic settings: " + e.getMessage());
        }
        request.getRequestDispatcher("manage_settings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String feeStr = request.getParameter("consultationFee");

        BigDecimal fee;
        try {
            fee = new BigDecimal(feeStr);
            if (fee.compareTo(BigDecimal.ZERO) < 0) {
                request.setAttribute("errorMessage", "Consultation fee cannot be negative.");
                request.setAttribute("consultationFee", fee);
                request.getRequestDispatcher("manage_settings.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Please enter a valid amount.");
            request.getRequestDispatcher("manage_settings.jsp").forward(request, response);
            return;
        }

        try {
            settingsDAO.updateConsultationFee(fee);
            request.getSession().setAttribute("flashSuccess", "Consultation fee updated successfully.");
            response.sendRedirect(request.getContextPath() + "/ManageSettingsServlet");
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred while updating the fee: " + e.getMessage());
            request.setAttribute("consultationFee", fee);
            request.getRequestDispatcher("manage_settings.jsp").forward(request, response);
        }
    }
}
