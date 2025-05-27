package edu.espe.cotbert.forestal.domain.model.security;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author mateo
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI();
        HttpSession session = req.getSession(false);

        boolean isLoggedIn = session != null && session.getAttribute("user") != null;
        
        boolean isPublicPage = 
            path.endsWith("index.html") ||
            path.endsWith("login.jsp") ||
            path.endsWith("signup.jsp") ||
                path.endsWith("/register") ||
            path.endsWith("/login") ||
            path.contains("/css/") || 
            path.contains("/js/") || 
            path.contains("/images/");

        if (!isLoggedIn && !isPublicPage) {
            resp.sendRedirect("login.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}
