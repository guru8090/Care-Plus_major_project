<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<%@ page import="com.dao.SpecialistDao,com.Db.DBConnection,com.entity.Specialist,java.util.List" %>
<c:if test="${empty adminObj}"><c:redirect url="../admin_login.jsp"/></c:if>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Care+ | Add Doctor</title>
<%@include file="../component/allcss.jsp"%>
<style>body{background:#f4f8fb;}.form-control,.form-select{border-radius:12px;border:2px solid #e9ecef;padding:11px 16px;font-family:'Poppins',sans-serif;}.form-control:focus,.form-select:focus{border-color:#019ADE;box-shadow:0 0 0 3px rgba(1,154,222,.1);}</style>
</head><body>
<%@include file="navbar.jsp"%>
<div class="container py-5"><div class="row justify-content-center"><div class="col-md-9">
<div class="card p-4 p-md-5" style="border-radius:24px;box-shadow:0 20px 60px rgba(1,154,222,.12);">
  <div class="text-center mb-4">
    <div style="width:68px;height:68px;border-radius:50%;background:linear-gradient(135deg,#019ADE,#00d4aa);display:flex;align-items:center;justify-content:center;margin:0 auto 12px;font-size:1.8rem;color:#fff;"><i class="fa-solid fa-user-doctor"></i></div>
    <h4 class="fw-700">Add New Doctor</h4>
  </div>
  <c:if test="${not empty succMag}"><div class="alert alert-success rounded-3 py-2">${succMag}</div><c:remove var="succMag" scope="session"/></c:if>
  <c:if test="${not empty errorMsg}"><div class="alert alert-danger rounded-3 py-2">${errorMsg}</div><c:remove var="errorMsg" scope="session"/></c:if>
  <form action="../AddDoctor" method="post">
    <div class="row g-3">
      <div class="col-md-6"><label class="form-label fw-600 small">Full Name *</label><input type="text" name="fullname" class="form-control" placeholder="Doctor's full name" required></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Email *</label><input type="email" name="email" class="form-control" placeholder="doctor@careplus.com" required></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Date of Birth</label><input type="date" name="dob" class="form-control"></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Mobile Number</label><input type="tel" name="mobno" class="form-control" placeholder="+91 XXXXX XXXXX"></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Qualification *</label><input type="text" name="qualification" class="form-control" placeholder="e.g. MBBS, MD" required></div>
      <div class="col-md-6">
        <label class="form-label fw-600 small">Specialist *</label>
        <select name="specialist" class="form-select" required>
          <option value="">-- Select Specialist --</option>
          <%
            SpecialistDao sDao = new SpecialistDao(DBConnection.getConnection());
            List<Specialist> specs = sDao.getAllSpecialist();
            for(Specialist sp : specs){ %>
          <option value="<%=sp.getSpecName()%>"><%=sp.getSpecName()%></option>
          <% } %>
        </select>
      </div>
      <div class="col-md-6"><label class="form-label fw-600 small">Password *</label><input type="password" name="password" class="form-control" placeholder="Set login password" required minlength="6"></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Experience (years)</label><input type="number" name="experience" class="form-control" placeholder="Years of experience" min="0"></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Consultation Fee (₹)</label><input type="number" name="consultationFee" class="form-control" placeholder="e.g. 500"></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Availability</label><input type="text" name="availability" class="form-control" placeholder="e.g. Mon-Sat, 9AM-5PM"></div>
      <div class="col-12"><label class="form-label fw-600 small">Bio / About</label><textarea name="bio" class="form-control" rows="3" placeholder="Short description about the doctor..."></textarea></div>
      <div class="col-12"><button type="submit" class="btn-primary-custom btn w-100 py-3 fw-700"><i class="fa-solid fa-user-plus me-2"></i>Add Doctor</button></div>
    </div>
  </form>
</div></div></div></div>
</body></html>
