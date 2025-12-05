function initAOS() {
  try {
    AOS.init({
      once: true,
      disable: 'phone',
      duration: 1000,
      easing: 'ease-out-cubic',
    });
  } catch (_) {}
}

if ('requestIdleCallback' in window) {
  requestIdleCallback(initAOS, { timeout: 1500 });
} else {
  setTimeout(initAOS, 0);
}

// Initialize Swiper after DOM is stable to prevent forced reflows
function initSwipers() {
  const clientsEl = document.querySelectorAll('.clients-carousel');
  if (clientsEl.length > 0) {
    const clients = new Swiper('.clients-carousel', {
      slidesPerView: 'auto',
      spaceBetween: 64,
      centeredSlides: true,
      loop: true,
      speed: 5000,
      noSwiping: true,
      noSwipingClass: 'swiper-slide',
      autoplay: {
        delay: 0,
        disableOnInteraction: true,
      },
      observer: true,
      observeParents: true,
    });
  }

  const carouselEl = document.querySelectorAll('.stellar-carousel');
  if (carouselEl.length > 0) {
    const carousel = new Swiper('.stellar-carousel', {
      breakpoints: {
        320: {
          slidesPerView: 1
        },
        640: {
          slidesPerView: 2
        },
        1024: {
          slidesPerView: 3
        }
      },
      grabCursor: true,
      loop: false,
      centeredSlides: false,
      initialSlide: 0,
      spaceBetween: 24,
      navigation: {
        nextEl: '.carousel-next',
        prevEl: '.carousel-prev',
      },
      observer: true,
      observeParents: true,
    });
  }
}

// Use requestIdleCallback for non-critical Swiper init, fallback to setTimeout
if ('requestIdleCallback' in window) {
  requestIdleCallback(initSwipers, { timeout: 2000 });
} else {
  setTimeout(initSwipers, 1);
}

// Particle animation
class ParticleAnimation {
  constructor(el, { quantity = 30, staticity = 50, ease = 50 } = {}) {
    this.canvas = el;
    if (!this.canvas) return;
    this.canvasContainer = this.canvas.parentElement;
    this.context = this.canvas.getContext('2d');
    this.dpr = window.devicePixelRatio || 1;
    this.settings = {
      quantity: quantity,
      staticity: staticity,
      ease: ease,
    };
    this.circles = [];
    this.mouse = {
      x: 0,
      y: 0,
    };
    this.canvasSize = {
      w: 0,
      h: 0,
    };
    this.onMouseMove = this.onMouseMove.bind(this);
    this.initCanvas = this.initCanvas.bind(this);
    this.resizeCanvas = this.resizeCanvas.bind(this);
    this.drawCircle = this.drawCircle.bind(this);
    this.drawParticles = this.drawParticles.bind(this);
    this.remapValue = this.remapValue.bind(this);
    this.animate = this.animate.bind(this);
    this.init();
  }

  init() {
    this.initCanvas();
    this.animate();
    window.addEventListener('resize', this.initCanvas, { passive: true });
    window.addEventListener('mousemove', this.onMouseMove, { passive: true });
  }

  initCanvas() {
    // Batch DOM reads before writes
    requestAnimationFrame(() => {
      this.resizeCanvas();
      this.drawParticles();
    });
  }

  onMouseMove(event) {
    const { clientX, clientY } = event;
    // Batch the read operation
    const rect = this.canvas.getBoundingClientRect();
    const { w, h } = this.canvasSize;
    const x = clientX - rect.left - (w / 2);
    const y = clientY - rect.top - (h / 2);
    const inside = x < (w / 2) && x > -(w / 2) && y < (h / 2) && y > -(h / 2);
    if(inside) {
      this.mouse.x = x;
      this.mouse.y = y;
    }
  }

  resizeCanvas() {
    this.circles.length = 0;
    // Batch all DOM reads first
    const containerWidth = this.canvasContainer.offsetWidth;
    const containerHeight = this.canvasContainer.offsetHeight;
    
    // Then batch all DOM writes
    this.canvasSize.w = containerWidth;
    this.canvasSize.h = containerHeight;
    this.canvas.width = containerWidth * this.dpr;
    this.canvas.height = containerHeight * this.dpr;
    this.canvas.style.width = containerWidth + 'px';
    this.canvas.style.height = containerHeight + 'px';
    this.context.scale(this.dpr, this.dpr);
  }

