package edu.espe.cotbert.forestal.domain.model.security;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
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
        String query = req.getQueryString();       
        String userAgent = req.getHeader("User-Agent");

        HttpSession session = req.getSession(false);
        boolean isLoggedIn = session != null && session.getAttribute("user") != null;

        boolean isSoapRequest = path.contains("ForestalSOAP") || (query != null && query.equalsIgnoreCase("wsdl"));

        boolean isPublicPage =
            path.endsWith("index.html") ||
            path.endsWith("login.jsp") ||
            path.endsWith("signup.jsp") ||
            path.endsWith("/register") ||
            path.endsWith("/login") ||
            path.contains("/css/") ||
            path.contains("/js/") ||
            path.contains("/images/");

        if (!isLoggedIn && !isPublicPage && !isSoapRequest) {
            resp.sendRedirect("login.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}