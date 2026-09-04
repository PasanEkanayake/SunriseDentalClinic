<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>

<style>
    .admin-header-card {
        background: linear-gradient(135deg, #0a2540 0%, #0f172a 100%);
        color: #ffffff;
        border-radius: 16px;
        padding: 2rem;
        position: relative;
        overflow: hidden;
    }

    .admin-action-tile {
        border: 1px solid #e2e8f0;
        border-radius: 16px;
        background: #ffffff;
        padding: 1.75rem 1.25rem;
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-align: center;
        position: relative;
        transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
        box-shadow: 0 4px 12px rgba(10, 37, 64, 0.03);
    }

    .admin-action-tile:hover {
        transform: translateY(-4px);
        box-shadow: 0 12px 24px -6px rgba(10, 37, 64, 0.12);
        border-color: rgba(2, 132, 199, 0.3);
    }

    .action-icon-box {
        width: 64px;
        height: 64px;
        border-radius: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 1.25rem;
        transition: transform 0.25s ease;
    }

    .admin-action-tile:hover .action-icon-box {
        transform: scale(1.08);
    }

    .action-arrow {
        position: absolute;
        top: 1.25rem;
        right: 1.25rem;
        opacity: 0.2;
        transition: all 0.25s ease;
    }

    .admin-action-tile:hover .action-arrow {
        opacity: 1;
        transform: translateX(2px);
    }
</style>

<!-- Header Banner -->
<div class="admin-header-card mb-4 shadow-sm">
    <div class="d-flex align-items-center gap-3">
        <div class="bg-white bg-opacity-10 p-3 rounded-3 text-white d-none d-sm-block">
            <i class="bi bi-shield-lock fs-1"></i>
        </div>
        <div>
            <span class="badge bg-danger bg-opacity-20 text-white border border-danger border-opacity-25 mb-2 px-3 py-1 rounded-pill fw-medium">Administrator Privileges</span>
            <h3 class="fw-bold mb-1">Admin Control Panel</h3>
            <p class="text-white-50 mb-0">Manage staff logins, dentists, treatment types, clinic-wide settings, and web inquiries.</p>
        </div>
    </div>
</div>

<!-- Quick Actions Grid -->
<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3 mb-5">
    <div>
        <a href="<%=request.getContextPath()%>/ManageStaffServlet" class="text-decoration-none text-dark">
            <div class="admin-action-tile">
                <i class="bi bi-arrow-right-circle-fill fs-5 text-primary action-arrow"></i>
                <div class="action-icon-box bg-primary-subtle text-primary">
                    <i class="bi bi-people fs-2"></i>
                </div>
                <div class="fw-bold mb-1">Manage Staff</div>
                <div class="small text-muted">Add admins &amp; receptionists</div>
            </div>
        </a>
    </div>

    <div>
        <a href="<%=request.getContextPath()%>/ManageDentistServlet" class="text-decoration-none text-dark">
            <div class="admin-action-tile">
                <i class="bi bi-arrow-right-circle-fill fs-5 text-success action-arrow"></i>
                <div class="action-icon-box bg-success-subtle text-success">
                    <i class="bi bi-person-badge fs-2"></i>
                </div>
                <div class="fw-bold mb-1">Manage Dentists</div>
                <div class="small text-muted">Add or retire dentists</div>
            </div>
        </a>
    </div>

    <div>
        <a href="<%=request.getContextPath()%>/ManageTreatmentServlet" class="text-decoration-none text-dark">
            <div class="admin-action-tile">
                <i class="bi bi-arrow-right-circle-fill fs-5 text-warning action-arrow"></i>
                <div class="action-icon-box bg-warning-subtle text-warning">
                    <i class="bi bi-clipboard2-pulse fs-2"></i>
                </div>
                <div class="fw-bold mb-1">Manage Treatments</div>
                <div class="small text-muted">Add treatment types &amp; costs</div>
            </div>
        </a>
    </div>

    <div>
        <a href="<%=request.getContextPath()%>/ManageSettingsServlet" class="text-decoration-none text-dark">
            <div class="admin-action-tile">
                <i class="bi bi-arrow-right-circle-fill fs-5 text-info action-arrow"></i>
                <div class="action-icon-box bg-info-subtle text-info">
                    <i class="bi bi-gear fs-2"></i>
                </div>
                <div class="fw-bold mb-1">Clinic Settings</div>
                <div class="small text-muted">Consultation fee &amp; settings</div>
            </div>
        </a>
    </div>

    <div>
        <a href="<%=request.getContextPath()%>/ManageInquiriesServlet" class="text-decoration-none text-dark">
            <div class="admin-action-tile">
                <i class="bi bi-arrow-right-circle-fill fs-5 text-danger action-arrow"></i>
                <div class="action-icon-box bg-danger-subtle text-danger">
                    <i class="bi bi-envelope-paper fs-2"></i>
                </div>
                <div class="fw-bold mb-1">Website Inquiries</div>
                <div class="small text-muted">Messages from public site</div>
            </div>
        </a>
    </div>
</div>

<%@ include file="WEB-INF/jspf/footer.jspf" %>