<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<c:if test="${not empty userObj}"><c:redirect url="index.jsp"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Care+ | Patient Registration</title>
  <%@include file="component/allcss.jsp"%>
  <style>
    body { background: linear-gradient(135deg,#f4f8fb,#e8f6fd); }
    .form-control, .form-select { border-radius:12px; border:2px solid #e9ecef; padding:11px 16px; font-family:'Poppins',sans-serif; }
    .form-control:focus, .form-select:focus { border-color:#019ADE; box-shadow:0 0 0 3px rgba(1,154,222,.1); }
    .progress-step { width:36px;height:36px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:.9rem; }
    .step-active   { background:linear-gradient(135deg,#019ADE,#00d4aa); color:#fff; }
    .step-done     { background:#e8f6fd; color:#019ADE; }
    .step-inactive { background:#f0f0f0; color:#aaa; }
  </style>
</head>
<body>
<%@include file="component/navbar.jsp"%>
<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-md-8 col-lg-6">
      <div class="card p-4 p-md-5" style="border-radius:24px;box-shadow:0 20px 60px rgba(1,154,222,.15);">
        <div class="text-center mb-4">
          <div style="width:70px;height:70px;border-radius:50%;background:linear-gradient(135deg,#019ADE,#00d4aa);display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:1.8rem;color:#fff;">
            <i class="fa-solid fa-user-plus"></i>
          </div>
          <h3 class="fw-700">Create Account</h3>
          <p class="text-muted small">Join Care+ for smarter healthcare</p>
        </div>

        <c:if test="${not empty errorMsg}">
          <div class="alert alert-danger rounded-3 py-2"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
          <c:remove var="errorMsg" scope="session"/>
        </c:if>

        <form action="UserRegister" method="post">
          <div class="row g-3">
            <div class="col-12">
              <label class="form-label fw-600 small">Full Name *</label>
              <input type="text" name="fullname" class="form-control" placeholder="Your full name" required>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Email Address *</label>
              <input type="email" name="email" class="form-control" placeholder="email@example.com" required>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Phone Number</label>
              <input type="tel" name="phone" class="form-control" placeholder="+91 XXXXX XXXXX">
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Password *</label>
              <input type="password" name="password" class="form-control" placeholder="Min. 6 characters" required minlength="6">
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Gender</label>
              <select name="gender" class="form-select">
                <option value="">Select Gender</option>
                <option>Male</option>
                <option>Female</option>
                <option>Other</option>
              </select>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Date of Birth</label>
              <input type="date" name="dob" class="form-control">
            </div>
            <div class="col-md-6">
              <label class="form-label fw-600 small">Blood Group</label>
              <select name="bloodGroup" class="form-select">
                <option value="">Select Blood Group</option>
                <option>A+</option><option>A-</option>
                <option>B+</option><option>B-</option>
                <option>AB+</option><option>AB-</option>
                <option>O+</option><option>O-</option>
              </select>
            </div>
            <div class="col-12">
              <label class="form-label fw-600 small">Address</label>
              <input type="text" name="address" class="form-control" placeholder="Your address">
            </div>
            <div class="col-12">
              <button type="submit" class="btn-primary-custom btn w-100 py-3 fw-700">
                <i class="fa-solid fa-user-plus me-2"></i>Create My Account
              </button>
            </div>
          </div>
        </form>
        <div class="text-center mt-3">
          <span class="text-muted small">Already have an account? </span>
          <a href="user_login.jsp" style="color:#019ADE;font-weight:600;">Login</a>
        </div>
      </div>
    </div>
  </div>
</div>
<%@include file="component/footer.jsp"%>
</body>
</html>
