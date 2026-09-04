<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .dashboard-welcome-card {
        background: linear-gradient(135deg, #0a2540 0%, #0c4a6e 100%);
        color: #ffffff;
        border-radius: 16px;
        position: relative;
        overflow: hidden;
    }

    .stat-tile {
        border: 1px solid #e2e8f0;
        border-radius: 16px;
        background: #ffffff;
        box-shadow: 0 4px 12px rgba(10, 37, 64, 0.03);
        transition: transform 0.25s ease, box-shadow 0.25s ease;
    }

    .stat-tile:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(10, 37, 64, 0.08);
    }

    .stat-icon-wrapper {
        width: 52px;
        height: 52px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 12px;
    }

    .action-tile {
        border: 1px solid #e2e8f0;
        border-radius: 16px;
        background: #ffffff;
        padding: 1.5rem;
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-align: center;
        position: relative;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
    }

    .action-tile:hover {
        transform: translateY(-4px);
        box-shadow: 0 12px 24px -6px rgba(10, 37, 64, 0.12);
        border-color: rgba(2, 132, 199, 0.3);
    }

    .action-icon-box {
        width: 60px;
        height: 60px;
        border-radius: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 1rem;
        transition: transform 0.25s ease;
    }

    .action-tile:hover .action-icon-box {
        transform: scale(1.08);
    }

    .action-arrow {
        position: absolute;
        top: 1rem;
        right: 1rem;
        opacity: 0.2;
        transition: all 0.25s ease;
    }

    .action-tile:hover .action-arrow {
        opacity: 1;
        transform: translateX(2px);
    }

    .schedule-card {
        border: 1px solid #e2e8f0;
        border-radius: 16px;
        box-shadow: 0 4px 12px rgba(10, 37, 64, 0.03);
        overflow: hidden;
    }

    .schedule-card .card-header {
        background: #f8fafc;
        border-bottom: 1px solid #e2e8f0;
        padding: 1.1rem 1.5rem;
        font-weight: 700;
        color: #0f172a;
    }

    .table > :not(caption) > * > * {
        padding: 1rem 1.25rem;
    }

    .badge-status-CONFIRMED, .badge-status-SCHEDULED {
        background-color: #e0f2fe;
        color: #0369a1;
        border: 1px solid #bae6fd;
    }

    .badge-status-COMPLETED {
        background-color: #dcfce7;
        color: #15803d;
        border: 1px solid #bbf7d0;
    }

    .badge-status-CANCELLED {
        background-color: #fee2e2;
        color: #b91c1c;
        border: 1px solid #fecaca;
    }
</style>

<!-- Welcome Section -->
<div class="dashboard-welcome-card p-4 p-md-5 mb-4 shadow-sm">
    <div class="row align-items-center">
        <div class="col-md-8">
            <span class="badge bg-white bg-opacity-20 text-black mb-2 px-3 py-2 rounded-pill fw-medium">Clinic Operations</span>
            <h2 class="fw-bold mb-1">Welcome back, <c:out value="${sessionScope.staffName}"/> 👋</h2>
            <p class="text-white-50 mb-0">Here is what is happening at Sunrise Dental Clinic today.</p>
        </div>
        <div class="col-md-4 text-md-end mt-3 mt-md-0">
            <div class="d-inline-flex align-items-center bg-white bg-opacity-10 backdrop-blur rounded-3 px-3 py-2">
                <i class="bi bi-clock me-2 text-info"></i>
                <span class="fw-semibold text-white"><%= new java.text.SimpleDateFormat("EEEE, dd MMMM").format(new java.util.Date()) %></span>
            </div>
        </div>
    </div>
</div>

<!-- Stat Row -->
<div class="row g-3 mb-4">
    <div class="col-md-4 col-xl-3">
        <div class="stat-tile p-4">
            <div class="d-flex align-items-center justify-content-between">
                <div>
                    <div class="text-muted small fw-semibold text-uppercase tracking-wide">Today's Appointments</div>
                    <div class="fs-1 fw-extrabold text-dark mt-1"><c:out value="${todayCount}"/></div>
                </div>
                <div class="stat-icon-wrapper bg-primary-subtle text-primary">
                    <i class="bi bi-calendar-check fs-3"></i>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Quick Actions Title -->
<div class="d-flex align-items-center justify-content-between mb-3">
    <h5 class="fw-bold text-dark mb-0">Quick Actions</h5>
</div>

