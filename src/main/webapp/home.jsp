<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sunrise Dental Clinic - Your Smile, Our Sunrise</title>
    <meta name="description" content="Sunrise Dental Clinic in Colombo offers general and specialist dental care - checkups, fillings, root canals, orthodontics and more. Book your visit today.">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
    <style>
        :root {
            --primary-dark: #0a2540;
            --primary-blue: #0284c7;
            --primary-cyan: #06b6d4;
            --accent-gold: #f59e0b;
            --body-bg: #f8fafc;
            --card-shadow: 0 10px 30px -5px rgba(10, 37, 64, 0.08);
            --card-shadow-hover: 0 20px 35px -5px rgba(10, 37, 64, 0.15);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--body-bg);
            color: #334155;
            scroll-behavior: smooth;
        }

        .scroll-mt {
            scroll-margin-top: 80px;
        }

        /* Navbar Enhancements */
        .public-navbar {
            background: rgba(10, 37, 64, 0.88) !important;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }

        .navbar-brand img {
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.2));
        }

        .nav-underline {
            position: relative;
            font-weight: 500;
            padding-bottom: 4px !important;
        }

        .nav-underline::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 50%;
            background-color: var(--primary-cyan);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-underline:hover::after {
            width: 80%;
        }

        .hero-section {
            background: linear-gradient(135deg, #0a2540 0%, #0c4a6e 50%, #0e7490 100%);
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: -20%;
            right: -10%;
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, rgba(6, 182, 212, 0.15) 0%, rgba(255,255,255,0) 70%);
            border-radius: 50%;
            pointer-events: none;
        }

        .hero-badge {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #38bdf8;
            font-weight: 600;
            letter-spacing: 0.5px;
            padding: 8px 16px;
            border-radius: 50rem;
        }

        .hero-accent {
            background: linear-gradient(135deg, #fde047 0%, #f59e0b 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .hero-logo-wrap {
            position: relative;
            display: inline-block;
            padding: 2rem;
        }

        .hero-logo-wrap::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.15) 0%, rgba(255,255,255,0) 70%);
            border-radius: 50%;
            animation: pulse-glow 4s infinite alternate;
        }

        @keyframes pulse-glow {
            0% { transform: scale(0.95); opacity: 0.5; }
            100% { transform: scale(1.1); opacity: 0.9; }
        }

        .hero-logo-img {
            max-width: 260px;
            filter: drop-shadow(0 15px 25px rgba(0,0,0,0.3));
            position: relative;
            z-index: 1;
        }

        .hero-wave svg {
            display: block;
            margin-bottom: -1px;
        }

        /* Section Headings */
        .section-eyebrow {
            text-transform: uppercase;
            font-size: 0.85rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            color: var(--primary-blue);
            display: block;
            margin-bottom: 0.5rem;
        }

        /* Service & Dentist Cards */
        .service-card, .dentist-card, .feature-box, .testimonial-card {
            border: 1px solid rgba(226, 232, 240, 0.8);
            border-radius: 18px;
            background: #ffffff;
            box-shadow: var(--card-shadow);
            transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
        }

        .service-card:hover, .dentist-card:hover, .feature-box:hover, .testimonial-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--card-shadow-hover);
            border-color: rgba(14, 116, 144, 0.2);
        }

        .service-icon {
            font-size: 2.2rem;
            color: var(--primary-cyan);
            background: #ecfeff;
            width: 60px;
            height: 60px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 14px;
        }

        .service-price {
            font-size: 1.2rem;
            color: var(--primary-dark);
            background: #f1f5f9;
            padding: 6px 14px;
            border-radius: 10px;
            display: inline-block;
        }

        .dentist-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 100%);
            color: var(--primary-blue);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            border: 3px solid #ffffff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .feature-icon {
            font-size: 2rem;
            color: var(--primary-blue);
            background: #f0f9ff;
            width: 56px;
            height: 56px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
        }

        /* Carousel Styling */
        .carousel-slider-container {
            position: relative;
            padding: 0 50px;
        }

        .carousel-slider-container .carousel-control-prev,
        .carousel-slider-container .carousel-control-next {
            width: 44px;
            height: 44px;
            background: #ffffff;
            border-radius: 50%;
            top: 50%;
            transform: translateY(-50%);
            box-shadow: 0 4px 12px rgba(0,0,0,0.12);
            opacity: 0.9;
            border: 1px solid #e2e8f0;
        }

        .carousel-slider-container .carousel-control-prev { left: -5px; }
        .carousel-slider-container .carousel-control-next { right: -5px; }

        .carousel-slider-container .carousel-control-prev:hover,
        .carousel-slider-container .carousel-control-next:hover {
            background: var(--primary-blue);
            border-color: var(--primary-blue);
            opacity: 1;
        }

        .carousel-slider-container .carousel-control-prev:hover .carousel-control-prev-icon,
        .carousel-slider-container .carousel-control-next:hover .carousel-control-next-icon {
            filter: brightness(0) invert(1);
        }

        /* Testimonials */
        .testimonial-card {
            position: relative;
            overflow: hidden;
        }

        .quote-icon {
            font-size: 2rem;
            color: #cbd5e1;
            opacity: 0.5;
        }

        .accordion-item {
            border: 1px solid #e2e8f0;
            border-radius: 14px !important;
            margin-bottom: 12px;
            overflow: hidden;
            box-shadow: 0 2px 6px rgba(0,0,0,0.02);
        }

        .accordion-button {
            font-weight: 600;
            color: var(--primary-dark);
            background: #ffffff;
            padding: 1.2rem 1.5rem;
        }

        .accordion-button:not(.collapsed) {
            color: var(--primary-blue);
            background-color: #f0f9ff;
            box-shadow: inset 0 -1px 0 rgba(0,0,0,0.05);
        }

        .accordion-button:focus {
            box-shadow: none;
            border-color: rgba(2, 132, 199, 0.5);
        }

        /* Contact Section */
        .contact-section {
            background: linear-gradient(135deg, #0a2540 0%, #0f172a 100%);
            border-radius: 28px;
            margin: 0 12px;
        }

        .contact-info-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
        }

        .contact-icon {
            font-size: 1.4rem;
            color: var(--primary-cyan);
            background: rgba(6, 182, 212, 0.15);
            width: 44px;
            height: 44px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
        }

        .contact-section .card {
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            border: none;
        }

        .form-control {
            padding: 0.75rem 1rem;
            border-radius: 10px;
            border: 1px solid #cbd5e1;
        }

        .form-control:focus {
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.15);
        }

        .btn-clinic {
            background: linear-gradient(135deg, var(--primary-blue) 0%, var(--primary-cyan) 100%);
            color: #ffffff;
            border: none;
            padding: 0.8rem 1.8rem;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-clinic:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(6, 182, 212, 0.3);
            color: #ffffff;
        }

        /* Footer */
        .public-footer {
            background-color: #030712;
            border-top: 1px solid #1e293b;
        }

        .footer-link {
            color: #94a3b8;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .footer-link:hover {
            color: #38bdf8;
        }

        /* Additional Interactive Tool Extensions */
        .btn-back-to-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 999;
            display: none;
            width: 45px;
            height: 45px;
            border-radius: 50%;
            border: none;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            transition: all 0.3s ease;
        }
        .stat-card-hero {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 14px;
        }
    </style>
