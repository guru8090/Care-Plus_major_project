<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.dao.AppointmentDao,com.dao.DoctorDao,com.Db.DBConnection,com.entity.Appointment,com.entity.Doctor,java.util.List" %>
<c:if test="${empty adminObj}"><c:redirect url="../admin_login.jsp"/></c:if>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Care+ | All Appointments</title>
<%@include file="../component/allcss.jsp"%>
<style>body{background:#f4f8fb;}.table th{font-size:.82rem;color:#888;font-weight:600;border:none;background:#f8f9fa;}.table td{font-size:.85rem;vertical-align:middle;}</style>
</head><body>
<%@include file="navbar.jsp"%>
<%
  AppointmentDao aDao=new AppointmentDao(DBConnection.getConnection());
  DoctorDao dDao=new DoctorDao(DBConnection.getConnection());
  List<Appointment> aps=aDao.getAllAppointment();
%>
<div class="container-fluid px-4 py-4">
  <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-2">
    <div><h4 class="fw-800 mb-0">All Appointments</h4><p class="text-muted small mb-0">Total: <%=aps.size()%> appointments</p></div>
    <input type="text" id="searchAp" class="form-control" style="max-width:260px;border-radius:12px;border:2px solid #e9ecef;padding:10px 16px;font-family:'Poppins',sans-serif;" placeholder="Search patient, doctor...">
  </div>
  <div class="card">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover mb-0" id="apTable">
          <thead><tr><th class="ps-4">#</th><th>Patient</th><th>Doctor</th><th>Date & Time</th><th>Disease</th><th>Priority</th><th>Status</th><th>Notes</th></tr></thead>
          <tbody>
          <% int sn=1; for(Appointment ap:aps){ Doctor doc=dDao.getDoctorById(ap.getDoctorId()); %>
          <tr>
            <td class="ps-4 text-muted fw-600"><%=sn++%></td>
            <td><div class="fw-600"><%=ap.getFullName()%></div><div class="text-muted" style="font-size:.75rem;"><%=ap.getEmail()%></div></td>
            <td>Dr. <%=doc!=null?doc.getFullName():"N/A"%><div class="text-muted" style="font-size:.75rem;"><%=doc!=null?doc.getSpec():""%></div></td>
            <td><div class="fw-600"><%=ap.getAppointmentDate()%></div><div class="text-muted" style="font-size:.75rem;"><%=ap.getAppointmentTime()!=null?ap.getAppointmentTime():""%></div></td>
            <td title="<%=ap.getDiseases()%>"><%=ap.getDiseases()!=null&&ap.getDiseases().length()>22?ap.getDiseases().substring(0,22)+"...":ap.getDiseases()%></td>
            <td><span style="font-size:.8rem;font-weight:700;color:<%="Emergency".equals(ap.getPriority())?"#f44336":"Urgent".equals(ap.getPriority())?"#ff9800":"#4caf50"%>;"><%=ap.getPriority()!=null?ap.getPriority():"Normal"%></span></td>
            <td><span class="badge rounded-pill px-3 py-2" style="background:<%="Pending".equals(ap.getStatus())?"#fff3cd":"Confirmed".equals(ap.getStatus())?"#d1e7dd":"Completed".equals(ap.getStatus())?"#cfe2ff":"#f8d7da"%>;color:<%="Pending".equals(ap.getStatus())?"#856404":"Confirmed".equals(ap.getStatus())?"#0f5132":"Completed".equals(ap.getStatus())?"#084298":"#842029"%>;"><%=ap.getStatus()%></span></td>
            <td class="text-muted" style="font-size:.8rem;"><%=ap.getNotes()!=null&&!ap.getNotes().isEmpty()?ap.getNotes():"—"%></td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<script>
document.getElementById('searchAp').addEventListener('input',function(){
  const q=this.value.toLowerCase();
  document.querySelectorAll('#apTable tbody tr').forEach(r=>{r.style.display=r.innerText.toLowerCase().includes(q)?'':'none';});
});
</script>
</body></html>
