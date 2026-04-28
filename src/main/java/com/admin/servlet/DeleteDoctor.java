package com.admin.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.dao.DoctorDao;
import com.Db.DBConnection;

@WebServlet("/DeleteDoctor")
public class DeleteDoctor extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminObj") == null) { response.sendRedirect("admin_login.jsp"); return; }

        int id = Integer.parseInt(request.getParameter("id"));
        DoctorDao dao = new DoctorDao(DBConnection.getConnection());
        boolean f = dao.deleteDoctor(id);
        if (f) {
            session.setAttribute("succMag", "Doctor deleted successfully.");
        } else {
            session.setAttribute("errorMsg", "Failed to delete doctor.");
        }
        response.sendRedirect("admin/view_doctor.jsp");
    }
}
