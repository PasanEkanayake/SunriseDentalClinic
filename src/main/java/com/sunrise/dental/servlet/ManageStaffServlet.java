package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.StaffDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

@WebServlet("/ManageStaffServlet")
public class ManageStaffServlet extends HttpServlet {

    private final StaffDAO staffDAO = new StaffDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("staffList", staffDAO.getAllStaff());
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Could not load staff accounts: " + e.getMessage());
        }
        request.getRequestDispatcher("manage_staff.jsp").forward(request, response);
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

        String username = trim(request.getParameter("username"));
        String fullName = trim(request.getParameter("fullName"));
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");

        StringBuilder errors = new StringBuilder();
        if (isEmpty(username) || !username.matches("^[a-zA-Z0-9_.]{3,30}$")) {
            errors.append("Username must be 3-30 characters and contain only letters, numbers, dots or underscores. ");
        }
        if (isEmpty(fullName)) {
            errors.append("Full name is required. ");
        }
        if (isEmpty(password) || password.length() < 6) {
            errors.append("Password must be at least 6 characters. ");
        }
        if (password != null && !password.equals(confirmPassword)) {
            errors.append("Passwords do not match. ");
        }
        if (isEmpty(role) || !(role.equals("ADMIN") || role.equals("RECEPTIONIST"))) {
            errors.append("Please select a valid role. ");
        }

        if (errors.length() > 0) {
            request.setAttribute("errorMessage", errors.toString());
            request.setAttribute("f_username", username);
            request.setAttribute("f_fullName", fullName);
            request.setAttribute("f_role", role);
            reloadListAndForward(request, response);
            return;
        }

        try {
            staffDAO.insertStaff(username, password, fullName, role);
            request.getSession().setAttribute("flashSuccess",
                    "Staff member \"" + fullName + "\" (" + role + ") was added successfully.");
            response.sendRedirect(request.getContextPath() + "/ManageStaffServlet");
        } catch (SQLIntegrityConstraintViolationException e) {
            request.setAttribute("errorMessage", "That username is already taken. Please choose a different one.");
            request.setAttribute("f_username", username);
            request.setAttribute("f_fullName", fullName);
            request.setAttribute("f_role", role);
            reloadListAndForward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred while adding the staff member: " + e.getMessage());
            reloadListAndForward(request, response);
        }
    }

    private void handleToggle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int staffId = Integer.parseInt(request.getParameter("staffId"));
            boolean newStatus = "1".equals(request.getParameter("newStatus"));

            int currentStaffId = (Integer) request.getSession().getAttribute("staffId");
            if (staffId == currentStaffId && !newStatus) {
                request.getSession().setAttribute("flashError", "You cannot deactivate your own account while logged in.");
                response.sendRedirect(request.getContextPath() + "/ManageStaffServlet");
                return;
            }

            staffDAO.setActive(staffId, newStatus);
            request.getSession().setAttribute("flashSuccess",
                    newStatus ? "Staff account reactivated." : "Staff account deactivated. They can no longer log in.");
            response.sendRedirect(request.getContextPath() + "/ManageStaffServlet");
        } catch (NumberFormatException | SQLException e) {
            request.setAttribute("errorMessage", "Could not update that staff account: " + e.getMessage());
            reloadListAndForward(request, response);
        }
    }

    private void reloadListAndForward(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("staffList", staffDAO.getAllStaff());
        } catch (SQLException ignored) {
           
        }
        request.getRequestDispatcher("manage_staff.jsp").forward(request, response);
    }

    private boolean isEmpty(String s) { return s == null || s.trim().isEmpty(); }
    private String trim(String s) { return s == null ? null : s.trim(); }
}