<!-- Quick Actions Grid -->
<div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 g-3 mb-5">
    <div>
        <a href="<%=request.getContextPath()%>/RegisterAppointmentServlet" class="text-decoration-none text-dark">
            <div class="action-tile">
                <i class="bi bi-arrow-right-circle-fill fs-5 text-success action-arrow"></i>
                <div class="action-icon-box bg-success-subtle text-success">
                    <i class="bi bi-calendar-plus fs-2"></i>
                </div>
                <div class="fw-bold mb-1">New Appointment</div>
                <div class="small text-muted">Register a new patient visit</div>
            </div>
        </a>
    </div>

    <div>
        <a href="<%=request.getContextPath()%>/SearchAppointmentServlet" class="text-decoration-none text-dark">
            <div class="action-tile">
                <i class="bi bi-arrow-right-circle-fill fs-5 text-primary action-arrow"></i>
                <div class="action-icon-box bg-primary-subtle text-primary">
                    <i class="bi bi-search fs-2"></i>
                </div>
                <div class="fw-bold mb-1">Search Appointment</div>
                <div class="small text-muted">Lookup by appointment ID</div>
            </div>
        </a>
    </div>

    <div>
        <a href="<%=request.getContextPath()%>/AppointmentListServlet" class="text-decoration-none text-dark">
            <div class="action-tile">
                <i class="bi bi-arrow-right-circle-fill fs-5 text-warning action-arrow"></i>
                <div class="action-icon-box bg-warning-subtle text-warning">
                    <i class="bi bi-list-check fs-2"></i>
                </div>
                <div class="fw-bold mb-1">All Appointments</div>
                <div class="small text-muted">Browse, edit or cancel</div>
            </div>
        </a>
    </div>

    <div>
        <a href="<%=request.getContextPath()%>/help.jsp" class="text-decoration-none text-dark">
            <div class="action-tile">
                <i class="bi bi-arrow-right-circle-fill fs-5 text-info action-arrow"></i>
                <div class="action-icon-box bg-info-subtle text-info">
                    <i class="bi bi-question-circle fs-2"></i>
                </div>
                <div class="fw-bold mb-1">System Help</div>
                <div class="small text-muted">Guides and documentation</div>
            </div>
        </a>
    </div>

    <c:if test="${sessionScope.staffRole == 'ADMIN'}">
        <div>
            <a href="<%=request.getContextPath()%>/AdminPanelServlet" class="text-decoration-none text-dark">
                <div class="action-tile border-danger-subtle">
                    <i class="bi bi-arrow-right-circle-fill fs-5 text-danger action-arrow"></i>
                    <div class="action-icon-box bg-danger-subtle text-danger">
                        <i class="bi bi-shield-lock fs-2"></i>
                    </div>
                    <div class="fw-bold mb-1">Admin Panel</div>
                    <div class="small text-muted">Staff, dentists &amp; settings</div>
                </div>
            </a>
        </div>
    </c:if>
</div>

<!-- Schedule Table Section -->
<div class="card schedule-card mb-4">
    <div class="card-header d-flex align-items-center justify-content-between">
        <div class="d-flex align-items-center gap-2">
            <i class="bi bi-clock-history text-primary"></i>
            <span>Today's Schedule</span>
        </div>
        <span class="badge bg-light text-secondary border fw-normal"><c:out value="${todayCount}"/> Total Scheduled</span>
    </div>
    <div class="card-body p-0">
        <c:choose>
            <c:when test="${empty todaySchedule}">
                <div class="text-center py-5">
                    <i class="bi bi-calendar-x text-muted display-6 d-block mb-3"></i>
                    <p class="text-muted mb-0">No appointments scheduled for today.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light text-muted small text-uppercase">
                            <tr>
                                <th>Time</th>
                                <th>Appt No.</th>
                                <th>Patient</th>
                                <th>Dentist</th>
                                <th>Treatment</th>
                                <th>Status</th>
                                <th class="text-end px-4">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="a" items="${todaySchedule}">
                                <tr>
                                    <td class="fw-semibold text-dark">
                                        <fmt:formatDate value="${a.appointmentTime}" pattern="hh:mm a"/>
                                    </td>
                                    <td>
                                        <a href="<%=request.getContextPath()%>/SearchAppointmentServlet?appointmentNo=${a.appointmentNo}" class="fw-bold text-decoration-none">
                                            #<c:out value="${a.appointmentNo}"/>
                                        </a>
                                    </td>
                                    <td class="fw-medium"><c:out value="${a.patientName}"/></td>
                                    <td class="text-secondary"><c:out value="${a.dentistName}"/></td>
                                    <td>
                                        <span class="badge bg-light text-dark border"><c:out value="${a.treatmentName}"/></span>
                                    </td>
                                    <td>
                                        <span class="badge rounded-pill px-3 py-2 badge-status-${a.status}">
                                            <c:out value="${a.status}"/>
                                        </span>
                                    </td>
                                    <td class="text-end px-4">
                                        <div class="btn-group btn-group-sm shadow-sm" role="group">
                                            <a class="btn btn-light border text-primary" title="View Details"
                                               href="<%=request.getContextPath()%>/SearchAppointmentServlet?appointmentNo=${a.appointmentNo}">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <a class="btn btn-light border text-success" title="Generate Bill"
                                               href="<%=request.getContextPath()%>/BillServlet?appointmentNo=${a.appointmentNo}">
                                                <i class="bi bi-receipt"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>