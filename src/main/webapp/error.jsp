<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Something went wrong - Sunrise Dental Clinic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8fafc;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }

        .error-card {
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            background: #ffffff;
            box-shadow: 0 15px 35px rgba(10, 37, 64, 0.06);
            overflow: hidden;
        }

        .error-icon-box {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #fef2f2 0%, #ffe4e6 100%);
            color: #e11d48;
            border-radius: 24px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 20px rgba(225, 29, 72, 0.12);
        }

        .btn-dashboard {
            background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
            color: #ffffff;
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            border: none;
            box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
            transition: all 0.2s ease;
        }

        .btn-dashboard:hover {
            background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
            color: #ffffff;
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
        }
    </style>
</head>
<body class="d-flex align-items-center min-vh-100 py-5">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6 col-xl-5">
            <!-- Branded Header -->
            <div class="text-center mb-4">
                <img src="<%=request.getContextPath()%>/images/logo.svg" alt="Sunrise Dental Clinic Logo" width="48" height="48" class="mb-2">
                <h6 class="fw-bold text-secondary text-uppercase tracking-wider mb-0" style="letter-spacing: 1px;">Sunrise Dental Clinic</h6>
            </div>

            <!-- Error Card -->
            <div class="card error-card">
                <div class="card-body p-4 p-sm-5 text-center">
                    <div class="error-icon-box mb-4">
                        <i class="bi bi-exclamation-triangle-fill fs-1"></i>
                    </div>

                    <h3 class="fw-bold text-dark mb-2">Something went wrong</h3>
                    <p class="text-muted small lh-base mb-4">
                        We couldn't complete that request. This may be due to an expired session, a broken link,
                        or an unexpected server error.
                    </p>

                    <!-- Recovery Actions -->
                    <div class="d-flex flex-column flex-sm-row justify-content-center gap-2">
                        <button onclick="history.back()" class="btn btn-light border fw-semibold text-secondary px-3 py-2">
                            <i class="bi bi-arrow-left me-1"></i> Go Back
                        </button>
                        <a href="<%=request.getContextPath()%>/DashboardServlet" class="btn btn-dashboard d-inline-flex align-items-center justify-content-center gap-2">
                            <i class="bi bi-speedometer2"></i>
                            <span>Back to Dashboard</span>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Support Note -->
            <div class="text-center text-muted small mt-4">
                If this problem persists, please contact clinic administrative support.
            </div>
        </div>
    </div>
</div>
</body>
</html>