</head>
<body class="public-site" data-bs-spy="scroll" data-bs-target="#publicNav" data-bs-offset="80" tabindex="0">

<!-- ============== PUBLIC NAVBAR ============== -->
<nav class="navbar navbar-expand-lg navbar-dark public-navbar sticky-top" id="publicNav">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2 fw-bold text-white" href="<%=request.getContextPath()%>/PublicHomeServlet">
            <img src="<%=request.getContextPath()%>/images/logo.svg" alt="Sunrise Dental Clinic logo" width="40" height="40">
            <span>Sunrise Dental Clinic</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#publicNavCollapse" aria-controls="publicNavCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="publicNavCollapse">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-lg-center">
                <li class="nav-item"><a class="nav-link nav-underline text-white active" href="#home">Home</a></li>
                <li class="nav-item"><a class="nav-link nav-underline text-white" href="#services">Services</a></li>
                <li class="nav-item"><a class="nav-link nav-underline text-white" href="#estimator">Cost Estimator</a></li>
                <li class="nav-item"><a class="nav-link nav-underline text-white" href="#dentists">Our Dentists</a></li>
                <li class="nav-item"><a class="nav-link nav-underline text-white" href="#why-us">Why Us</a></li>
                <li class="nav-item"><a class="nav-link nav-underline text-white" href="#faq">FAQ</a></li>
                <li class="nav-item"><a class="nav-link nav-underline text-white" href="#contact">Contact</a></li>
                <li class="nav-item ms-lg-3">
                    <c:choose>
                        <c:when test="${not empty sessionScope.staffId}">
                            <a class="btn btn-light btn-sm fw-semibold" href="<%=request.getContextPath()%>/DashboardServlet">
                                <i class="bi bi-speedometer2"></i> Dashboard
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a class="btn btn-outline-light btn-sm fw-semibold" href="<%=request.getContextPath()%>/login.jsp">
                                <i class="bi bi-box-arrow-in-right"></i> Staff Login
                            </a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- ============== HERO ============== -->
