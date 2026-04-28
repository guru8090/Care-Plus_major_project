<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<c:if test="${not empty userObj}"><c:redirect url="index.jsp"/></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Care+ | Patient Login</title>
  <%@include file="component/allcss.jsp"%>
  <style>
    body { background: linear-gradient(135deg,#f4f8fb 0%,#e8f6fd 100%); min-height:100vh; display:flex; flex-direction:column; }
    .auth-card { max-width:460px; width:100%; border-radius:24px; box-shadow:0 20px 60px rgba(1,154,222,0.15); }
    .auth-icon { width:70px;height:70px;border-radius:50%;background:linear-gradient(135deg,#019ADE,#00d4aa);display:flex;align-items:center;justify-content:center;margin:0 auto 16px;font-size:1.8rem;color:#fff; }
    .form-control { border-radius:12px; border:2px solid #e9ecef; padding:12px 16px; font-family:'Poppins',sans-serif; transition:border-color .2s; }
    .form-control:focus { border-color:#019ADE; box-shadow:0 0 0 3px rgba(1,154,222,0.1); }
    .input-group-text { border-radius:12px 0 0 12px; border:2px solid #e9ecef; border-right:none; background:#f8f9fa; }
    .input-group .form-control { border-radius:0 12px 12px 0; }
  </style>
</head>
<body>
<%@include file="component/navbar.jsp"%>
<div class="flex-grow-1 d-flex align-items-center justify-content-center py-5">
  <div class="auth-card card p-4 p-md-5">
    <div class="text-center mb-4">
      <div class="auth-icon"><i class="fa-solid fa-user"></i></div>
      <h3 class="fw-700">Patient Login</h3>
      <p class="text-muted small">Welcome back! Access your health dashboard</p>
    </div>

    <c:if test="${not empty succMsg}">
      <div class="alert alert-success rounded-3 py-2"><i class="fa-solid fa-circle-check me-2"></i>${succMsg}</div>
      <c:remove var="succMsg" scope="session"/>
    </c:if>
    <c:if test="${not empty errorMsg}">
      <div class="alert alert-danger rounded-3 py-2"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div>
      <c:remove var="errorMsg" scope="session"/>
    </c:if>

    <form action="UserLogin" method="post">
      <div class="mb-3">
        <label class="form-label fw-600 small">Email Address</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fa-solid fa-envelope" style="color:#019ADE;"></i></span>
          <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
        </div>
      </div>
      <div class="mb-4">
        <label class="form-label fw-600 small">Password</label>
        <div class="input-group">
          <span class="input-group-text"><i class="fa-solid fa-lock" style="color:#019ADE;"></i></span>
          <input type="password" name="password" id="pwd" class="form-control" placeholder="Enter your password" required>
          <span class="input-group-text" style="border-left:none;border-radius:0 12px 12px 0;cursor:pointer;" onclick="togglePwd()">
            <i class="fa-solid fa-eye" id="eyeIcon" style="color:#888;"></i>
          </span>
        </div>
      </div>
      <button type="submit" class="btn-primary-custom btn w-100 py-3 fw-700">
        <i class="fa-solid fa-right-to-bracket me-2"></i>Login
      </button>
    </form>
    <div class="text-center mt-4">
      <span class="text-muted small">Don't have an account? </span>
      <a href="signup.jsp" style="color:#019ADE;font-weight:600;">Register Now</a>
    </div>
    <div class="text-center mt-2">
      <a href="doctor_login.jsp" style="color:#888;font-size:.85rem;">Login as Doctor →</a>
    </div>
  </div>
</div>
<%@include file="component/footer.jsp"%>
<script>
function togglePwd(){
  const p=document.getElementById('pwd'), e=document.getElementById('eyeIcon');
  p.type=p.type==='password'?'text':'password';
  e.className=p.type==='password'?'fa-solid fa-eye':'fa-solid fa-eye-slash';
}
</script>
</body>
</html>
