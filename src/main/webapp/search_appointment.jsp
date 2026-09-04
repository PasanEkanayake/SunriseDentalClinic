<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .search-card {
        border: 1px solid #e2e8f0;
        border-radius: 20px;
        background: #ffffff;
        box-shadow: 0 12px 32px rgba(10, 37, 64, 0.05);
        overflow: hidden;
    }

    .search-card-header {
        background: #f8fafc;
        border-bottom: 1px solid #e2e8f0;
        padding: 1.25rem 1.5rem;
    }

    .header-icon-box {
        width: 44px;
        height: 44px;
        background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
        color: #0284c7;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .form-label {
        font-weight: 600;
        font-size: 0.85rem;
        color: #475569;
        margin-bottom: 0.4rem;
    }

    .form-control {
        border-color: #cbd5e1;
        padding: 0.7rem 0.9rem;
        border-radius: 10px;
        font-size: 0.95rem;
    }

    .form-control:focus {
        border-color: #0284c7;
        box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.15);
    }

    .btn-search {
        background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
        color: #ffffff;
        font-weight: 600;
        padding: 0.75rem 1.75rem;
        border-radius: 10px;
        border: none;
        box-shadow: 0 4px 12px rgba(2, 132, 199, 0.2);
        transition: all 0.2s ease;
    }

    .btn-search:hover {
        background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
        color: #ffffff;
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(2, 132, 199, 0.3);
    }

    .search-table th {
        color: #64748b;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-weight: 700;
        background-color: #f8fafc;
        padding: 1rem 1.25rem;
    }

    .search-table td {
        padding: 1rem 1.25rem;
    }
</style>

<!-- Top Title Bar -->
<div class="d-flex align-items-center justify-content-between mb-4">
    <div class="d-flex align-items-center gap-3">
        <div class="header-icon-box fs-4">
            <i class="bi bi-search"></i>
        </div>
        <div>
            <h4 class="fw-bold text-dark mb-0">Search Appointments</h4>
            <p class="text-muted small mb-0">Locate patient consultation records and billing details</p>
        </div>
    </div>
    <a href="<%=request.getContextPath()%>/DashboardServlet" class="btn btn-light border fw-semibold text-secondary px-3 py-2">
        <i class="bi bi-arrow-left me-1"></i> Dashboard
    </a>
</div>

<div class="row justify-content-center">
    <div class="col-lg-8 col-xl-8">
        <!-- Search Form Card -->
        <div class="card search-card mb-4">
            <div class="search-card-header d-flex align-items-center gap-2">
                <i class="bi bi-filter-circle text-primary fs-5"></i>
                <h5 class="fw-bold text-dark mb-0">Search Criteria</h5>
            </div>
            <div class="card-body p-4 p-sm-5">
                <p class="text-muted small mb-4">Enter an appointment number or patient name to search clinic records.</p>
                
                <form method="get" action="<%=request.getContextPath()%>/SearchAppointmentServlet" class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label"><i class="bi bi-hash me-1"></i> Appointment Number</label>
                        <input type="text" name="appointmentNo" class="form-control" placeholder="e.g. APT-000001" value="${param.appointmentNo}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label"><i class="bi bi-person me-1"></i> Patient Name</label>
                        <input type="text" name="patientName" class="form-control" placeholder="e.g. John Doe" value="${param.patientName}">
                    </div>
                    <div class="col-12 d-flex justify-content-between align-items-center pt-3 mt-2 border-top">
                        <a href="<%=request.getContextPath()%>/AppointmentListServlet" class="text-decoration-none fw-semibold small text-primary">
                            <i class="bi bi-list-check me-1"></i> Or browse all appointments instead
                        </a>
                        <button type="submit" class="btn btn-search d-inline-flex align-items-center gap-2">
                            <i class="bi bi-search"></i>
                            <span>Search Records</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <%-- Multiple Results Section --%>
        <c:if test="${not empty searchResults}">
            <div class="card search-card">
                <div class="search-card-header d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center gap-2">
                        <i class="bi bi-list-task text-primary fs-5"></i>
                        <h5 class="fw-bold text-dark mb-0">Search Results</h5>
                    </div>
                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-1.5 rounded-pill fw-semibold">
                        ${searchResults.size()} found for "${searchedName}"
                    </span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover search-table mb-0 align-middle">
                            <thead>
                                <tr>
                                    <th>Appt No</th>
                                    <th>Patient Name</th>
                                    <th>Date & Time</th>
                                    <th>Status</th>
                                    <th class="text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="appt" items="${searchResults}">
                                    <tr>
                                        <td>
                                            <span class="font-monospace fw-bold text-dark">${appt.appointmentNo}</span>
                                        </td>
                                        <td>
                                            <div class="fw-semibold text-dark">${appt.patientName}</div>
                                        </td>
                                        <td>
                                            <div class="small text-dark">
                                                <i class="bi bi-calendar3 me-1 text-muted"></i>${appt.appointmentDate}
                                                <span class="text-muted ms-2"><i class="bi bi-clock me-1"></i>${appt.appointmentTime}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${appt.status == 'CANCELLED'}">
                                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2.5 py-1 rounded-pill fw-semibold">
                                                        ${appt.status}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success-subtle text-success border border-success-subtle px-2.5 py-1 rounded-pill fw-semibold">
                                                        ${appt.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end">
                                            <a href="<%=request.getContextPath()%>/SearchAppointmentServlet?appointmentNo=${appt.appointmentNo}" 
                                               class="btn btn-sm btn-outline-primary rounded-2 px-3 py-1 fw-semibold">
                                                <i class="bi bi-eye me-1"></i> View
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </c:if>

    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>