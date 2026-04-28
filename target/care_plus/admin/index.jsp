<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.dao.DoctorDao,com.dao.AppointmentDao,com.Db.DBConnection,com.entity.Appointment,com.entity.Doctor,java.util.List" %>
<c:if test="${empty adminObj}"><c:redirect url="../admin_login.jsp"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Care+ | Admin Dashboard</title>
  <%@include file="../component/allcss.jsp"%>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body { background:#f4f8fb; }
    .stat-card { border-radius:20px; padding:24px; color:#fff; position:relative; overflow:hidden; }
    .stat-card::after { content:''; position:absolute; right:-20px; bottom:-20px; width:100px; height:100px; border-radius:50%; background:rgba(255,255,255,0.1); }
    .stat-card::before { content:''; position:absolute; right:20px; bottom:10px; width:60px; height:60px; border-radius:50%; background:rgba(255,255,255,0.08); }
    .stat-card h2 { font-size:2.2rem; font-weight:800; margin:0; }
    .stat-card p  { opacity:.85; margin:4px 0 0; font-size:.9rem; }
    .stat-icon { width:52px;height:52px;border-radius:16px;background:rgba(255,255,255,0.2);display:flex;align-items:center;justify-content:center;font-size:1.4rem;margin-bottom:16px; }
    .recent-row:hover { background:#f0f8ff; }
    .table th { font-size:.82rem;color:#888;font-weight:600;border:none;background:#f8f9fa; }
    .table td { font-size:.85rem;vertical-align:middle; }
  </style>
</head>
<body>
<%@include file="navbar.jsp"%>

<%
  DoctorDao dao = new DoctorDao(DBConnection.getConnection());
  AppointmentDao aDao = new AppointmentDao(DBConnection.getConnection());
  int docCount = dao.countDoctor();
  int userCount = dao.countUser();
  int apCount = dao.countAppointment();
  int specCount = dao.countSpecialist();
  int todayCount = dao.countTodayAppointments();
  List<Appointment> recentAps = aDao.getAllAppointment();
%>

<div class="container-fluid px-4 py-4">

  <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-3">
    <div>
      <h4 class="fw-800 mb-0" style="color:#1a1a2e;">Admin Dashboard</h4>
      <p class="text-muted small mb-0">Welcome back, Admin! Here's what's happening today.</p>
    </div>
    <div class="d-flex gap-2">
      <button class="btn btn-sm" style="background:#e8f6fd;color:#019ADE;border-radius:10px;font-weight:600;" data-bs-toggle="modal" data-bs-target="#addSpecModal">
        <i class="fa-solid fa-plus me-1"></i>Add Specialist
      </button>
      <a href="doctor.jsp" class="btn btn-sm btn-primary-custom">
        <i class="fa-solid fa-user-doctor me-1"></i>Add Doctor
      </a>
    </div>
  </div>

  <c:if test="${not empty succMag}">
    <div class="alert alert-success rounded-3 py-2"><i class="fa-solid fa-circle-check me-2"></i>${succMag}</div>
    <c:remove var="succMag" scope="session"/>
  </c:if>
  <c:if test="${not empty errorMsg}">
    <div class="alert alert-danger rounded-3 py-2">${errorMsg}</div>
    <c:remove var="errorMsg" scope="session"/>
  </c:if>

  <!-- STAT CARDS -->
  <div class="row g-4 mb-4">
    <div class="col-6 col-md-4 col-xl-2-4">
      <div class="stat-card" style="background:linear-gradient(135deg,#019ADE,#0177ac);">
        <div class="stat-icon"><i class="fa-solid fa-user-doctor"></i></div>
        <h2><%=docCount%></h2>
        <p><i class="fa-solid fa-arrow-up me-1"></i>Total Doctors</p>
      </div>
    </div>
    <div class="col-6 col-md-4 col-xl-2-4">
      <div class="stat-card" style="background:linear-gradient(135deg,#00d4aa,#00a88a);">
        <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
        <h2><%=userCount%></h2>
        <p><i class="fa-solid fa-arrow-up me-1"></i>Total Patients</p>
      </div>
    </div>
    <div class="col-6 col-md-4 col-xl-2-4">
      <div class="stat-card" style="background:linear-gradient(135deg,#673ab7,#4527a0);">
        <div class="stat-icon"><i class="fa-solid fa-calendar-check"></i></div>
        <h2><%=apCount%></h2>
        <p>Total Appointments</p>
      </div>
    </div>
    <div class="col-6 col-md-4 col-xl-2-4">
      <div class="stat-card" style="background:linear-gradient(135deg,#ff9800,#f57c00);">
        <div class="stat-icon"><i class="fa-solid fa-stethoscope"></i></div>
        <h2><%=specCount%></h2>
        <p>Specialists</p>
      </div>
    </div>
    <div class="col-6 col-md-4 col-xl-2-4">
      <div class="stat-card" style="background:linear-gradient(135deg,#f44336,#c62828);">
        <div class="stat-icon"><i class="fa-solid fa-calendar-day"></i></div>
        <h2><%=todayCount%></h2>
        <p>Today's Appointments</p>
      </div>
    </div>
  </div>

  <div class="row g-4 mb-4">
    <!-- Chart -->
    <div class="col-lg-8">
      <div class="card p-4 h-100">
        <h6 class="fw-700 mb-3">Appointment Status Overview</h6>
        <canvas id="apChart" height="100"></canvas>
      </div>
    </div>
    <!-- Quick Actions -->
    <div class="col-lg-4">
      <div class="card p-4 h-100">
        <h6 class="fw-700 mb-3">Quick Actions</h6>
        <div class="d-grid gap-2">
          <a href="doctor.jsp" class="btn py-3 rounded-3 text-start fw-600" style="background:#e8f6fd;color:#019ADE;"><i class="fa-solid fa-user-doctor me-3"></i>Add New Doctor</a>
          <a href="view_doctor.jsp" class="btn py-3 rounded-3 text-start fw-600" style="background:#e8fff9;color:#00d4aa;"><i class="fa-solid fa-list me-3"></i>View All Doctors</a>
          <a href="patientInAdmin.jsp" class="btn py-3 rounded-3 text-start fw-600" style="background:#ede7f6;color:#673ab7;"><i class="fa-solid fa-users me-3"></i>Manage Patients</a>
          <a href="all_appointments.jsp" class="btn py-3 rounded-3 text-start fw-600" style="background:#fff3e0;color:#ff9800;"><i class="fa-solid fa-calendar-alt me-3"></i>All Appointments</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Recent Appointments -->
  <div class="card">
    <div class="card-body">
      <div class="d-flex align-items-center justify-content-between mb-3">
        <h6 class="fw-700 mb-0">Recent Appointments</h6>
        <a href="all_appointments.jsp" style="color:#019ADE;font-size:.85rem;font-weight:600;">View All →</a>
      </div>
      <div class="table-responsive">
        <table class="table table-hover">
          <thead><tr>
            <th>#</th><th>Patient</th><th>Doctor</th><th>Date</th><th>Disease</th><th>Priority</th><th>Status</th>
          </tr></thead>
          <tbody>
            <% int sn=1; for(Appointment ap : recentAps) {
                 if(sn > 8) break;
                 Doctor doc = dao.getDoctorById(ap.getDoctorId()); %>
            <tr class="recent-row">
              <td class="text-muted fw-600"><%=sn++%></td>
              <td class="fw-600"><%=ap.getFullName()%></td>
              <td>Dr. <%=doc!=null?doc.getFullName():"N/A"%></td>
              <td><%=ap.getAppointmentDate()%></td>
              <td><%=ap.getDiseases()!=null&&ap.getDiseases().length()>25?ap.getDiseases().substring(0,25)+"...":ap.getDiseases()%></td>
              <td>
                <% String pri = ap.getPriority()!=null?ap.getPriority():"Normal";
                   String priColor = "Normal".equals(pri)?"#4caf50":"Urgent".equals(pri)?"#ff9800":"#f44336"; %>
                <span style="color:<%=priColor%>;font-weight:600;font-size:.8rem;"><i class="fa-solid fa-circle me-1" style="font-size:.5rem;"></i><%=pri%></span>
              </td>
              <td>
                <span class="badge" style="background:<%= "Pending".equals(ap.getStatus())?"#fff3cd":"Confirmed".equals(ap.getStatus())?"#d1e7dd":"Completed".equals(ap.getStatus())?"#cfe2ff":"#f8d7da"%>;
                      color:<%= "Pending".equals(ap.getStatus())?"#856404":"Confirmed".equals(ap.getStatus())?"#0f5132":"Completed".equals(ap.getStatus())?"#084298":"#842029"%>;
                      border-radius:20px;padding:5px 12px;">
                  <%=ap.getStatus()%>
                </span>
              </td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- Add Specialist Modal -->
<div class="modal fade" id="addSpecModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content rounded-4 border-0">
      <div class="modal-header border-0">
        <h5 class="modal-title fw-700"><i class="fa-solid fa-stethoscope me-2" style="color:#019ADE;"></i>Add Specialist</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <form action="../addSpecialist" method="post">
          <label class="form-label fw-600 small">Specialist Name</label>
          <input type="text" name="specName" class="form-control rounded-3" placeholder="e.g. Cardiologist, Neurologist..." required>
          <div class="d-grid mt-3">
            <button type="submit" class="btn-primary-custom btn py-2 fw-700">Add Specialist</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
<%
  // Count by status for chart
  int p=0,conf=0,comp=0,canc=0;
  for(Appointment a : recentAps) {
    if("Pending".equals(a.getStatus())) p++;
    else if("Confirmed".equals(a.getStatus())) conf++;
    else if("Completed".equals(a.getStatus())) comp++;
    else canc++;
  }
%>
new Chart(document.getElementById('apChart'), {
  type: 'bar',
  data: {
    labels: ['Pending','Confirmed','Completed','Cancelled'],
    datasets:[{
      label:'Appointments',
      data:[<%=p%>,<%=conf%>,<%=comp%>,<%=canc%>],
      backgroundColor:['#fff3cd','#d1e7dd','#cfe2ff','#f8d7da'],
      borderColor:['#ffc107','#198754','#0d6efd','#dc3545'],
      borderWidth:2, borderRadius:10
    }]
  },
  options:{
    responsive:true, plugins:{legend:{display:false}},
    scales:{y:{beginAtZero:true, grid:{color:'#f0f0f0'}}, x:{grid:{display:false}}}
  }
});
</script>
</body>
</html>