  circleParams() {
    const x = Math.floor(Math.random() * this.canvasSize.w);
    const y = Math.floor(Math.random() * this.canvasSize.h);
    const translateX = 0;
    const translateY = 0;
    const size = Math.floor(Math.random() * 2) + 1;
    const alpha = 0;
    const targetAlpha = parseFloat((Math.random() * 0.6 + 0.1).toFixed(1));
    const dx = (Math.random() - 0.5) * 0.2;
    const dy = (Math.random() - 0.5) * 0.2;
    const magnetism = 0.1 + Math.random() * 4;
    return { x, y, translateX, translateY, size, alpha, targetAlpha, dx, dy, magnetism };
  }

  drawCircle(circle, update = false) {
    const { x, y, translateX, translateY, size, alpha } = circle;
    this.context.translate(translateX, translateY);
    this.context.beginPath();
    this.context.arc(x, y, size, 0, 2 * Math.PI);
    this.context.fillStyle = `rgba(255, 255, 255, ${alpha})`;
    this.context.fill();
    this.context.setTransform(this.dpr, 0, 0, this.dpr, 0, 0);
    if (!update) {
      this.circles.push(circle);
    }
  }

  clearContext() {
    this.context.clearRect(0, 0, this.canvasSize.w, this.canvasSize.h);
  }  

  drawParticles() {
    this.clearContext();
    const particleCount = this.settings.quantity;
    for (let i = 0; i < particleCount; i++) {
      const circle = this.circleParams();
      this.drawCircle(circle);
    }
  }

  // This function remaps a value from one range to another range
  remapValue(value, start1, end1, start2, end2) {
    const remapped = (value - start1) * (end2 - start2) / (end1 - start1) + start2;
    return remapped > 0 ? remapped : 0;
  }

  animate() {
    this.clearContext();
    
    // Batch all calculations before any DOM operations
    const { w: canvasWidth, h: canvasHeight } = this.canvasSize;
    const mouseX = this.mouse.x;
    const mouseY = this.mouse.y;
    const { staticity, ease } = this.settings;
    
    this.circles.forEach((circle, i) => {
      // Handle the alpha value - all reads done first
      const edge = [
        circle.x + circle.translateX - circle.size,
        canvasWidth - circle.x - circle.translateX - circle.size,
        circle.y + circle.translateY - circle.size,
        canvasHeight - circle.y - circle.translateY - circle.size,
      ];
      const closestEdge = edge.reduce((a, b) => Math.min(a, b));
      const remapClosestEdge = this.remapValue(closestEdge, 0, 20, 0, 1).toFixed(2);
      
      if(remapClosestEdge > 1) {
        circle.alpha += 0.02;
        if(circle.alpha > circle.targetAlpha) circle.alpha = circle.targetAlpha;
      } else {
        circle.alpha = circle.targetAlpha * remapClosestEdge;
      }
      
      circle.x += circle.dx;
      circle.y += circle.dy;
      circle.translateX += ((mouseX / (staticity / circle.magnetism)) - circle.translateX) / ease;
      circle.translateY += ((mouseY / (staticity / circle.magnetism)) - circle.translateY) / ease;
      
      // Check if circle is out of canvas
      if (circle.x < -circle.size || circle.x > canvasWidth + circle.size || 
          circle.y < -circle.size || circle.y > canvasHeight + circle.size) {
        this.circles.splice(i, 1);
        const newCircle = this.circleParams();
        this.drawCircle(newCircle);
      } else {
        this.drawCircle({ 
          ...circle, 
          x: circle.x, 
          y: circle.y, 
          translateX: circle.translateX, 
          translateY: circle.translateY, 
          alpha: circle.alpha 
        }, true);
      }
    });
    
    window.requestAnimationFrame(this.animate);
  }
}

