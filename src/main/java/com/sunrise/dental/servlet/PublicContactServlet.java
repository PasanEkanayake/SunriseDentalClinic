package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.InquiryDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/PublicContactServlet")
public class PublicContactServlet extends HttpServlet {

    private final InquiryDAO inquiryDAO = new InquiryDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = trim(request.getParameter("fullName"));
        String email = trim(request.getParameter("email"));
        String phone = trim(request.getParameter("phone"));
        String message = trim(request.getParameter("message"));

        StringBuilder errors = new StringBuilder();
        if (isEmpty(fullName)) errors.append("Please enter your name. ");
        if (isEmpty(email) || !email.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) errors.append("Please enter a valid email address. ");
        if (isEmpty(message)) errors.append("Please enter a message. ");

        if (errors.length() > 0) {
            request.setAttribute("contactError", errors.toString());
            request.setAttribute("f_contactName", fullName);
            request.setAttribute("f_contactEmail", email);
            request.setAttribute("f_contactPhone", phone);
            request.setAttribute("f_contactMessage", message);
            request.getRequestDispatcher("PublicHomeServlet").forward(request, response);
            return;
        }

        try {
            inquiryDAO.insertInquiry(fullName, email, phone, message);
            request.setAttribute("contactSuccess",
                    "Thanks, " + fullName + "! Your message has been sent - our team will get back to you shortly.");
        } catch (SQLException e) {
            request.setAttribute("contactError", "Sorry, something went wrong sending your message. Please call us directly instead.");
            request.setAttribute("f_contactName", fullName);
            request.setAttribute("f_contactEmail", email);
            request.setAttribute("f_contactPhone", phone);
            request.setAttribute("f_contactMessage", message);
        }

        request.getRequestDispatcher("PublicHomeServlet").forward(request, response);
    }

    private boolean isEmpty(String s) { return s == null || s.trim().isEmpty(); }
    private String trim(String s) { return s == null ? null : s.trim(); }
}
