<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.sql.*,com.Db.DBConnection,java.util.*" %>
<c:if test="${empty adminObj}"><c:redirect url="../admin_login.jsp"/></c:if>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Care+ | Patients</title>
<%@include file="../component/allcss.jsp"%>
<style>body{background:#f4f8fb;}.table th{font-size:.82rem;color:#888;font-weight:600;border:none;background:#f8f9fa;}.table td{font-size:.85rem;vertical-align:middle;}</style>
</head><body>
<%@include file="navbar.jsp"%>
<div class="container-fluid px-4 py-4">
  <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-2">
    <div><h4 class="fw-800 mb-0">All Patients</h4></div>
    <input type="text" id="searchP" class="form-control" style="max-width:260px;border-radius:12px;border:2px solid #e9ecef;padding:10px 16px;font-family:'Poppins',sans-serif;" placeholder="Search patients...">
  </div>
  <div class="card">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover mb-0" id="pTable">
          <thead><tr><th class="ps-4">#</th><th>Name</th><th>Email</th><th>Phone</th><th>Gender</th><th>Blood Group</th><th>Address</th></tr></thead>
          <tbody>
          <%
            Connection conn = DBConnection.getConnection();
            PreparedStatement pst = conn.prepareStatement("SELECT * FROM user_details ORDER BY id DESC");
            ResultSet rs = pst.executeQuery();
            int sn = 1;
            while(rs.next()){
          %>
          <tr>
            <td class="ps-4 text-muted fw-600"><%=sn++%></td>
            <td>
              <div class="d-flex align-items-center gap-2">
                <div style="width:36px;height:36px;border-radius:50%;background:#e8f6fd;display:flex;align-items:center;justify-content:center;flex-shrink:0;"><i class="fa-solid fa-user" style="color:#019ADE;font-size:.8rem;"></i></div>
                <span class="fw-600"><%=rs.getString("full_name")%></span>
              </div>
            </td>
            <td><%=rs.getString("email")%></td>
            <td><%=rs.getString("phone")!=null?rs.getString("phone"):"—"%></td>
            <td><%=rs.getString("gender")!=null?rs.getString("gender"):"—"%></td>
            <td><span class="badge" style="background:#ffebee;color:#c62828;border-radius:20px;"><%=rs.getString("blood_group")!=null?rs.getString("blood_group"):"—"%></span></td>
            <td><%=rs.getString("address")!=null?rs.getString("address"):"—"%></td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<script>document.getElementById('searchP').addEventListener('input',function(){const q=this.value.toLowerCase();document.querySelectorAll('#pTable tbody tr').forEach(r=>{r.style.display=r.innerText.toLowerCase().includes(q)?'':'none';});});</script>
</body></html>