function initParticles() {
  const canvasElements = document.querySelectorAll('[data-particle-animation]');
  canvasElements.forEach(canvas => {
    const options = {
      quantity: canvas.dataset.particleQuantity,
      staticity: canvas.dataset.particleStaticity,
      ease: canvas.dataset.particleEase,
    };
    new ParticleAnimation(canvas, options);
  });
}

if ('requestIdleCallback' in window) {
  requestIdleCallback(initParticles, { timeout: 2000 });
} else {
  setTimeout(initParticles, 1);
}


// Box highlighter - optimized to batch DOM reads and writes
class Highlighter {
  constructor(containerElement) {
    this.container = containerElement;
    this.boxes = Array.from(this.container.children);
    this.mouse = {
      x: 0,
      y: 0,
    };
    this.containerSize = {
      w: 0,
      h: 0,
    };
    this.rafId = null;
    this.isUpdating = false;
    this.initContainer = this.initContainer.bind(this);
    this.onMouseMove = this.onMouseMove.bind(this);
    this.updateBoxStyles = this.updateBoxStyles.bind(this);
    this.init();
  }

  initContainer() {
    // Batch DOM read
    const containerWidth = this.container.offsetWidth;
    const containerHeight = this.container.offsetHeight;
    
    // Then batch DOM writes
    this.containerSize.w = containerWidth;
    this.containerSize.h = containerHeight;
  }

  onMouseMove(event) {
    const { clientX, clientY } = event;
    // Cache rect to avoid repeated getBoundingClientRect calls
    if (!this.cachedRect || Date.now() - this.lastRectUpdate > 100) {
      this.cachedRect = this.container.getBoundingClientRect();
      this.lastRectUpdate = Date.now();
    }
    const rect = this.cachedRect;
    const { w, h } = this.containerSize;
    const x = clientX - rect.left;
    const y = clientY - rect.top;
    const inside = x < w && x > 0 && y < h && y > 0;
    if (inside) {
      this.mouse.x = x;
      this.mouse.y = y;
      // Use RAF to batch style updates
      if (!this.isUpdating) {
        this.isUpdating = true;
        this.rafId = requestAnimationFrame(this.updateBoxStyles);
      }
    }
  }

  updateBoxStyles() {
    // Get fresh container rect for accuracy
    const rect = this.container.getBoundingClientRect();
    
    // Batch all DOM reads first (geometry properties)
    const boxRects = this.boxes.map(box => box.getBoundingClientRect());
    
    // Then batch all DOM writes (style updates)
    this.boxes.forEach((box, index) => {
      const boxX = -(boxRects[index].left - rect.left) + this.mouse.x;
      const boxY = -(boxRects[index].top - rect.top) + this.mouse.y;
      box.style.setProperty('--mouse-x', `${boxX}px`);
      box.style.setProperty('--mouse-y', `${boxY}px`);
    });
    
    this.isUpdating = false;
  }

  init() {
    this.lastRectUpdate = 0;
    this.cachedRect = null;
    this.initContainer();
    
    // Debounced resize with longer delay to reduce reflow frequency
    let resizeTimeout;
    window.addEventListener('resize', () => {
      clearTimeout(resizeTimeout);
      resizeTimeout = setTimeout(() => {
        this.cachedRect = null; // Invalidate cache on resize
        this.initContainer();
      }, 150);
    }, { passive: true });
    
    window.addEventListener('mousemove', this.onMouseMove, { passive: true });
  }  
}

function initHighlighters() {
  const highlighters = document.querySelectorAll('[data-highlighter]');
  highlighters.forEach((highlighter) => {
    new Highlighter(highlighter);
  });
}

if ('requestIdleCallback' in window) {
  requestIdleCallback(initHighlighters, { timeout: 2000 });
} else {
  setTimeout(initHighlighters, 1);
}