<header id="home" class="hero-section scroll-mt">
    <div class="container py-5">
        <div class="row align-items-center g-5 py-4">
            <div class="col-lg-6">
                <span class="badge hero-badge mb-3"><i class="bi bi-stars me-1"></i> Trusted Dental Care in Colombo</span>
                <h1 class="display-4 fw-bold text-white mb-3">Your Smile, <span class="hero-accent">Our Sunrise.</span></h1>
                <p class="lead text-white-50 mb-4">
                    From routine checkups to specialist orthodontic and surgical care, Sunrise Dental Clinic
                    combines modern equipment with a gentle, patient-first approach - for every member of your family.
                </p>
                <div class="d-flex flex-wrap gap-3">
                    <a href="#contact" class="btn btn-clinic btn-lg px-4"><i class="bi bi-calendar-check me-1"></i> Book a Visit</a>
                    <a href="tel:+94112345678" class="btn btn-outline-light btn-lg px-4"><i class="bi bi-telephone me-1"></i> Call +94 11 234 5678</a>
                </div>

                <!-- Stats Row -->
                <div class="row g-3 mt-4">
                    <div class="col-4">
                        <div class="stat-card-hero p-3 text-center text-white">
                            <h3 class="fw-bold mb-0">12,000+</h3>
                            <span class="small text-white-50">Patients</span>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="stat-card-hero p-3 text-center text-white">
                            <h3 class="fw-bold mb-0">15+</h3>
                            <span class="small text-white-50">Years Exp.</span>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="stat-card-hero p-3 text-center text-white">
                            <h3 class="fw-bold mb-0">4.9 <i class="bi bi-star-fill text-warning fs-6"></i></h3>
                            <span class="small text-white-50">Rating</span>
                        </div>
                    </div>
                </div>

                <div class="d-flex flex-wrap gap-4 mt-4 text-white-50 small">
                    <span><i class="bi bi-check-circle-fill text-info me-1"></i> Experienced Specialists</span>
                    <span><i class="bi bi-check-circle-fill text-info me-1"></i> Modern Equipment</span>
                    <span><i class="bi bi-check-circle-fill text-info me-1"></i> Patient-First Care</span>
                </div>
            </div>
            <div class="col-lg-6 text-center d-none d-lg-block">
                <div class="hero-logo-wrap">
                    <img src="<%=request.getContextPath()%>/images/logo.svg" alt="Sunrise Dental Clinic" class="hero-logo-img">
                </div>
            </div>
        </div>
    </div>
    <div class="hero-wave">
        <svg viewBox="0 0 1440 90" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
            <path fill="#f8fafc" d="M0,32L80,42.7C160,53,320,75,480,74.7C640,75,800,53,960,42.7C1120,32,1280,32,1360,32L1440,32L1440,90L0,90Z"></path>
        </svg>
    </div>
</header>

