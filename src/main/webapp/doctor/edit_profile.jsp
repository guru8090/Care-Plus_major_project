<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<c:if test="${empty doctorObj}"><c:redirect url="../doctor_login.jsp"/></c:if>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Care+ | Edit Profile</title>
<%@include file="../component/allcss.jsp"%>
<style>body{background:#f4f8fb;}.form-control,.form-select{border-radius:12px;border:2px solid #e9ecef;padding:11px 16px;font-family:'Poppins',sans-serif;}.form-control:focus,.form-select:focus{border-color:#019ADE;box-shadow:0 0 0 3px rgba(1,154,222,.1);}</style>
</head><body>
<%@include file="navbar.jsp"%>
<div class="container py-5"><div class="row justify-content-center"><div class="col-md-8">
<div class="card p-4 p-md-5" style="border-radius:24px;box-shadow:0 20px 60px rgba(1,154,222,.12);">
  <div class="text-center mb-4">
    <div style="width:80px;height:80px;border-radius:50%;background:linear-gradient(135deg,#019ADE,#00d4aa);display:flex;align-items:center;justify-content:center;margin:0 auto 12px;font-size:2.2rem;color:#fff;"><i class="fa-solid fa-user-doctor"></i></div>
    <h4 class="fw-700">Edit Profile</h4>
  </div>
  <c:if test="${not empty succMsg}"><div class="alert alert-success rounded-3 py-2">${succMsg}</div><c:remove var="succMsg" scope="session"/></c:if>
  <c:if test="${not empty errorMsg}"><div class="alert alert-danger rounded-3 py-2">${errorMsg}</div><c:remove var="errorMsg" scope="session"/></c:if>
  <form action="../DoctorEditProfile" method="post">
    <div class="row g-3">
      <div class="col-md-6"><label class="form-label fw-600 small">Full Name</label><input type="text" name="fullname" class="form-control" value="${doctorObj.fullName}" required></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Email</label><input type="email" name="email" class="form-control" value="${doctorObj.email}" required></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Date of Birth</label><input type="date" name="dob" class="form-control" value="${doctorObj.dob}"></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Mobile</label><input type="tel" name="mobno" class="form-control" value="${doctorObj.mobno}"></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Qualification</label><input type="text" name="qualification" class="form-control" value="${doctorObj.qualification}"></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Specialist</label><input type="text" name="specialist" class="form-control" value="${doctorObj.spec}"></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Experience (years)</label><input type="number" name="experience" class="form-control" value="${doctorObj.experience}"></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Consultation Fee (₹)</label><input type="number" name="consultationFee" class="form-control" value="${doctorObj.consultationFee}"></div>
      <div class="col-md-6"><label class="form-label fw-600 small">Availability</label><input type="text" name="availability" class="form-control" value="${doctorObj.availability}" placeholder="e.g. Mon-Sat"></div>
      <div class="col-12"><label class="form-label fw-600 small">Bio</label><textarea name="bio" class="form-control" rows="3">${doctorObj.bio}</textarea></div>
      <div class="col-12"><button type="submit" class="btn-primary-custom btn w-100 py-3 fw-700"><i class="fa-solid fa-floppy-disk me-2"></i>Save Profile</button></div>
    </div>
  </form>
</div></div></div></div>
</body></html>
