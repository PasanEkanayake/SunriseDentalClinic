package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.DentistDAO;
import com.sunrise.dental.dao.TreatmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/PublicHomeServlet")
public class PublicHomeServlet extends HttpServlet {

    private final DentistDAO dentistDAO = new DentistDAO();
    private final TreatmentDAO treatmentDAO = new TreatmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("activeDentists", dentistDAO.getAllActiveDentists());
            request.setAttribute("activeTreatments", treatmentDAO.getAllActiveTreatments());
        } catch (SQLException e) {

            request.setAttribute("activeDentists", java.util.Collections.emptyList());
            request.setAttribute("activeTreatments", java.util.Collections.emptyList());
        }
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