<!-- ============== SERVICES ============== -->
<section id="services" class="py-5 scroll-mt">
    <div class="container py-4">
        <div class="text-center mb-4">
            <span class="section-eyebrow">What We Offer</span>
            <h2 class="fw-bold text-dark">Our Services</h2>
            <p class="text-muted col-lg-6 mx-auto">Every treatment below is kept up to date directly by our clinic team, so what you see here is always current.</p>
        </div>

        <!-- Filter Bar -->
        <div class="row justify-content-center mb-4">
            <div class="col-md-6 col-lg-5">
                <div class="input-group input-group-lg shadow-sm">
                    <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="serviceSearchInput" class="form-control border-start-0" placeholder="Search treatment e.g., Filling, Scaling...">
                    <button class="btn btn-outline-secondary" type="button" id="clearServiceSearch"><i class="bi bi-x-circle"></i></button>
                </div>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty activeTreatments}">
                <p class="text-center text-muted">Our services list is temporarily unavailable - please call us for details.</p>
            </c:when>
            <c:otherwise>
                <div class="carousel-slider-container">
                    <div id="servicesCarousel" class="carousel slide carousel-dark" data-bs-ride="carousel">
                        <div class="carousel-inner">
                            <c:forEach var="t" items="${activeTreatments}" varStatus="status">
                                <c:if test="${status.index % 3 == 0}">
                                    <div class="carousel-item ${status.first ? 'active' : ''}">
                                        <div class="row g-4 justify-content-center">
                                </c:if>
                                
                                <div class="col-md-6 col-lg-4 service-item-wrapper" data-name="${t.treatmentName}">
                                    <div class="card service-card h-100 p-4 d-flex flex-column justify-content-between">
                                        <div>
                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                <div class="service-icon">
                                                    <i class="bi bi-clipboard2-pulse"></i>
                                                </div>
                                                <span class="badge bg-info-subtle text-info-emphasis fw-semibold">Verified Care</span>
                                            </div>
                                            <h5 class="fw-bold mb-2 text-dark"><c:out value="${t.treatmentName}"/></h5>
                                            <p class="text-muted small mb-3">Professional care delivered by our experienced dental team.</p>
                                        </div>
                                        <div>
                                            <div class="service-price fw-bold mb-3">
                                                Rs. <fmt:formatNumber value="${t.cost}" pattern="#,##0.00"/>
                                            </div>
                                            <button type="button" class="btn btn-outline-primary btn-sm w-100 quick-book-btn rounded-3" data-service="${t.treatmentName}">
                                                <i class="bi bi-calendar-plus me-1"></i> Book Treatment
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <c:if test="${status.index % 3 == 2 || status.last}">
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>

                        <c:if test="${activeTreatments.size() > 3}">
                            <button class="carousel-control-prev" type="button" data-bs-target="#servicesCarousel" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#servicesCarousel" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </c:if>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
        <p class="text-center text-muted small mt-4 mb-0">Prices shown are treatment cost only; a standard consultation fee applies per visit.</p>
    </div>
</section>

