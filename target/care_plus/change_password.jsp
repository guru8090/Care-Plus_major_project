<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<c:if test="${empty userObj}"><c:redirect url="user_login.jsp"/></c:if>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Care+ | Change Password</title>
<%@include file="component/allcss.jsp"%>
<style>body{background:#f4f8fb;}.form-control{border-radius:12px;border:2px solid #e9ecef;padding:12px 16px;font-family:'Poppins',sans-serif;}.form-control:focus{border-color:#019ADE;box-shadow:0 0 0 3px rgba(1,154,222,.1);}</style>
</head><body>
<%@include file="component/navbar.jsp"%>
<div class="container py-5"><div class="row justify-content-center"><div class="col-md-6">
<div class="card p-4 p-md-5" style="border-radius:24px;box-shadow:0 20px 60px rgba(1,154,222,.12);">
  <div class="text-center mb-4">
    <div style="width:64px;height:64px;border-radius:50%;background:linear-gradient(135deg,#019ADE,#00d4aa);display:flex;align-items:center;justify-content:center;margin:0 auto 12px;font-size:1.6rem;color:#fff;"><i class="fa-solid fa-key"></i></div>
    <h4 class="fw-700">Change Password</h4>
  </div>
  <c:if test="${not empty succMsg}"><div class="alert alert-success rounded-3 py-2"><i class="fa-solid fa-circle-check me-2"></i>${succMsg}</div><c:remove var="succMsg" scope="session"/></c:if>
  <c:if test="${not empty errorMsg}"><div class="alert alert-danger rounded-3 py-2"><i class="fa-solid fa-circle-exclamation me-2"></i>${errorMsg}</div><c:remove var="errorMsg" scope="session"/></c:if>
  <form action="ChangePassword" method="post">
    <div class="mb-3"><label class="form-label fw-600 small">Current Password</label><input type="password" name="oldPassword" class="form-control" required></div>
    <div class="mb-3"><label class="form-label fw-600 small">New Password</label><input type="password" name="newPassword" class="form-control" required minlength="6"></div>
    <div class="mb-4"><label class="form-label fw-600 small">Confirm New Password</label><input type="password" id="conf" class="form-control" required></div>
    <button type="submit" class="btn-primary-custom btn w-100 py-3 fw-700" onclick="if(this.form.newPassword.value!==document.getElementById('conf').value){alert('Passwords do not match!');return false;}"><i class="fa-solid fa-key me-2"></i>Update Password</button>
  </form>
</div></div></div></div>
<%@include file="component/footer.jsp"%>
</body></html>
