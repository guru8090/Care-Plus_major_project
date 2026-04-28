<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Bootstrap 5 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<!-- Animate.css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<style>
  :root {
    --primary: #019ADE;
    --primary-dark: #0177ac;
    --primary-light: #e8f6fd;
    --secondary: #00d4aa;
    --accent: #ff6b6b;
    --dark: #1a1a2e;
    --text-muted: #6c757d;
    --card-shadow: 0 8px 32px rgba(1,154,222,0.12);
    --card-hover: 0 16px 48px rgba(1,154,222,0.22);
    --gradient: linear-gradient(135deg, #019ADE 0%, #00d4aa 100%);
  }
  body { font-family: 'Poppins', sans-serif; background: #f4f8fb; color: #222; }
  .btn-primary-custom {
    background: var(--gradient);
    border: none; color: #fff; border-radius: 30px;
    padding: 10px 28px; font-weight: 600;
    transition: all .3s; box-shadow: 0 4px 15px rgba(1,154,222,0.3);
  }
  .btn-primary-custom:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(1,154,222,0.45); color:#fff; }
  .card { border: none; border-radius: 16px; box-shadow: var(--card-shadow); transition: all .3s; }
  .card:hover { box-shadow: var(--card-hover); transform: translateY(-3px); }
  .badge-pending   { background: #fff3cd; color: #856404; }
  .badge-confirmed { background: #d1e7dd; color: #0f5132; }
  .badge-cancelled { background: #f8d7da; color: #842029; }
  .badge-completed { background: #cfe2ff; color: #084298; }
  .section-title { font-size: 2rem; font-weight: 700; color: var(--dark); position: relative; padding-bottom: 12px; }
  .section-title::after { content:''; position:absolute; bottom:0; left:0; width:60px; height:4px; background:var(--gradient); border-radius:2px; }
  .text-primary-custom { color: var(--primary) !important; }
  .bg-primary-custom { background: var(--gradient) !important; }
</style>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