<!-- ============== COST ESTIMATOR ============== -->
<section id="estimator" class="py-5 scroll-mt bg-white border-top border-bottom">
    <div class="container py-3">
        <div class="row align-items-center g-4">
            <div class="col-lg-5">
                <span class="section-eyebrow">Instant Fee Estimator</span>
                <h2 class="fw-bold text-dark mb-3">Calculate Expected Total</h2>
                <p class="text-muted">Select your planned treatments below to calculate an estimated total cost including our standard consultation fee (Rs. 1,000.00). No hidden charges.</p>
                <ul class="list-unstyled text-muted small">
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Transparent upfront breakdown</li>
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Combines multiple services instantly</li>
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Directly attachable to your booking request</li>
                </ul>
            </div>
            <div class="col-lg-7">
                <div class="card p-4 border-0 shadow-sm rounded-4 bg-light">
                    <h5 class="fw-bold text-dark mb-3 d-flex align-items-center gap-2">
                        <i class="bi bi-calculator text-primary"></i> Treatment Estimator Tool
                    </h5>
                    
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-secondary">Select Treatment(s):</label>
                        <select id="estimatorSelect" class="form-select border-0 shadow-sm" multiple size="4">
                            <c:forEach var="t" items="${activeTreatments}">
                                <option value="${t.cost}" data-name="${t.treatmentName}">
                                    ${t.treatmentName} - Rs. <fmt:formatNumber value="${t.cost}" pattern="#,##0.00"/>
                                </option>
                            </c:forEach>
                        </select>
                        <span class="form-text text-muted extra-small">Hold <kbd>Ctrl</kbd> (or <kbd>Cmd</kbd> on Mac) to select multiple services.</span>
                    </div>

                    <div class="p-3 bg-white rounded-3 shadow-sm mb-3">
                        <div class="d-flex justify-content-between text-muted small mb-1">
                            <span>Selected Services Fee:</span>
                            <span id="calcServicesCost" class="fw-semibold">Rs. 0.00</span>
                        </div>
                        <div class="d-flex justify-content-between text-muted small mb-2">
                            <span>Standard Consultation Fee:</span>
                            <span id="calcConsultFee" class="fw-semibold">Rs. 500.00</span>
                        </div>
                        <hr class="my-2 border-secondary-subtle">
                        <div class="d-flex justify-content-between fs-5 fw-bold text-dark">
                            <span>Estimated Total:</span>
                            <span id="calcTotalCost" style="color: var(--primary-blue);">Rs. 1,000.00</span>
                        </div>
                    </div>

                    <button type="button" id="applyEstimateToContactBtn" class="btn btn-clinic w-100">
                        <i class="bi bi-send-check me-1"></i> Book Appointment with this Estimate
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============== DENTISTS ============== -->
<section id="dentists" class="py-5 scroll-mt">
    <div class="container py-4">
        <div class="text-center mb-5">
            <span class="section-eyebrow">Meet The Team</span>
            <h2 class="fw-bold text-dark">Our Dentists</h2>
            <p class="text-muted col-lg-6 mx-auto">Experienced, approachable, and dedicated to making every visit comfortable.</p>
        </div>
        <c:choose>
            <c:when test="${empty activeDentists}">
                <p class="text-center text-muted">Dentist information is temporarily unavailable - please call us for details.</p>
            </c:when>
            <c:otherwise>
                <div class="carousel-slider-container">
                    <div id="dentistsCarousel" class="carousel slide carousel-dark" data-bs-ride="carousel">
                        <div class="carousel-inner">
                            <c:forEach var="d" items="${activeDentists}" varStatus="status">
                                <c:if test="${status.index % 3 == 0}">
                                    <div class="carousel-item ${status.first ? 'active' : ''}">
                                        <div class="row g-4 justify-content-center">
                                </c:if>

                                <div class="col-md-6 col-lg-4">
                                    <div class="card dentist-card text-center p-4 h-100 d-flex flex-column justify-content-between">
                                        <div>
                                            <div class="dentist-avatar mx-auto mb-3">
                                                <i class="bi bi-person-badge"></i>
                                            </div>
                                            <h5 class="fw-bold mb-1 text-dark"><c:out value="${d.dentistName}"/></h5>
                                            <p class="text-muted small mb-3"><c:out value="${d.specialization}"/></p>
                                        </div>
                                        <button type="button" class="btn btn-outline-secondary btn-sm quick-dentist-btn rounded-3 mt-2" data-dentist="${d.dentistName}">
                                            <i class="bi bi-calendar-event me-1"></i> Request Doctor
                                        </button>
                                    </div>
                                </div>

                                <c:if test="${status.index % 3 == 2 || status.last}">
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>

                        <c:if test="${activeDentists.size() > 3}">
                            <button class="carousel-control-prev" type="button" data-bs-target="#dentistsCarousel" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#dentistsCarousel" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </c:if>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- ============== WHY CHOOSE US ============== -->
<section id="why-us" class="py-5 scroll-mt bg-white border-top">
    <div class="container py-4">
        <div class="text-center mb-5">
            <span class="section-eyebrow">Why Sunrise</span>
            <h2 class="fw-bold text-dark">Why Choose Us</h2>
        </div>
        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="feature-box text-center p-4 h-100">
                    <div class="feature-icon mb-3">
                        <i class="bi bi-award"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-2">Experienced Specialists</h6>
                    <p class="text-muted small mb-0">Qualified dentists across general, orthodontic and surgical care.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="feature-box text-center p-4 h-100">
                    <div class="feature-icon mb-3">
                        <i class="bi bi-cpu"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-2">Modern Equipment</h6>
                    <p class="text-muted small mb-0">Up-to-date tools and techniques for safer, more comfortable care.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="feature-box text-center p-4 h-100">
                    <div class="feature-icon mb-3">
                        <i class="bi bi-calendar2-check"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-2">Easy Scheduling</h6>
                    <p class="text-muted small mb-0">A computerised booking system means fewer delays and no double-bookings.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="feature-box text-center p-4 h-100">
                    <div class="feature-icon mb-3">
                        <i class="bi bi-heart"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-2">Patient-First Care</h6>
                    <p class="text-muted small mb-0">Clear explanations, transparent billing, and a gentle touch throughout.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============== TESTIMONIALS ============== -->
