package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.TreatmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet("/ManageTreatmentServlet")
public class ManageTreatmentServlet extends HttpServlet {

    private final TreatmentDAO treatmentDAO = new TreatmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("treatmentList", treatmentDAO.getAllTreatments());
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Could not load treatment types: " + e.getMessage());
        }
        request.getRequestDispatcher("manage_treatments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("toggle".equals(action)) {
            handleToggle(request, response);
        } else {
            handleAdd(request, response);
        }
    }

    private void handleAdd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = trim(request.getParameter("treatmentName"));
        String costStr = request.getParameter("cost");

        StringBuilder errors = new StringBuilder();
        if (isEmpty(name)) {
            errors.append("Treatment name is required. ");
        }
        BigDecimal cost = null;
        if (isEmpty(costStr)) {
            errors.append("Cost is required. ");
        } else {
            try {
                cost = new BigDecimal(costStr);
                if (cost.compareTo(BigDecimal.ZERO) <= 0) {
                    errors.append("Cost must be a positive number. ");
                }
            } catch (NumberFormatException e) {
                errors.append("Cost must be a valid number. ");
            }
        }

        if (errors.length() > 0) {
            request.setAttribute("errorMessage", errors.toString());
            request.setAttribute("f_treatmentName", name);
            request.setAttribute("f_cost", costStr);
            reloadListAndForward(request, response);
            return;
        }

        try {
            treatmentDAO.insertTreatment(name, cost);
            request.getSession().setAttribute("flashSuccess", "Treatment type \"" + name + "\" was added successfully.");
            response.sendRedirect(request.getContextPath() + "/ManageTreatmentServlet");
        } catch (SQLIntegrityConstraintViolationException e) {
            request.setAttribute("errorMessage", "A treatment type with that name already exists.");
            request.setAttribute("f_treatmentName", name);
            request.setAttribute("f_cost", costStr);
            reloadListAndForward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred while adding the treatment type: " + e.getMessage());
            reloadListAndForward(request, response);
        }
    }

    private void handleToggle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int treatmentId = Integer.parseInt(request.getParameter("treatmentId"));
            boolean newStatus = "1".equals(request.getParameter("newStatus"));
            treatmentDAO.setActive(treatmentId, newStatus);
            request.getSession().setAttribute("flashSuccess",
                    newStatus ? "Treatment type reactivated and available for new bookings again."
                              : "Treatment type deactivated. It will no longer appear when booking new appointments.");
            response.sendRedirect(request.getContextPath() + "/ManageTreatmentServlet");
        } catch (NumberFormatException | SQLException e) {
            request.setAttribute("errorMessage", "Could not update that treatment type: " + e.getMessage());
            reloadListAndForward(request, response);
        }
    }

    private void reloadListAndForward(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("treatmentList", treatmentDAO.getAllTreatments());
        } catch (SQLException ignored) {
        }
        request.getRequestDispatcher("manage_treatments.jsp").forward(request, response);
    }

    private boolean isEmpty(String s) { return s == null || s.trim().isEmpty(); }
    private String trim(String s) { return s == null ? null : s.trim(); }
}
