package com.admin.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.dao.SpecialistDao;
import com.Db.DBConnection;
import com.entity.Specialist;

@WebServlet("/addSpecialist")
public class AddSpecialist extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("adminObj") == null) { response.sendRedirect("admin_login.jsp"); return; }

        String specName = request.getParameter("specName");
        Specialist s = new Specialist();
        s.setSpecName(specName);

        SpecialistDao dao = new SpecialistDao(DBConnection.getConnection());
        boolean f = dao.addSpecialist(s);
        if (f) {
            session.setAttribute("succMag", "Specialist added successfully!");
        } else {
            session.setAttribute("errorMsg", "Failed to add specialist.");
        }
        response.sendRedirect("admin/index.jsp");
    }
}