<section class="py-5 scroll-mt">
    <div class="container py-4">
        <div class="text-center mb-5">
            <span class="section-eyebrow">Patient Stories</span>
            <h2 class="fw-bold text-dark">What Our Patients Say</h2>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card testimonial-card h-100 p-4">
                    <i class="bi bi-quote quote-icon mb-2"></i>
                    <p class="mb-3 text-secondary">"Booked a filling and was seen right on time. No paperwork hassle, and the bill matched exactly what I was quoted."</p>
                    <div class="fw-bold text-dark">Nadeeka P.</div>
                    <div class="text-muted small">Colombo 05</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card testimonial-card h-100 p-4">
                    <i class="bi bi-quote quote-icon mb-2"></i>
                    <p class="mb-3 text-secondary">"My kids actually look forward to their checkups now. The staff are patient and explain everything clearly."</p>
                    <div class="fw-bold text-dark">Chathura W.</div>
                    <div class="text-muted small">Nugegoda</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card testimonial-card h-100 p-4">
                    <i class="bi bi-quote quote-icon mb-2"></i>
                    <p class="mb-3 text-secondary">"Root canal treatment went far more smoothly than I expected. Professional team from start to finish."</p>
                    <div class="fw-bold text-dark">Ishara G.</div>
                    <div class="text-muted small">Rajagiriya</div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============== FAQ ============== -->
<section id="faq" class="py-5 scroll-mt bg-white border-top">
    <div class="container py-4">
        <div class="text-center mb-4">
            <span class="section-eyebrow">Good To Know</span>
            <h2 class="fw-bold text-dark">Frequently Asked Questions</h2>
        </div>

        <div class="d-flex justify-content-center gap-2 mb-4">
            <button type="button" id="expandFaqBtn" class="btn btn-sm btn-outline-primary rounded-3"><i class="bi bi-arrows-expand"></i> Expand All</button>
            <button type="button" id="collapseFaqBtn" class="btn btn-sm btn-outline-secondary rounded-3"><i class="bi bi-arrows-collapse"></i> Collapse All</button>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="accordion" id="publicFaq">
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#f1">
                                Do I need an appointment, or can I walk in?
                            </button>
                        </h2>
                        <div id="f1" class="accordion-collapse collapse show" data-bs-parent="#publicFaq">
                            <div class="accordion-body text-muted">We recommend booking ahead by phone so we can match you with the right dentist and time slot, though we do our best to accommodate urgent walk-ins.</div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#f2">
                                How do I book an appointment?
                            </button>
                        </h2>
                        <div id="f2" class="accordion-collapse collapse" data-bs-parent="#publicFaq">
                            <div class="accordion-body text-muted">Call us on the number below, or send a message through the Contact form and our front desk will get back to you to confirm a time.</div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#f3">
                                Will I know the cost before treatment?
                            </button>
                        </h2>
                        <div id="f3" class="accordion-collapse collapse" data-bs-parent="#publicFaq">
                            <div class="accordion-body text-muted">Yes - our billing system calculates your total from a fixed consultation fee plus the exact treatment cost, and we're happy to talk through pricing before you commit to a procedure.</div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#f4">
                                Do you treat children?
                            </button>
                        </h2>
                        <div id="f4" class="accordion-collapse collapse" data-bs-parent="#publicFaq">
                            <div class="accordion-body text-muted">Yes, we welcome patients of all ages and take extra care to make younger patients feel comfortable.</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============== CONTACT ============== -->
