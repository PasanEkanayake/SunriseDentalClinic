package com.sunrise.dental.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    private static final String[] PUBLIC_PATHS = {
            "/login.jsp", "/LoginServlet", "/css/", "/images/", "/error.jsp",
            "/index.jsp", "/home.jsp", "/PublicHomeServlet", "/PublicContactServlet"
    };

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        String contextPath = request.getContextPath();
        String uri = request.getRequestURI();
        String path = uri.substring(contextPath.length()); // e.g. "/", "/login.jsp", "/images/logo.svg"

        boolean isPublic = path.isEmpty() || path.equals("/");
        if (!isPublic) {
            for (String publicPath : PUBLIC_PATHS) {
                if (path.equals(publicPath) || path.startsWith(publicPath)) {
                    isPublic = true;
                    break;
                }
            }
        }

        HttpSession session = request.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("staffId") != null);

        if (isPublic || loggedIn) {
            chain.doFilter(req, resp);
        } else {
            request.getSession().setAttribute("loginMessage", "Please log in to continue.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}
