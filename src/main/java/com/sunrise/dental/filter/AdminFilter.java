package com.sunrise.dental.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {
        "/AdminPanelServlet",
        "/ManageStaffServlet",
        "/ManageDentistServlet",
        "/ManageTreatmentServlet",
        "/ManageSettingsServlet",
        "/ManageInquiriesServlet",
        "/admin_panel.jsp",
        "/manage_staff.jsp",
        "/manage_dentists.jsp",
        "/manage_treatments.jsp",
        "/manage_settings.jsp",
        "/manage_inquiries.jsp"
})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("staffId") == null) {
            request.getSession().setAttribute("loginMessage", "Please log in to continue.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if (!"ADMIN".equals(session.getAttribute("staffRole"))) {
            session.setAttribute("flashError", "Access denied. This section is only available to administrators.");
            response.sendRedirect(request.getContextPath() + "/DashboardServlet");
            return;
        }

        chain.doFilter(req, resp);
    }
}