<div class="container my-5">
    <section id="contact" class="py-5 scroll-mt contact-section">
        <div class="container px-4">
            <div class="text-center mb-5">
                <span class="section-eyebrow text-info">Get In Touch</span>
                <h2 class="fw-bold text-white">Contact Us</h2>
            </div>
            <div class="row g-4">
                <div class="col-lg-5">
                    <div class="contact-info-card p-4 h-100">
                        <div class="d-flex align-items-start gap-3 mb-4">
                            <div class="contact-icon">
                                <i class="bi bi-geo-alt-fill"></i>
                            </div>
                            <div>
                                <div class="fw-semibold text-white">Address</div>
                                <div class="text-white-50 small">245 Galle Road, Colombo 03, Sri Lanka</div>
                                <a class="small text-info text-decoration-none" href="https://www.google.com/maps/search/?api=1&query=245+Galle+Road+Colombo+03+Sri+Lanka" target="_blank" rel="noopener">Get Directions <i class="bi bi-box-arrow-up-right"></i></a>
                            </div>
                        </div>
                        <div class="d-flex align-items-start gap-3 mb-4">
                            <div class="contact-icon">
                                <i class="bi bi-telephone-fill"></i>
                            </div>
                            <div>
                                <div class="fw-semibold text-white">Phone</div>
                                <a class="text-white-50 text-decoration-none small" href="tel:+94112345678">+94 11 234 5678</a>
                            </div>
                        </div>
                        <div class="d-flex align-items-start gap-3 mb-4">
                            <div class="contact-icon">
                                <i class="bi bi-envelope-fill"></i>
                            </div>
                            <div>
                                <div class="fw-semibold text-white">Email</div>
                                <a class="text-white-50 text-decoration-none small" href="mailto:info@sunrisedental.lk">info@sunrisedental.lk</a>
                            </div>
                        </div>
                        <div class="d-flex align-items-start gap-3">
                            <div class="contact-icon">
                                <i class="bi bi-clock-fill"></i>
                            </div>
                            <div>
                                <div class="fw-semibold text-white">Opening Hours</div>
                                <div class="text-white-50 small">Mon - Fri: 8:00 AM - 6:00 PM</div>
                                <div class="text-white-50 small">Saturday: 9:00 AM - 4:00 PM</div>
                                <div class="text-white-50 small">Sunday: Emergency cases only</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="card p-4 p-md-5">
                        <c:if test="${not empty contactSuccess}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="bi bi-check-circle-fill me-2"></i> <c:out value="${contactSuccess}"/>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        <c:if test="${not empty contactError}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i> <c:out value="${contactError}"/>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        <form method="post" action="<%=request.getContextPath()%>/PublicContactServlet" id="contactForm">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label text-dark fw-semibold">Your Name *</label>
                                    <input type="text" name="fullName" class="form-control" required value="${f_contactName}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label text-dark fw-semibold">Email *</label>
                                    <input type="email" name="email" class="form-control" required value="${f_contactEmail}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label text-dark fw-semibold">Phone</label>
                                    <input type="text" name="phone" class="form-control" value="${f_contactPhone}">
                                </div>
                                <div class="col-12">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <label class="form-label text-dark fw-semibold mb-0">Message *</label>
                                        <span class="small text-muted" id="charCounter">0 / 500</span>
                                    </div>
                                    <textarea name="message" id="contactMessage" class="form-control" rows="4" maxlength="500" required>${f_contactMessage}</textarea>
                                </div>
                                <div class="col-12 mt-4">
                                    <button type="submit" class="btn btn-clinic w-100"><i class="bi bi-send me-1"></i> Send Message</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<!-- ============== FOOTER ============== -->
<footer class="public-footer py-5 mt-5">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <img src="<%=request.getContextPath()%>/images/logo.svg" alt="Sunrise Dental Clinic logo" width="36" height="36">
                    <span class="fw-bold text-white fs-5">Sunrise Dental Clinic</span>
                </div>
                <p class="text-white-50 small mb-0">Your smile, our sunrise. Quality dental care for the whole family, right here in Colombo.</p>
            </div>
            <div class="col-md-4">
                <h6 class="text-white fw-bold mb-3">Quick Links</h6>
                <ul class="list-unstyled small">
                    <li class="mb-2"><a href="#services" class="footer-link">Services</a></li>
                    <li class="mb-2"><a href="#estimator" class="footer-link">Cost Estimator</a></li>
                    <li class="mb-2"><a href="#dentists" class="footer-link">Our Dentists</a></li>
                    <li class="mb-2"><a href="#faq" class="footer-link">FAQ</a></li>
                    <li class="mb-2"><a href="#contact" class="footer-link">Contact</a></li>
                    <li class="mb-2"><a href="<%=request.getContextPath()%>/login.jsp" class="footer-link">Staff Login</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h6 class="text-white fw-bold mb-3">Reach Us</h6>
                <p class="text-white-50 small mb-1"><i class="bi bi-geo-alt me-1"></i> 245 Galle Road, Colombo 03</p>
                <p class="text-white-50 small mb-1"><i class="bi bi-telephone me-1"></i> +94 11 234 5678</p>
                <p class="text-white-50 small mb-0"><i class="bi bi-envelope me-1"></i> info@sunrisedental.lk</p>
            </div>
        </div>
        <hr class="border-secondary my-4">
        <div class="text-center text-white-50 small">
            &copy; <%= java.time.Year.now() %> Sunrise Dental Clinic. All rights reserved.
        </div>
    </div>
</footer>

<!-- Floating Back to Top Button -->
<button type="button" id="backToTopBtn" class="btn btn-clinic btn-back-to-top" aria-label="Back to Top">
    <i class="bi bi-arrow-up"></i>
