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
    
    <!-- Schema.org JSON-LD Structured Data for Local SEO -->
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@type": "Dentist",
      "name": "Sunrise Dental Clinic",
      "image": "https://images.unsplash.com/photo-1629909613654-28e377c37b09?auto=format&fit=crop&w=800&q=80",
      "telephone": "+94112345678",
      "priceRange": "Rs. 1000 - 50000",
      "address": {
        "@type": "PostalAddress",
        "streetAddress": "245 Galle Road",
        "addressLocality": "Colombo 03",
        "addressCountry": "LK"
      },
      "openingHoursSpecification": [
        {
          "@type": "OpeningHoursSpecification",
          "dayOfWeek": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
          "opens": "08:00",
          "closes": "18:00"
        },
        {
          "@type": "OpeningHoursSpecification",
          "dayOfWeek": ["Saturday"],
          "opens": "09:00",
          "closes": "16:00"
        }
      ]
    }
    </script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
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

        /* Emergency Bar */
        .emergency-bar {
            background: #dc2626;
            color: #ffffff;
            font-size: 0.85rem;
            font-weight: 500;
        }

        /* Navbar Enhancements */
        .public-navbar {
            background: rgba(10, 37, 64, 0.92) !important;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
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

        .hero-image-frame {
            position: relative;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.4);
            border: 4px solid rgba(255, 255, 255, 0.15);
        }

        .hero-image-frame img {
            width: 100%;
            height: 420px;
            object-fit: cover;
            display: block;
        }

        .hero-wave svg {
            display: block;
            margin-bottom: -1px;
        }

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
            overflow: hidden;
        }

        .service-card:hover, .dentist-card:hover, .feature-box:hover, .testimonial-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--card-shadow-hover);
            border-color: rgba(14, 116, 144, 0.2);
        }

        .service-thumb-wrap {
            height: 180px;
            overflow: hidden;
            position: relative;
        }

        .service-thumb-wrap img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .service-card:hover .service-thumb-wrap img {
            transform: scale(1.08);
        }

        .service-price {
            font-size: 1.1rem;
            color: var(--primary-dark);
            background: #f1f5f9;
            padding: 6px 14px;
            border-radius: 10px;
            display: inline-block;
        }

        .dentist-img-wrap {
            height: 240px;
            overflow: hidden;
            position: relative;
            background: #e2e8f0;
        }

        .dentist-img-wrap img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: top center;
            transition: transform 0.4s ease;
        }

        .dentist-card:hover .dentist-img-wrap img {
            transform: scale(1.05);
        }

        .before-after-img {
            border-radius: 16px;
            overflow: hidden;
            position: relative;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .before-after-img img {
            width: 100%;
            height: 220px;
            object-fit: cover;
        }

        .before-after-badge {
            position: absolute;
            top: 12px;
            left: 12px;
            background: rgba(10, 37, 64, 0.85);
            color: #fff;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            backdrop-filter: blur(4px);
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
        }

        .stat-card-hero {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 14px;
        }

        .step-indicator {
            height: 4px;
            background: #e2e8f0;
            border-radius: 2px;
        }

        .step-indicator.active {
            background: var(--primary-blue);
        }
    </style>
</head>
<body class="public-site" data-bs-spy="scroll" data-bs-target="#publicNav" data-bs-offset="80" tabindex="0">

<!-- ============== EMERGENCY CALLOUT BANNER ============== -->
<div class="emergency-bar py-2 px-3 text-center d-flex justify-content-center align-items-center gap-2">
    <span><i class="bi bi-exclamation-triangle-fill me-1"></i> Dental Emergency or Severe Pain? We prioritize urgent cases.</span>
    <a href="tel:+94112345678" class="badge bg-white text-danger text-decoration-none fw-bold px-2 py-1"><i class="bi bi-telephone-fill me-1"></i> Call +94 11 234 5678</a>
</div>

<!-- ============== PUBLIC NAVBAR ============== -->
<nav class="navbar navbar-expand-lg navbar-dark public-navbar sticky-top" id="publicNav">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center gap-2 fw-bold text-white" href="<%=request.getContextPath()%>/PublicHomeServlet">
            <img src="<%=request.getContextPath()%>/images/logo.svg" alt="Sunrise Dental Clinic logo" width="38" height="38" loading="lazy">
            <span>Sunrise Dental Clinic</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#publicNavCollapse" aria-controls="publicNavCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="publicNavCollapse">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-lg-center">
                <li class="nav-item"><a class="nav-link nav-underline text-white active" href="#home">Home</a></li>
                <li class="nav-item"><a class="nav-link nav-underline text-white" href="#services">Services</a></li>
                <li class="nav-item"><a class="nav-link nav-underline text-white" href="#transformations">Results</a></li>
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

<!-- ============== HERO SECTION WITH CLINIC IMAGE ============== -->
<header id="home" class="hero-section scroll-mt">
    <div class="container py-5">
        <div class="row align-items-center g-5 py-3">
            <div class="col-lg-6">
                <span class="badge hero-badge mb-3"><i class="bi bi-stars me-1"></i> Trusted Dental Care in Colombo</span>
                <h1 class="display-4 fw-bold text-white mb-3">Your Smile, <span class="hero-accent">Our Sunrise.</span></h1>
                <p class="lead text-white-50 mb-4">
                    From routine checkups to specialist orthodontic and surgical care, Sunrise Dental Clinic
                    combines state-of-the-art dental technology with a warm, patient-first environment.
                </p>
                <div class="d-flex flex-wrap gap-3">
                    <button type="button" class="btn btn-clinic btn-lg px-4" data-bs-toggle="modal" data-bs-target="#quickBookingModal">
                        <i class="bi bi-calendar-check me-1"></i> Book Appointment
                    </button>
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
            </div>

            <!-- Hero Feature Image -->
            <div class="col-lg-6">
                <div class="hero-image-frame">
                    <img src="https://images.unsplash.com/photo-1629909613654-28e377c37b09?auto=format&fit=crop&w=800&q=80" alt="Modern Sunrise Dental Clinic Facility" loading="eager">
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

<!-- ============== SERVICES SECTION WITH IMAGES ============== -->
<section id="services" class="py-5 scroll-mt">
    <div class="container py-4">
        <div class="text-center mb-4">
            <span class="section-eyebrow">What We Offer</span>
            <h2 class="fw-bold text-dark">Our Services</h2>
            <p class="text-muted col-lg-6 mx-auto">Explore our range of general and specialized dental treatments designed for healthy, lasting smiles.</p>
        </div>

        <div class="row justify-content-center mb-4">
            <div class="col-md-6 col-lg-5">
                <div class="input-group input-group-lg shadow-sm">
                    <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="serviceSearchInput" class="form-control border-start-0" placeholder="Search e.g., Whitening, Cleaning, Braces...">
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
                                    <div class="card service-card h-100 d-flex flex-column justify-content-between">
                                        <div>
                                            <!-- Dynamic / Fallback Treatment Thumbnail Image -->
                                            <div class="service-thumb-wrap">
                                                <img src="https://images.unsplash.com/photo-1609840114035-3c981b782dfe?auto=format&fit=crop&w=500&q=80" alt="${t.treatmentName}" loading="lazy">
                                            </div>
                                            <div class="p-4">
                                                <div class="d-flex justify-content-between align-items-center mb-2">
                                                    <h5 class="fw-bold text-dark mb-0"><c:out value="${t.treatmentName}"/></h5>
                                                    <span class="badge bg-info-subtle text-info-emphasis fw-semibold">Verified</span>
                                                </div>
                                                <p class="text-muted small mb-3">State-of-the-art procedure delivered by certified dental professionals.</p>
                                            </div>
                                        </div>
                                        <div class="px-4 pb-4">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <span class="text-muted small">Treatment Cost:</span>
                                                <div class="service-price fw-bold">
                                                    Rs. <fmt:formatNumber value="${t.cost}" pattern="#,##0.00"/>
                                                </div>
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
        <p class="text-center text-muted small mt-4 mb-0">Prices shown reflect single treatment costs; a standard consultation fee (Rs. 1,000.00) applies per appointment.</p>
    </div>
</section>

<!-- ============== BEFORE & AFTER TRANSFORMATIONS ============== -->
<section id="transformations" class="py-5 scroll-mt bg-white border-top border-bottom">
    <div class="container py-4">
        <div class="text-center mb-5">
            <span class="section-eyebrow">Real Patient Results</span>
            <h2 class="fw-bold text-dark">Smile Transformations</h2>
            <p class="text-muted col-lg-6 mx-auto">See the visible difference professional whitening, alignment, and restorative dentistry make.</p>
        </div>
        <div class="row g-4">
            <div class="col-md-6 col-lg-4">
                <div class="card p-3 shadow-sm border-0 rounded-4">
                    <div class="row g-2">
                        <div class="col-6">
                            <div class="before-after-img">
                                <span class="before-after-badge">BEFORE</span>
                                <img src="https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?auto=format&fit=crop&w=400&q=80" alt="Teeth Before Whitening" loading="lazy">
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="before-after-img">
                                <span class="before-after-badge bg-success">AFTER</span>
                                <img src="https://images.unsplash.com/photo-1606811841689-23dfddce3e95?auto=format&fit=crop&w=400&q=80" alt="Teeth After Whitening" loading="lazy">
                            </div>
                        </div>
                    </div>
                    <div class="mt-3 text-center">
                        <h6 class="fw-bold text-dark mb-1">Laser Teeth Whitening</h6>
                        <span class="small text-muted">2-Shade Lighter in 1 Session</span>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-4">
                <div class="card p-3 shadow-sm border-0 rounded-4">
                    <div class="row g-2">
                        <div class="col-6">
                            <div class="before-after-img">
                                <span class="before-after-badge">BEFORE</span>
                                <img src="https://images.unsplash.com/photo-1598256989800-fe5f95da9787?auto=format&fit=crop&w=400&q=80" alt="Misaligned Teeth Before Braces" loading="lazy">
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="before-after-img">
                                <span class="before-after-badge bg-success">AFTER</span>
                                <img src="https://images.unsplash.com/photo-1571772996211-2f02c9727629?auto=format&fit=crop&w=400&q=80" alt="Aligned Teeth After Orthodontics" loading="lazy">
                            </div>
                        </div>
                    </div>
                    <div class="mt-3 text-center">
                        <h6 class="fw-bold text-dark mb-1">Clear Aligner Therapy</h6>
                        <span class="small text-muted">12 Months Alignment Plan</span>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-4">
                <div class="card p-3 shadow-sm border-0 rounded-4">
                    <div class="row g-2">
                        <div class="col-6">
                            <div class="before-after-img">
                                <span class="before-after-badge">BEFORE</span>
                                <img src="https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?auto=format&fit=crop&w=400&q=80" alt="Chipped Teeth Before Restoration" loading="lazy">
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="before-after-img">
                                <span class="before-after-badge bg-success">AFTER</span>
                                <img src="https://images.unsplash.com/photo-1606811841689-23dfddce3e95?auto=format&fit=crop&w=400&q=80" alt="Restored Veneer Smile" loading="lazy">
                            </div>
                        </div>
                    </div>
                    <div class="mt-3 text-center">
                        <h6 class="fw-bold text-dark mb-1">Porcelain Crown & Composite</h6>
                        <span class="small text-muted">Natural Aesthetic Restorations</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============== COST ESTIMATOR ============== -->
<section id="estimator" class="py-5 scroll-mt">
    <div class="container py-3">
        <div class="row align-items-center g-4">
            <div class="col-lg-5">
                <span class="section-eyebrow">Instant Fee Estimator</span>
                <h2 class="fw-bold text-dark mb-3">Calculate Expected Total</h2>
                <p class="text-muted">Select your planned treatments below to calculate an estimated total cost including our standard consultation fee (Rs. 1,000.00). No hidden charges.</p>
                <ul class="list-unstyled text-muted small">
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Transparent upfront breakdown</li>
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Combines multiple services instantly</li>
                    <li class="mb-2"><i class="bi bi-check-circle-fill text-success me-2"></i> Direct booking integration</li>
                </ul>
            </div>
            <div class="col-lg-7">
                <div class="card p-4 border-0 shadow-sm rounded-4 bg-white">
                    <h5 class="fw-bold text-dark mb-3 d-flex align-items-center gap-2">
                        <i class="bi bi-calculator text-primary"></i> Treatment Estimator Tool
                    </h5>
                    
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-secondary">Select Treatment(s):</label>
                        <select id="estimatorSelect" class="form-select border shadow-sm" multiple size="4">
                            <c:forEach var="t" items="${activeTreatments}">
                                <option value="${t.cost}" data-name="${t.treatmentName}">
                                    ${t.treatmentName} - Rs. <fmt:formatNumber value="${t.cost}" pattern="#,##0.00"/>
                                </option>
                            </c:forEach>
                        </select>
                        <span class="form-text text-muted extra-small">Hold <kbd>Ctrl</kbd> (or <kbd>Cmd</kbd> on Mac) to select multiple services.</span>
                    </div>

                    <div class="p-3 bg-light rounded-3 border mb-3">
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

<!-- ============== DENTISTS SECTION WITH PORTRAITS ============== -->
<section id="dentists" class="py-5 scroll-mt bg-white border-top">
    <div class="container py-4">
        <div class="text-center mb-5">
            <span class="section-eyebrow">Meet The Team</span>
            <h2 class="fw-bold text-dark">Our Dental Specialists</h2>
            <p class="text-muted col-lg-6 mx-auto">Experienced, approachable, and dedicated to making every dental visit comfortable and stress-free.</p>
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
                                    <div class="card dentist-card p-0 h-100 d-flex flex-column justify-content-between">
                                        <div>
                                            <!-- Realistic Dentist Portrait Image Sample Array -->
                                            <div class="dentist-img-wrap">
                                                <c:choose>
                                                    <c:when test="${status.index % 3 == 0}">
                                                        <img src="https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=500&q=80" alt="${d.dentistName}" loading="lazy">
                                                    </c:when>
                                                    <c:when test="${status.index % 3 == 1}">
                                                        <img src="https://images.unsplash.com/photo-1594824813566-7885a3978087?auto=format&fit=crop&w=500&q=80" alt="${d.dentistName}" loading="lazy">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=500&q=80" alt="${d.dentistName}" loading="lazy">
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="p-4 text-center">
                                                <span class="badge bg-success-subtle text-success-emphasis rounded-pill small mb-2"><i class="bi bi-clock me-1"></i> Available Today</span>
                                                <h5 class="fw-bold mb-1 text-dark"><c:out value="${d.dentistName}"/></h5>
                                                <p class="text-muted small mb-0"><c:out value="${d.specialization}"/></p>
                                            </div>
                                        </div>
                                        <div class="px-4 pb-4">
                                            <button type="button" class="btn btn-outline-secondary btn-sm w-100 quick-dentist-btn rounded-3" data-dentist="${d.dentistName}">
                                                <i class="bi bi-calendar-event me-1"></i> Request Doctor
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
<section id="why-us" class="py-5 scroll-mt border-top">
    <div class="container py-4">
        <div class="text-center mb-5">
            <span class="section-eyebrow">Why Sunrise</span>
            <h2 class="fw-bold text-dark">Why Patients Choose Us</h2>
        </div>
        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="feature-box text-center p-4 h-100">
                    <div class="mb-3 text-primary fs-1">
                        <i class="bi bi-award"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-2">Experienced Specialists</h6>
                    <p class="text-muted small mb-0">Qualified dentists across general, orthodontic and surgical care.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="feature-box text-center p-4 h-100">
                    <div class="mb-3 text-primary fs-1">
                        <i class="bi bi-cpu"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-2">Modern Equipment</h6>
                    <p class="text-muted small mb-0">Up-to-date tools and high-grade sterilization for safer visits.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="feature-box text-center p-4 h-100">
                    <div class="mb-3 text-primary fs-1">
                        <i class="bi bi-calendar2-check"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-2">Easy Scheduling</h6>
                    <p class="text-muted small mb-0">Computerised booking system to minimize waiting time.</p>
                </div>
            </div>
            <div class="col-md-6 col-lg-3">
                <div class="feature-box text-center p-4 h-100">
                    <div class="mb-3 text-primary fs-1">
                        <i class="bi bi-heart"></i>
                    </div>
                    <h6 class="fw-bold text-dark mt-2">Patient-First Care</h6>
                    <p class="text-muted small mb-0">Clear explanations, transparent billing, and gentle care.</p>
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
                            <div class="accordion-body text-muted">We recommend booking ahead by phone or website so we can assign your preferred doctor and slot, though urgent walk-ins are prioritized.</div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#f2">
                                How do I book an appointment?
                            </button>
                        </h2>
                        <div id="f2" class="accordion-collapse collapse" data-bs-parent="#publicFaq">
                            <div class="accordion-body text-muted">Click the "Book Appointment" button at the top to complete our 3-step wizard or fill out the contact form below.</div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#f3">
                                Will I know the total cost before treatment?
                            </button>
                        </h2>
                        <div id="f3" class="accordion-collapse collapse" data-bs-parent="#publicFaq">
                            <div class="accordion-body text-muted">Yes - you can use our built-in Cost Estimator tool above to review fixed treatment costs and consultation fees in advance.</div>
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
                            <div class="contact-icon text-cyan fs-4">
                                <i class="bi bi-geo-alt-fill text-info"></i>
                            </div>
                            <div>
                                <div class="fw-semibold text-white">Address</div>
                                <div class="text-white-50 small">245 Galle Road, Colombo 03, Sri Lanka</div>
                                <a class="small text-info text-decoration-none" href="https://www.google.com/maps/search/?api=1&query=245+Galle+Road+Colombo+03+Sri+Lanka" target="_blank" rel="noopener">Get Directions <i class="bi bi-box-arrow-up-right"></i></a>
                            </div>
                        </div>
                        <div class="d-flex align-items-start gap-3 mb-4">
                            <div class="contact-icon text-cyan fs-4">
                                <i class="bi bi-telephone-fill text-info"></i>
                            </div>
                            <div>
                                <div class="fw-semibold text-white">Phone</div>
                                <a class="text-white-50 text-decoration-none small" href="tel:+94112345678">+94 11 234 5678</a>
                            </div>
                        </div>
                        <div class="d-flex align-items-start gap-3 mb-4">
                            <div class="contact-icon text-cyan fs-4">
                                <i class="bi bi-envelope-fill text-info"></i>
                            </div>
                            <div>
                                <div class="fw-semibold text-white">Email</div>
                                <a class="text-white-50 text-decoration-none small" href="mailto:info@sunrisedental.lk">info@sunrisedental.lk</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="card p-4 p-md-5 border-0">
                        <div id="contactAlertPlaceholder"></div>
                        <form id="contactForm">
                            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">

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
                                    <label class="form-label text-dark fw-semibold">Phone *</label>
                                    <input type="tel" name="phone" class="form-control" pattern="^(?:0|\+94)[0-9]{9}$" placeholder="+94 7X XXX XXXX" required value="${f_contactPhone}">
                                </div>
                                <div class="col-12">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <label class="form-label text-dark fw-semibold mb-0">Message *</label>
                                        <span class="small text-muted" id="charCounter">0 / 500</span>
                                    </div>
                                    <textarea name="message" id="contactMessage" class="form-control" rows="4" maxlength="500" required>${f_contactMessage}</textarea>
                                </div>
                                <div class="col-12 mt-4">
                                    <button type="submit" id="submitContactBtn" class="btn btn-clinic w-100">
                                        <span class="spinner-border spinner-border-sm d-none me-1" id="contactSpinner"></span>
                                        <i class="bi bi-send me-1" id="contactBtnIcon"></i> Send Message
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<!-- ============== QUICK STEP-BY-STEP BOOKING MODAL ============== -->
<div class="modal fade" id="quickBookingModal" tabindex="-1" aria-labelledby="quickBookingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold text-dark" id="quickBookingModalLabel"><i class="bi bi-calendar-event text-primary me-2"></i>Schedule Your Visit</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
                <div class="row g-2 mb-4">
                    <div class="col-4"><div class="step-indicator active" id="stepInd1"></div></div>
                    <div class="col-4"><div class="step-indicator" id="stepInd2"></div></div>
                    <div class="col-4"><div class="step-indicator" id="stepInd3"></div></div>
                </div>

                <form id="wizardBookingForm">
                    <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                    
                    <div id="bookingStep1">
                        <h6 class="fw-bold mb-3 text-secondary">Step 1: Choose Details</h6>
                        <div class="mb-3">
                            <label class="form-label text-dark fw-semibold">Preferred Treatment</label>
                            <select class="form-select" id="wizardServiceSelect">
                                <option value="">General Checkup / Consultation</option>
                                <c:forEach var="t" items="${activeTreatments}">
                                    <option value="${t.treatmentName}">${t.treatmentName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-dark fw-semibold">Preferred Doctor (Optional)</label>
                            <select class="form-select" id="wizardDentistSelect">
                                <option value="">Any Available Specialist</option>
                                <c:forEach var="d" items="${activeDentists}">
                                    <option value="${d.dentistName}">${d.dentistName} (${d.specialization})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="text-end mt-4">
                            <button type="button" class="btn btn-clinic" onclick="goToStep(2)">Next: Date & Time <i class="bi bi-arrow-right"></i></button>
                        </div>
                    </div>

                    <div id="bookingStep2" class="d-none">
                        <h6 class="fw-bold mb-3 text-secondary">Step 2: Schedule Preference</h6>
                        <div class="mb-3">
                            <label class="form-label text-dark fw-semibold">Preferred Date *</label>
                            <input type="date" class="form-control" id="wizardDate" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-dark fw-semibold">Preferred Time Slot *</label>
                            <select class="form-select" id="wizardTime" required>
                                <option value="Morning (08:00 AM - 12:00 PM)">Morning (08:00 AM - 12:00 PM)</option>
                                <option value="Afternoon (12:00 PM - 04:00 PM)">Afternoon (12:00 PM - 04:00 PM)</option>
                                <option value="Evening (04:00 PM - 06:00 PM)">Evening (04:00 PM - 06:00 PM)</option>
                            </select>
                        </div>
                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-outline-secondary" onclick="goToStep(1)">Back</button>
                            <button type="button" class="btn btn-clinic" onclick="goToStep(3)">Next: Your Info <i class="bi bi-arrow-right"></i></button>
                        </div>
                    </div>

                    <div id="bookingStep3" class="d-none">
                        <h6 class="fw-bold mb-3 text-secondary">Step 3: Contact Details</h6>
                        <div class="mb-3">
                            <label class="form-label text-dark fw-semibold">Full Name *</label>
                            <input type="text" class="form-control" id="wizardName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-dark fw-semibold">Phone Number *</label>
                            <input type="tel" class="form-control" id="wizardPhone" pattern="^(?:0|\+94)[0-9]{9}$" placeholder="+94 7X XXX XXXX" required>
                        </div>
                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-outline-secondary" onclick="goToStep(2)">Back</button>
                            <button type="submit" class="btn btn-success"><i class="bi bi-check-circle me-1"></i> Confirm Booking Request</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- ============== FOOTER ============== -->
<footer class="public-footer py-5 mt-5">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <img src="<%=request.getContextPath()%>/images/logo.svg" alt="Sunrise Dental Clinic logo" width="36" height="36" loading="lazy">
                    <span class="fw-bold text-white fs-5">Sunrise Dental Clinic</span>
                </div>
                <p class="text-white-50 small mb-0">Your smile, our sunrise. Quality dental care for the whole family, right here in Colombo.</p>
            </div>
            <div class="col-md-4">
                <h6 class="text-white fw-bold mb-3">Quick Links</h6>
                <ul class="list-unstyled small">
                    <li class="mb-2"><a href="#services" class="footer-link">Services</a></li>
                    <li class="mb-2"><a href="#transformations" class="footer-link">Results</a></li>
                    <li class="mb-2"><a href="#estimator" class="footer-link">Cost Estimator</a></li>
                    <li class="mb-2"><a href="#dentists" class="footer-link">Our Dentists</a></li>
                    <li class="mb-2"><a href="#contact" class="footer-link">Contact</a></li>
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

<button type="button" id="backToTopBtn" class="btn btn-clinic btn-back-to-top" aria-label="Back to Top">
    <i class="bi bi-arrow-up"></i>
</button>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const consultationFee = 500.00;

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

    const contactForm = document.getElementById('contactForm');
    const contactAlert = document.getElementById('contactAlertPlaceholder');
    const submitBtn = document.getElementById('submitContactBtn');
    const spinner = document.getElementById('contactSpinner');
    const btnIcon = document.getElementById('contactBtnIcon');

    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            spinner.classList.remove('d-none');
            btnIcon.classList.add('d-none');
            submitBtn.disabled = true;

            const formData = new URLSearchParams(new FormData(contactForm));

            fetch('<%=request.getContextPath()%>/PublicContactServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    contactAlert.innerHTML = `
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i> Thank you! Your message has been sent successfully.
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>`;
                    contactForm.reset();
                    updateCharCounter();
                } else {
                    throw new Error('Server returned an error');
                }
            })
            .catch(error => {
                contactAlert.innerHTML = `
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> Failed to send message. Please call us directly.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>`;
            })
            .finally(() => {
                spinner.classList.add('d-none');
                btnIcon.classList.remove('d-none');
                submitBtn.disabled = false;
            });
        });
    }

    window.goToStep = function(step) {
        document.getElementById('bookingStep1').classList.add('d-none');
        document.getElementById('bookingStep2').classList.add('d-none');
        document.getElementById('bookingStep3').classList.add('d-none');

        document.getElementById('stepInd1').classList.remove('active');
        document.getElementById('stepInd2').classList.remove('active');
        document.getElementById('stepInd3').classList.remove('active');

        document.getElementById('bookingStep' + step).classList.remove('d-none');
        for (let i = 1; i <= step; i++) {
            document.getElementById('stepInd' + i).classList.add('active');
        }
    };

    const wizardForm = document.getElementById('wizardBookingForm');
    if (wizardForm) {
        wizardForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const service = document.getElementById('wizardServiceSelect').value;
            const doctor = document.getElementById('wizardDentistSelect').value;
            const date = document.getElementById('wizardDate').value;
            const time = document.getElementById('wizardTime').value;
            const name = document.getElementById('wizardName').value;
            const phone = document.getElementById('wizardPhone').value;

            const message = `Booking Request:\n- Service: ${service || 'General Consultation'}\n- Doctor: ${doctor || 'Any'}\n- Date: ${date}\n- Slot: ${time}`;
            
            document.querySelector('[name="fullName"]').value = name;
            document.querySelector('[name="phone"]').value = phone;
            contactMessage.value = message;
            
            const modalEl = document.getElementById('quickBookingModal');
            const modal = bootstrap.Modal.getInstance(modalEl);
            modal.hide();

            document.getElementById('contact').scrollIntoView({ behavior: 'smooth' });
        });
    }
});
</script>
</body>
</html>