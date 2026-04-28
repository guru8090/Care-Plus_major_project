<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<c:if test="${not empty doctorObj}"><c:redirect url="doctor/index.jsp"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Care+ | Doctor Login</title>
  <%@include file="component/allcss.jsp"%>
  <style>
    body{background:linear-gradient(135deg,#e8f6fd,#f4f8fb);min-height:100vh;display:flex;flex-direction:column;}
    .form-control{border-radius:12px;border:2px solid #e9ecef;padding:12px 16px;font-family:'Poppins',sans-serif;}
    .form-control:focus{border-color:#019ADE;box-shadow:0 0 0 3px rgba(1,154,222,.1);}
    .input-group-text{border-radius:12px 0 0 12px;border:2px solid #e9ecef;border-right:none;background:#f8f9fa;}
    .input-group .form-control{border-radius:0 12px 12px 0;}
  </style>
</head>
<body>
<%@include file="component/navbar.jsp"%>
<div class="flex-grow-1 d-flex align-items-center justify-content-center py-5">
  <div class="card p-4 p-md-5" style="max-width:440px;width:100%;border-radius:24px;box-shadow:0 20px 60px rgba(1,154,222,.15);">
    <div class="text-center mb-4">
      <div style="width:72px;height:72px;border-radius:50%;background:linear-gradient(135deg,#019ADE,#00d4aa);display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:2rem;color:#fff;"><i class="fa-solid fa-user-doctor"></i></div>
      <h3 class="fw-700">Doctor Login</h3>
      <p class="text-muted small">Access your doctor dashboard</p>
    </div>
    <c:if test="${not empty errorMsg}">
      <div class="alert alert-danger rounded-3 py-2"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
      <c:remove var="errorMsg" scope="session"/>
    </c:if>
    <form action="DoctorLogin" method="post">
      <div class="mb-3">
        <label class="form-label fw-600 small">Email</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fa-solid fa-envelope" style="color:#019ADE;"></i></span>
          <input type="email" name="email" class="form-control" placeholder="doctor@careplus.com" required>
        </div>
      </div>
      <div class="mb-4">
        <label class="form-label fw-600 small">Password</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fa-solid fa-lock" style="color:#019ADE;"></i></span>
          <input type="password" name="password" id="pwd" class="form-control" placeholder="Enter password" required>
          <span class="input-group-text" style="border-left:none;border-radius:0 12px 12px 0;cursor:pointer;" onclick="let p=document.getElementById('pwd');p.type=p.type==='password'?'text':'password'"><i class="fa-solid fa-eye" style="color:#888;"></i></span>
        </div>
      </div>
      <button type="submit" class="btn-primary-custom btn w-100 py-3 fw-700"><i class="fa-solid fa-right-to-bracket me-2"></i>Login</button>
    </form>
    <div class="text-center mt-3"><a href="index.jsp" style="color:#888;font-size:.85rem;"><i class="fa-solid fa-arrow-left me-1"></i>Back to Home</a></div>
  </div>
</div>
<%@include file="component/footer.jsp"%>
</body></html>