</button>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const consultationFee = 500.00;

    // 1. Back to Top Button
    const backToTopBtn = document.getElementById('backToTopBtn');
    window.addEventListener('scroll', function () {
        if (window.scrollY > 300) {
            backToTopBtn.style.display = 'block';
        } else {
            backToTopBtn.style.display = 'none';
        }
    });
    backToTopBtn.addEventListener('click', function () {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });

    // 2. Interactive Cost Estimator
    const estimatorSelect = document.getElementById('estimatorSelect');
    const calcServicesCost = document.getElementById('calcServicesCost');
    const calcTotalCost = document.getElementById('calcTotalCost');
    const applyEstimateBtn = document.getElementById('applyEstimateToContactBtn');
    const contactMessage = document.getElementById('contactMessage');

    function updateEstimator() {
        if (!estimatorSelect) return;
        let selectedServicesCost = 0;
        let selectedNames = [];

        Array.from(estimatorSelect.selectedOptions).forEach(option => {
            selectedServicesCost += parseFloat(option.value || 0);
            selectedNames.push(option.getAttribute('data-name'));
        });

        const total = selectedServicesCost + consultationFee;
        calcServicesCost.textContent = 'Rs. ' + selectedServicesCost.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        calcTotalCost.textContent = 'Rs. ' + total.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2});

        return { selectedNames, total };
    }

    if (estimatorSelect) {
        estimatorSelect.addEventListener('change', updateEstimator);
    }

    if (applyEstimateBtn) {
        applyEstimateBtn.addEventListener('click', function() {
            const { selectedNames, total } = updateEstimator();
            let msg = "Hello, I would like to book an appointment.";
            if (selectedNames.length > 0) {
                msg += " I am interested in: " + selectedNames.join(', ') + ". Estimated Total: Rs. " + total.toLocaleString('en-US', {minimumFractionDigits: 2, maximumFractionDigits: 2}) + " (includes consultation fee).";
            }
            contactMessage.value = msg;
            updateCharCounter();
            document.getElementById('contact').scrollIntoView({ behavior: 'smooth' });
        });
    }

    // 3. Quick-Book Triggers
    document.querySelectorAll('.quick-book-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const serviceName = this.getAttribute('data-service');
            contactMessage.value = `Hello, I would like to book an appointment for ${serviceName}. Please contact me regarding available slots.`;
            updateCharCounter();
            document.getElementById('contact').scrollIntoView({ behavior: 'smooth' });
        });
    });

    document.querySelectorAll('.quick-dentist-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const dentistName = this.getAttribute('data-dentist');
            contactMessage.value = `Hello, I would like to request a consultation with ${dentistName}. Please let me know their upcoming availability.`;
            updateCharCounter();
            document.getElementById('contact').scrollIntoView({ behavior: 'smooth' });
        });
    });

    // 4. Real-time Service Search
    const serviceSearchInput = document.getElementById('serviceSearchInput');
    const clearServiceSearch = document.getElementById('clearServiceSearch');
    const serviceItems = document.querySelectorAll('.service-item-wrapper');

    if (serviceSearchInput) {
        serviceSearchInput.addEventListener('input', function() {
            const query = this.value.toLowerCase().trim();
            serviceItems.forEach(item => {
                const name = (item.getAttribute('data-name') || '').toLowerCase();
                item.style.display = name.includes(query) ? 'block' : 'none';
            });
        });

        clearServiceSearch.addEventListener('click', function() {
            serviceSearchInput.value = '';
            serviceItems.forEach(item => item.style.display = 'block');
        });
    }

    // 5. FAQ Expand/Collapse
    const expandFaqBtn = document.getElementById('expandFaqBtn');
    const collapseFaqBtn = document.getElementById('collapseFaqBtn');
    const faqCollapses = document.querySelectorAll('#publicFaq .accordion-collapse');

    if (expandFaqBtn && collapseFaqBtn) {
        expandFaqBtn.addEventListener('click', function() {
            faqCollapses.forEach(el => bootstrap.Collapse.getOrCreateInstance(el, { toggle: false }).show());
        });

        collapseFaqBtn.addEventListener('click', function() {
            faqCollapses.forEach(el => bootstrap.Collapse.getOrCreateInstance(el, { toggle: false }).hide());
        });
    }

    // 6. Character Counter
    const charCounter = document.getElementById('charCounter');
    function updateCharCounter() {
        if (contactMessage && charCounter) {
            charCounter.textContent = `${contactMessage.value.length} / 500`;
        }
    }
    if (contactMessage) {
        contactMessage.addEventListener('input', updateCharCounter);
        updateCharCounter();
    }
});
</script>
</body>
</html>