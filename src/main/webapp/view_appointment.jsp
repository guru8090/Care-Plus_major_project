<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.dao.AppointmentDao,com.dao.DoctorDao,com.Db.DBConnection,com.entity.Appointment,com.entity.User,java.util.List" %>
<c:if test="${empty userObj}"><c:redirect url="user_login.jsp"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Care+ | My Appointments</title>
  <%@include file="component/allcss.jsp"%>
  <style>
    .status-badge { padding:5px 14px; border-radius:20px; font-size:.78rem; font-weight:600; }
    .status-Pending   { background:#fff3cd;color:#856404; }
    .status-Confirmed { background:#d1e7dd;color:#0f5132; }
    .status-Cancelled { background:#f8d7da;color:#842029; }
    .status-Completed { background:#cfe2ff;color:#084298; }
    .priority-Normal    { color:#4caf50; }
    .priority-Urgent    { color:#ff9800; }
    .priority-Emergency { color:#f44336; }
    .table th { background:#f4f8fb; font-weight:600; font-size:.85rem; color:#555; border:none; }
    .table td { vertical-align:middle; font-size:.88rem; }
  </style>
</head>
<body>
<%@include file="component/navbar.jsp"%>

<div class="container py-5">
  <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-3">
    <div>
      <h3 class="fw-700 mb-0" style="color:#019ADE;"><i class="fa-solid fa-list-check me-2"></i>My Appointments</h3>
      <p class="text-muted small mb-0">Welcome, ${userObj.fullname}! Here are all your appointments.</p>
    </div>
    <a href="user_appointment.jsp" class="btn-primary-custom btn">
      <i class="fa-solid fa-calendar-plus me-2"></i>Book New
    </a>
  </div>

  <c:if test="${not empty succMsg}">
    <div class="alert alert-success rounded-3"><i class="fa-solid fa-circle-check me-2"></i>${succMsg}</div>
    <c:remove var="succMsg" scope="session"/>
  </c:if>
  <c:if test="${not empty errorMsg}">
    <div class="alert alert-danger rounded-3"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
    <c:remove var="errorMsg" scope="session"/>
  </c:if>

  <%
    User u = (User) session.getAttribute("userObj");
    AppointmentDao aDao = new AppointmentDao(DBConnection.getConnection());
    DoctorDao dDao = new DoctorDao(DBConnection.getConnection());
    List<Appointment> appointments = aDao.getAllAppointmentByLoginUser(u.getId());
  %>

  <% if(appointments.isEmpty()) { %>
  <div class="card p-5 text-center">
    <i class="fa-solid fa-calendar-xmark fa-4x text-muted mb-4"></i>
    <h5 class="fw-600 text-muted">No appointments yet</h5>
    <p class="text-muted">Book your first appointment with our expert doctors</p>
    <a href="user_appointment.jsp" class="btn-primary-custom btn px-4 mt-2 d-inline-block" style="width:auto;">Book Now</a>
  </div>
  <% } else { %>

  <!-- Summary cards -->
  <div class="row g-3 mb-4">
    <% int pending=0, confirmed=0, completed=0;
       for(Appointment ap : appointments){
         if("Pending".equals(ap.getStatus())) pending++;
         else if("Confirmed".equals(ap.getStatus())) confirmed++;
         else if("Completed".equals(ap.getStatus())) completed++;
       }
    %>
    <div class="col-4 col-md-3">
      <div class="card p-3 text-center">
        <div style="font-size:1.8rem;font-weight:800;color:#019ADE;"><%=appointments.size()%></div>
        <div class="text-muted small">Total</div>
      </div>
    </div>
    <div class="col-4 col-md-3">
      <div class="card p-3 text-center">
        <div style="font-size:1.8rem;font-weight:800;color:#856404;"><%=pending%></div>
        <div class="text-muted small">Pending</div>
      </div>
    </div>
    <div class="col-4 col-md-3">
      <div class="card p-3 text-center">
        <div style="font-size:1.8rem;font-weight:800;color:#0f5132;"><%=confirmed%></div>
        <div class="text-muted small">Confirmed</div>
      </div>
    </div>
    <div class="col-4 col-md-3">
      <div class="card p-3 text-center">
        <div style="font-size:1.8rem;font-weight:800;color:#084298;"><%=completed%></div>
        <div class="text-muted small">Completed</div>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover mb-0">
          <thead>
            <tr>
              <th class="ps-4">#</th>
              <th>Doctor</th>
              <th>Specialist</th>
              <th>Date & Time</th>
              <th>Disease</th>
              <th>Priority</th>
              <th>Status</th>
              <th>Doctor Notes</th>
            </tr>
          </thead>
          <tbody>
            <% int sn = 1; for(Appointment ap : appointments) {
                 com.entity.Doctor doc = dDao.getDoctorById(ap.getDoctorId()); %>
            <tr>
              <td class="ps-4 fw-600 text-muted"><%=sn++%></td>
              <td>
                <div class="d-flex align-items-center gap-2">
                  <div style="width:36px;height:36px;border-radius:50%;background:#e8f6fd;display:flex;align-items:center;justify-content:center;">
                    <i class="fa-solid fa-user-doctor" style="color:#019ADE;font-size:.85rem;"></i>
                  </div>
                  <div>
                    <div class="fw-600" style="font-size:.85rem;">Dr. <%=doc!=null?doc.getFullName():"N/A"%></div>
                    <div class="text-muted" style="font-size:.75rem;"><%=doc!=null?doc.getQualification():""%></div>
                  </div>
                </div>
              </td>
              <td><span class="badge" style="background:#e8f6fd;color:#019ADE;font-size:.78rem;"><%=doc!=null?doc.getSpec():"N/A"%></span></td>
              <td>
                <div class="fw-600" style="font-size:.85rem;"><%=ap.getAppointmentDate()%></div>
                <div class="text-muted" style="font-size:.75rem;"><i class="fa-regular fa-clock me-1"></i><%=ap.getAppointmentTime()!=null?ap.getAppointmentTime():""%></div>
              </td>
              <td style="max-width:150px;"><span title="<%=ap.getDiseases()%>"><%=ap.getDiseases()!=null&&ap.getDiseases().length()>30?ap.getDiseases().substring(0,30)+"...":ap.getDiseases()%></span></td>
              <td><span class="priority-<%=ap.getPriority()!=null?ap.getPriority():"Normal"%> fw-600"><i class="fa-solid fa-circle-dot me-1"></i><%=ap.getPriority()!=null?ap.getPriority():"Normal"%></span></td>
              <td><span class="status-badge status-<%=ap.getStatus()%>"><%=ap.getStatus()%></span></td>
              <td><span class="text-muted" style="font-size:.82rem;"><%=ap.getNotes()!=null&&!ap.getNotes().isEmpty()?ap.getNotes():"—"%></span></td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <% } %>
</div>

<%@include file="component/footer.jsp"%>
</body>
</html>
