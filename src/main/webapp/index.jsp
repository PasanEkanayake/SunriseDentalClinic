<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("staffId") != null) {
        response.sendRedirect(request.getContextPath() + "/DashboardServlet");
    } else {
        response.sendRedirect(request.getContextPath() + "/PublicHomeServlet");
    }
%>
