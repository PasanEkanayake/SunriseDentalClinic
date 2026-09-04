<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - Sunrise Dental Clinic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">

    <style>
        :root {
            --login-bg: linear-gradient(135deg, #0a2540 0%, #0f172a 100%);
            --primary-accent: #0284c7;
        }

        body {
            min-height: 100vh;
            background: var(--login-bg);
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }

        .login-card {
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 20px;
            background: #ffffff;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
            overflow: hidden;
        }

        .logo-wrapper {
            width: 72px;
            height: 72px;
            background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
            border-radius: 18px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 16px rgba(2, 132, 199, 0.15);
        }

        .input-group-text {
            background-color: #f8fafc;
            border-color: #cbd5e1;
            color: #64748b;
            border-top-left-radius: 10px;
            border-bottom-left-radius: 10px;
        }

        .form-control {
            border-color: #cbd5e1;
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .form-control:focus {
            border-color: var(--primary-accent);
            box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.15);
        }

        .btn-login {
            background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
            color: #ffffff;
            font-weight: 600;
            padding: 0.8rem;
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(2, 132, 199, 0.25);
            transition: all 0.2s ease;
        }

        .btn-login:hover {
            background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
            color: #ffffff;
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(2, 132, 199, 0.35);
        }

        .custom-alert {
            border: none;
            border-radius: 10px;
            padding: 0.85rem 1rem;
            font-size: 0.9rem;
        }

        .custom-alert-danger {
            background-color: #fef2f2;
            color: #991b1b;
            border-left: 4px solid #ef4444;
        }

        .custom-alert-warning {
            background-color: #fffbeb;
            color: #92400e;
            border-left: 4px solid #f59e0b;
        }

        .back-link {
            color: rgba(255, 255, 255, 0.7);
            transition: color 0.2s ease;
        }

        .back-link:hover {
            color: #ffffff;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center py-5">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 col-sm-10 col-md-8 col-lg-5 col-xl-4">
            <div class="card login-card p-2 p-sm-3">
                <div class="card-body p-4">
                    <!-- Branding Header -->
                    <div class="text-center mb-4">
                        <div class="logo-wrapper mb-3">
                            <img src="<%=request.getContextPath()%>/images/logo.svg" alt="Sunrise Dental Clinic logo" width="44" height="44">
                        </div>
                        <h4 class="fw-bold text-dark mb-1">Sunrise Dental Clinic</h4>
                        <p class="text-muted small mb-0">Appointment &amp; Patient Management</p>
                    </div>

                    <!-- Alert Banners -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert custom-alert custom-alert-danger mb-3 d-flex align-items-center gap-2" role="alert">
                            <i class="bi bi-exclamation-triangle-fill fs-5"></i>
                            <div><c:out value="${errorMessage}"/></div>
                        </div>
                    </c:if>
                    <c:if test="${not empty sessionScope.loginMessage}">
                        <div class="alert custom-alert custom-alert-warning mb-3 d-flex align-items-center gap-2" role="alert">
                            <i class="bi bi-info-circle-fill fs-5"></i>
                            <div><c:out value="${sessionScope.loginMessage}"/></div>
                        </div>
                        <% session.removeAttribute("loginMessage"); %>
                    </c:if>

                    <!-- Login Form -->
                    <form method="post" action="<%=request.getContextPath()%>/LoginServlet">
                        <div class="mb-3">
                            <label class="form-label small fw-semibold text-secondary">Username</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <input type="text" class="form-control" name="username" placeholder="Enter your username" required autofocus>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="form-label small fw-semibold text-secondary">Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-login w-100 d-flex align-items-center justify-content-center gap-2">
                            <span>Log In</span>
                            <i class="bi bi-box-arrow-in-right"></i>
                        </button>
                    </form>
                </div>
            </div>

            <!-- Footer Navigation Link -->
            <div class="mt-4 text-center">
                <a href="<%=request.getContextPath()%>/PublicHomeServlet" class="back-link small text-decoration-none">
                    <i class="bi bi-arrow-left me-1"></i> Back to public website
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>