// Make blog index card CTA "Read article →" clickable
(function() {
  const enhanceCTAs = () => {
    const sections = document.querySelectorAll('section#shopify, section#wordpress, section#core-web-vitals');
    if (sections.length === 0) return;
    const articles = document.querySelectorAll('section#shopify article, section#wordpress article, section#core-web-vitals article');
    articles.forEach(article => {
      const titleLink = article.querySelector('h3 a');
      // Look for any span containing "Read article" text
      const ctaSpan = Array.from(article.querySelectorAll('span')).find(s => (s.textContent || '').trim().startsWith('Read article'));
      if (titleLink && ctaSpan) {
        const href = titleLink.getAttribute('href');
        try {
          const ctaAnchor = document.createElement('a');
          ctaAnchor.setAttribute('href', href);
          ctaAnchor.setAttribute('class', ctaSpan.getAttribute('class') || 'inline-flex items-center text-sm font-medium');
          ctaAnchor.textContent = ctaSpan.textContent;
          ctaSpan.replaceWith(ctaAnchor);
        } catch (_) {
          // Fallback: make span behave like a link
          ctaSpan.style.cursor = 'pointer';
          ctaSpan.setAttribute('role', 'link');
          ctaSpan.setAttribute('tabindex', '0');
          ctaSpan.addEventListener('click', () => { location.href = href; });
          ctaSpan.addEventListener('keydown', (e) => { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); location.href = href; } });
          // Add a real anchor next to the span and hide the span to guarantee clickability
          const realAnchor = document.createElement('a');
          realAnchor.setAttribute('href', href);
          realAnchor.setAttribute('class', ctaSpan.getAttribute('class') || 'inline-flex items-center text-sm font-medium');
          realAnchor.textContent = ctaSpan.textContent;
          ctaSpan.insertAdjacentElement('afterend', realAnchor);
          ctaSpan.style.display = 'none';
        }
      }
    });
  };
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', enhanceCTAs);
  } else {
    enhanceCTAs();
  }
})();

// Global Back-to-Top button (avoids Crisp chat bubble)
(function() {
  // Create button element
  const btn = document.createElement('button');
  btn.className = 'back-to-top';
  btn.setAttribute('type', 'button');
  btn.setAttribute('aria-label', 'Back to top');
  btn.innerHTML = `
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
      <path d="M12 19V5" />
      <path d="M5 12l7-7 7 7" />
    </svg>
  `;

  // Smooth scroll to top
  btn.addEventListener('click', () => {
    try {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    } catch (_) {
      // Fallback for very old browsers
      window.scrollTo(0, 0);
    }
  });

  // Insert into DOM once body is ready
  const insert = () => document.body && document.body.appendChild(btn);
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', insert, { once: true });
  } else {
    insert();
  }

  // Show/Hide based on scroll distance
  const toggle = () => {
    if (window.scrollY > 200) {
      btn.classList.add('show');
    } else {
      btn.classList.remove('show');
    }
  };

  // Keep above Crisp chat bubble on all devices
  const adjustForChat = () => {
    const isMobile = window.matchMedia('(max-width: 640px)').matches;
    // Default offset above chat bubble (~24px from bottom). Place ~100-130px higher.
    btn.style.bottom = isMobile ? '132px' : '108px';
    btn.style.right = isMobile ? '16px' : '24px';
  };

  adjustForChat();
  toggle();
  window.addEventListener('scroll', toggle, { passive: true });
  window.addEventListener('resize', adjustForChat, { passive: true });
})();

// Footer safe area (keeps bottom links visible above Crisp chat)
(function() {
  const adjustFooterSafeArea = () => {
    const footers = document.querySelectorAll('footer');
    if (!footers.length) return;
    const isMobile = window.matchMedia('(max-width: 640px)').matches;
    // Reduce bottom padding to minimize visible empty space
    const offsetPx = isMobile ? 32 : 24;
    footers.forEach(f => {
      try {
        const current = parseInt(getComputedStyle(f).paddingBottom || '0', 10);
        if (!Number.isFinite(current) || current < offsetPx) {
          f.style.paddingBottom = offsetPx + 'px';
        }
      } catch (_) {}
    });
  };

  if ('requestIdleCallback' in window) {
    requestIdleCallback(adjustFooterSafeArea, { timeout: 1500 });
  } else if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', adjustFooterSafeArea, { once: true });
  } else {
    setTimeout(adjustFooterSafeArea, 1);
  }

  window.addEventListener('resize', adjustFooterSafeArea, { passive: true });
})();