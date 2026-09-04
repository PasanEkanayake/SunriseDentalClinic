package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.InquiryDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ManageInquiriesServlet")
public class ManageInquiriesServlet extends HttpServlet {

    private final InquiryDAO inquiryDAO = new InquiryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("inquiries", inquiryDAO.getAllInquiries());
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Could not load inquiries: " + e.getMessage());
        }
        request.getRequestDispatcher("manage_inquiries.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int inquiryId = Integer.parseInt(request.getParameter("inquiryId"));
            inquiryDAO.markAsRead(inquiryId);
        } catch (NumberFormatException | SQLException ignored) {
        }
        response.sendRedirect(request.getContextPath() + "/ManageInquiriesServlet");
    }
}
