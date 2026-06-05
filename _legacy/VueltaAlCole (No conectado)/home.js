document.addEventListener('DOMContentLoaded', function() {
    
    // 1. Funcionalidad de "Me gusta" / Favoritos
    const heartButtons = document.querySelectorAll('.btn-fav');

    heartButtons.forEach(btn => {
        btn.addEventListener('click', function() {
            const icon = this.querySelector('i');
            if (icon.classList.contains('bi-heart')) {
                icon.classList.remove('bi-heart');
                icon.classList.add('bi-heart-fill');
                icon.classList.add('text-danger'); // Cambia a rojo
            } else {
                icon.classList.remove('bi-heart-fill');
                icon.classList.remove('text-danger');
                icon.classList.add('bi-heart');
            }
        });
    });

    // 2. Funcionalidad básica del buscador (Demo)
    const searchInput = document.querySelector('.search-bar-container input');
    searchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            const query = this.value;
            if(query.trim() !== "") {
                alert('Buscando: ' + query);
                // Aquí iría la lógica real de redirección a resultados
            }
        }
    });

    // 3. Lógica del Carrusel de Productos (Scroll Horizontal)
    const carousel = document.getElementById('productsCarousel');
    const btnLeft = document.getElementById('scrollLeftBtn');
    const btnRight = document.getElementById('scrollRightBtn');

    if(carousel && btnLeft && btnRight) {
        btnLeft.addEventListener('click', () => {
            carousel.scrollLeft -= 300; // Desplaza 300px a la izquierda
        });

        btnRight.addEventListener('click', () => {
            carousel.scrollLeft += 300; // Desplaza 300px a la derecha
        });
    }
});

// Función para simular el Login
function login() {
    const headerGuest = document.getElementById('header-guest');
    const headerUser = document.getElementById('header-user');

    // Ocultar header de invitado
    headerGuest.classList.remove('d-block');
    headerGuest.classList.add('d-none');

    // Mostrar header de usuario
    headerUser.classList.remove('d-none');
    headerUser.classList.add('d-block');
}