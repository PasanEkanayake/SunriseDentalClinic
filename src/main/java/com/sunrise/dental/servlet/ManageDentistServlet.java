package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.DentistDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ManageDentistServlet")
public class ManageDentistServlet extends HttpServlet {

    private final DentistDAO dentistDAO = new DentistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("dentistList", dentistDAO.getAllDentists());
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Could not load dentists: " + e.getMessage());
        }
        request.getRequestDispatcher("manage_dentists.jsp").forward(request, response);
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

        String name = trim(request.getParameter("dentistName"));
        String specialization = trim(request.getParameter("specialization"));
        String contact = trim(request.getParameter("contactNumber"));

        StringBuilder errors = new StringBuilder();
        if (isEmpty(name)) {
            errors.append("Dentist name is required. ");
        }
        if (!isEmpty(contact) && !contact.matches("^[0-9+\\-\\s]{7,15}$")) {
            errors.append("Contact number looks invalid. ");
        }

        if (errors.length() > 0) {
            request.setAttribute("errorMessage", errors.toString());
            request.setAttribute("f_dentistName", name);
            request.setAttribute("f_specialization", specialization);
            request.setAttribute("f_contactNumber", contact);
            reloadListAndForward(request, response);
            return;
        }

        try {
            dentistDAO.insertDentist(name, specialization, contact);
            request.getSession().setAttribute("flashSuccess", "Dentist \"" + name + "\" was added successfully.");
            response.sendRedirect(request.getContextPath() + "/ManageDentistServlet");
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred while adding the dentist: " + e.getMessage());
            reloadListAndForward(request, response);
        }
    }

    private void handleToggle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int dentistId = Integer.parseInt(request.getParameter("dentistId"));
            boolean newStatus = "1".equals(request.getParameter("newStatus"));
            dentistDAO.setActive(dentistId, newStatus);
            request.getSession().setAttribute("flashSuccess",
                    newStatus ? "Dentist reactivated and available for new bookings again."
                              : "Dentist deactivated. They will no longer appear when booking new appointments.");
            response.sendRedirect(request.getContextPath() + "/ManageDentistServlet");
        } catch (NumberFormatException | SQLException e) {
            request.setAttribute("errorMessage", "Could not update that dentist: " + e.getMessage());
            reloadListAndForward(request, response);
        }
    }

    private void reloadListAndForward(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("dentistList", dentistDAO.getAllDentists());
        } catch (SQLException ignored) {
        }
        request.getRequestDispatcher("manage_dentists.jsp").forward(request, response);
    }

    private boolean isEmpty(String s) { return s == null || s.trim().isEmpty(); }
    private String trim(String s) { return s == null ? null : s.trim(); }
}
