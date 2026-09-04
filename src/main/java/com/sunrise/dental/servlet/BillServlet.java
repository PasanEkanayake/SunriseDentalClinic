package com.sunrise.dental.servlet;

import com.sunrise.dental.dao.AppointmentDAO;
import com.sunrise.dental.dao.BillDAO;
import com.sunrise.dental.dao.SettingsDAO;
import com.sunrise.dental.model.Appointment;
import com.sunrise.dental.model.Bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final BillDAO billDAO = new BillDAO();
    private final SettingsDAO settingsDAO = new SettingsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String appointmentNo = request.getParameter("appointmentNo");
        if (appointmentNo == null || appointmentNo.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please provide an appointment number to bill.");
            request.getRequestDispatcher("search_appointment.jsp").forward(request, response);
            return;
        }

        try {
            Appointment appt = appointmentDAO.getByAppointmentNo(appointmentNo.trim());
            if (appt == null) {
                request.setAttribute("errorMessage", "No appointment found with number \"" + appointmentNo + "\".");
                request.getRequestDispatcher("search_appointment.jsp").forward(request, response);
                return;
            }

            Bill bill = billDAO.getByAppointmentId(appt.getAppointmentId());
            if (bill == null) {
                BigDecimal consultationFee = settingsDAO.getConsultationFee();
                BigDecimal treatmentCost = appt.getTreatmentCost();
                int staffId = (Integer) request.getSession().getAttribute("staffId");
                bill = billDAO.generateBill(appt.getAppointmentId(), consultationFee, treatmentCost, staffId);
            }

            request.setAttribute("bill", bill);
            request.setAttribute("appointment", appt);
            request.getRequestDispatcher("bill.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "A database error occurred while generating the bill: " + e.getMessage());
            request.getRequestDispatcher("search_appointment.jsp").forward(request, response);
        }
    }
}
