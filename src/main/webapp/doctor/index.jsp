<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.dao.AppointmentDao,com.dao.DoctorDao,com.Db.DBConnection,com.entity.Appointment,com.entity.Doctor,java.util.List" %>
<c:if test="${empty doctorObj}"><c:redirect url="../doctor_login.jsp"/></c:if>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Care+ | Doctor Dashboard</title>
<%@include file="../component/allcss.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>body{background:#f4f8fb;}.stat-card{border-radius:18px;padding:22px;color:#fff;position:relative;overflow:hidden;}.table th{font-size:.82rem;color:#888;font-weight:600;border:none;background:#f8f9fa;}.table td{font-size:.85rem;vertical-align:middle;}</style>
</head><body>
<%@include file="navbar.jsp"%>
<%
  Doctor docObj = (Doctor) session.getAttribute("doctorObj");
  AppointmentDao aDao = new AppointmentDao(DBConnection.getConnection());
  DoctorDao dDao = new DoctorDao(DBConnection.getConnection());
  List<Appointment> allAps = aDao.getAllAppointmentByDoctor(docObj.getId());
  List<Appointment> todayAps = aDao.getTodayAppointmentsByDoctor(docObj.getId());
  int total=allAps.size(), pending=0, confirmed=0, completed=0;
  for(Appointment a:allAps){ if("Pending".equals(a.getStatus()))pending++; else if("Confirmed".equals(a.getStatus()))confirmed++; else if("Completed".equals(a.getStatus()))completed++; }
%>
<div class="container-fluid px-4 py-4">
  <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-2">
    <div>
      <h4 class="fw-800 mb-0">Welcome, Dr. <%=docObj.getFullName()%>!</h4>
      <p class="text-muted small mb-0"><%=docObj.getSpec()%> | <%=docObj.getQualification()%></p>
    </div>
    <a href="patient.jsp" class="btn btn-primary-custom"><i class="fa-solid fa-users me-2"></i>View Patients</a>
  </div>
  <c:if test="${not empty succMsg}"><div class="alert alert-success rounded-3 py-2">${succMsg}</div><c:remove var="succMsg" scope="session"/></c:if>

  <div class="row g-4 mb-4">
    <div class="col-6 col-md-3"><div class="stat-card" style="background:linear-gradient(135deg,#019ADE,#0177ac);">
      <i class="fa-solid fa-calendar-check fa-2x mb-2" style="opacity:.8;"></i><h2 class="fw-800 mb-0"><%=total%></h2><p style="opacity:.85;margin:0;">Total Patients</p></div></div>
    <div class="col-6 col-md-3"><div class="stat-card" style="background:linear-gradient(135deg,#ff9800,#f57c00);">
      <i class="fa-solid fa-hourglass-half fa-2x mb-2" style="opacity:.8;"></i><h2 class="fw-800 mb-0"><%=pending%></h2><p style="opacity:.85;margin:0;">Pending</p></div></div>
    <div class="col-6 col-md-3"><div class="stat-card" style="background:linear-gradient(135deg,#00d4aa,#00a88a);">
      <i class="fa-solid fa-circle-check fa-2x mb-2" style="opacity:.8;"></i><h2 class="fw-800 mb-0"><%=confirmed%></h2><p style="opacity:.85;margin:0;">Confirmed</p></div></div>
    <div class="col-6 col-md-3"><div class="stat-card" style="background:linear-gradient(135deg,#673ab7,#4527a0);">
      <i class="fa-solid fa-calendar-day fa-2x mb-2" style="opacity:.8;"></i><h2 class="fw-800 mb-0"><%=todayAps.size()%></h2><p style="opacity:.85;margin:0;">Today</p></div></div>
  </div>

  <div class="row g-4">
    <div class="col-lg-5">
      <div class="card p-4 h-100">
        <h6 class="fw-700 mb-3">Appointment Overview</h6>
        <canvas id="docChart"></canvas>
      </div>
    </div>
    <div class="col-lg-7">
      <div class="card p-4">
        <h6 class="fw-700 mb-3">Today's Schedule (<%=todayAps.size()%> appointments)</h6>
        <% if(todayAps.isEmpty()){ %><div class="text-center py-4 text-muted"><i class="fa-regular fa-calendar fa-2x mb-2"></i><p>No appointments today</p></div>
        <% } else { %>
        <div class="table-responsive"><table class="table table-hover mb-0">
          <thead><tr><th>Patient</th><th>Time</th><th>Disease</th><th>Priority</th><th>Status</th></tr></thead>
          <tbody>
          <% for(Appointment a : todayAps){ %>
          <tr>
            <td class="fw-600"><%=a.getFullName()%></td>
            <td><%=a.getAppointmentTime()!=null?a.getAppointmentTime():""%></td>
            <td><%=a.getDiseases()!=null&&a.getDiseases().length()>20?a.getDiseases().substring(0,20)+"...":a.getDiseases()%></td>
            <td><span style="color:<%="Emergency".equals(a.getPriority())?"#f44336":"Urgent".equals(a.getPriority())?"#ff9800":"#4caf50"%>;font-weight:600;font-size:.8rem;"><%=a.getPriority()!=null?a.getPriority():"Normal"%></span></td>
            <td><span class="badge rounded-pill" style="background:<%="Pending".equals(a.getStatus())?"#fff3cd":"Confirmed".equals(a.getStatus())?"#d1e7dd":"#cfe2ff"%>;color:<%="Pending".equals(a.getStatus())?"#856404":"Confirmed".equals(a.getStatus())?"#0f5132":"#084298"%>"><%=a.getStatus()%></span></td>
          </tr>
          <% } %>
          </tbody>
        </table></div>
        <% } %>
      </div>
    </div>
  </div>
</div>
<script>new Chart(document.getElementById('docChart'),{type:'doughnut',data:{labels:['Pending','Confirmed','Completed'],datasets:[{data:[<%=pending%>,<%=confirmed%>,<%=completed%>],backgroundColor:['#ffc107','#198754','#0d6efd'],borderWidth:0}]},options:{cutout:'70%',plugins:{legend:{position:'bottom'}}}});</script>
</body></html>
