# CLAUDE.md — VueltaAlCole

Marketplace de artículos escolares usados organizado por colegio.
Alumnos publican objetos y uniformes; otros alumnos los compran con pago integrado
(Mercado Pago). Hay un mercado general además del filtrado por colegio.

---

## Stack

| Capa | Tecnología |
|------|------------|
| Backend | Spring Boot 3.5.6 · Java 17 · Gradle 8.14.3 |
| ORM | Spring Data JPA / Hibernate → MySQL 8+ (`db_colevueltasv2`) |
| Seguridad | Spring Security (migrar a JWT — ver sección Seguridad) |
| Imágenes | Cloudinary SDK (`cloudinary-http44:1.36.0`) |
| Frontend | React + TypeScript (en construcción; ver `frontend/`) |
| Pagos | Mercado Pago Marketplace — split + comisión (a integrar) |
| Tiempo real | WebSocket (a agregar; hoy solo entidad `Chat` sin mensajes) |

---

## Estructura de carpetas

```
TpIntegrador-Vuelta-al-cole/
├── site/                          # Backend Spring Boot (proyecto principal)
│   ├── build.gradle
│   └── src/main/
│       ├── java/ar/com/colevueltas/site/
│       │   ├── SiteApplication.java
│       │   ├── config/            # CloudinaryConfig, CorsConfig, SecurityConfig
│       │   ├── controller/        # REST controllers (finos — lógica va en service)
│       │   ├── service/           # Lógica de negocio + @Transactional
│       │   ├── repository/        # Spring Data JPA repos
│       │   ├── dto/               # Request/Response DTOs (preferir records)
│       │   ├── model/             # Entidades JPA + Enums
│       │   └── globals/           # BadRequestException + GlobalExceptionHandler
│       └── resources/
│           └── application.properties
├── frontend/                      # React + TypeScript (nueva carpeta, aún vacía)
├── CLAUDE.md
└── _legacy/                       # Material de referencia — no forma parte del producto
    ├── sitio/                     # Prototipos HTML/CSS/JS anteriores
    ├── VueltaAlCole (No conectado)/  # Bocetos alternativos
    ├── DB/                        # vueltaAlCole_dbV4.4.sql (export completo)
    ├── entrega base de datos/     # Creates_vueltaAlcole_DB.sql + export
    └── Documentacion/             # GUIA DE LA API.pdf · Guía BDD.txt
```

---

## Modelo de datos

### Tablas principales
`usuarios` · `colegio` · `publicacion` · `publicacion_uniforme` · `categoria`
`chats` · `mensajes` (en SQL, sin entidad Java aún)
`ventas` (mapeada como `Compra.java`) · `calificaciones` · `favoritos`
`imagen_publicacion` · `talles` · `niveles` · `notificaciones`
`bitacora_admin` · `reportes` y variantes · `configuracion`

### Triggers — verificados en SQL

**`entrega base de datos/Creates_vueltaAlcole_DB.sql`** (2 triggers, gamificación):
- `trg_actualizar_nivel_por_venta` — al insertar en `ventas`, suma 25 XP al comprador
  y al vendedor; sube de nivel si `xp >= xp_necesaria` del próximo nivel en `niveles`
- `trg_verificar_usuario_por_compras` — al insertar en `ventas`, si el comprador
  alcanza el umbral de `COMPRAS_PARA_VERIFICACION` (tabla `configuracion`), setea
  `es_verificado = 1` y genera notificación

**`DB/vueltaAlCole_dbV4.4.sql`** (4 triggers — superset del anterior):
- Los 2 de gamificación anteriores
- `trg_actualizar_promedio_calificacion` — al insertar en `calificaciones`, actualiza
  `calificacion_vendedor_promedio` / `calificacion_comprador_promedio` en `usuarios`
- `trg_cerrar_publicacion_al_vender` — al insertar en `ventas`, marca la publicación
  como vendida (`estado = 3`) y cierra el chat origen si existe

**Decisión pendiente del equipo:** ¿se conserva la capa de XP / niveles / verificación
automática? Si se descarta, hay que eliminar los triggers, las columnas `xp`/`nivel`/
`es_verificado` en `usuarios` y la tabla `niveles`. Si se conserva, esa lógica debe
quedar 100% en DB (triggers) o 100% en la app — no mezclada.

---

## Entidades JPA existentes

`Usuario` · `Colegio` · `Publicacion` · `PublicacionUniforme` · `Categoria`
`Chat` · `Compra` · `ImagenPublicacion` · `Talle` · `Nivel`
`PublicacionPregunta` · `BitacoraAdmin`

**Enums:** `Condicion` · `EstadoChat` · `EstadoPublicacion` · `Genero`
`RolCalificado` · `Tipo` · `ReferenciaTabla`

---

## Postura sobre el código existente — Auditoría

**Lo ya hecho es referencia de dominio, no cimiento.** Nada se asume correcto.
Cada módulo se audita y se decide: conservar / refactorizar / reescribir, con
justificación. El esquema de BD también entra en auditoría.

### Hallazgos de auditoría pendientes de resolver

- **Secretos en repo público**: credenciales de Cloudinary y DB en
  `application.properties` commiteadas. El historial de git las conserva aunque se
  eliminen del archivo. Rotar inmediatamente (ver tarea 1).
- **Auth in-memory**: `SecurityConfig.java` tiene `admin/1234` hardcodeado,
  CSRF deshabilitado, y casi todo en `permitAll()`.
- **Mapeo JPA inconsistente**: `PublicacionPregunta`, `ImagenPublicacion` y `Categoria`
  ya usan relaciones JPA correctamente; `PublicacionUniforme` parcialmente (`@ManyToOne`
  para `id_talle`, pero `idPublicacion`/`idColegio` siguen como `Integer` crudo). En
  cambio `Usuario`, `Publicacion`, `Chat` y `Compra` usan solo `int`/`Integer` crudos
  como FK → son las que hay que migrar a `@ManyToOne`.
- **`Chat.estado` sin `@Enumerated`**: el enum `EstadoChat` no tiene la anotación
  → Hibernate persiste el ordinal por defecto, frágil ante reordenamientos.
- **Boilerplate manual en entidades**: getters/setters/constructores escritos a mano;
  migrar a Lombok.

---

## Seguridad — reglas firmes

- **Contraseñas**: siempre hasheadas con BCrypt en BD. Nunca texto plano. Nunca se
  devuelven en ninguna respuesta.
- **JWT**: todo endpoint que no sea login, register o catálogo público exige token
  `Authorization: Bearer <token>`. No hay sesiones server-side.
- **DTOs de salida**: nunca serializar la entidad `Usuario` cruda. Los DTOs controlan
  exactamente qué se expone.
- **Secretos**: fuera del código. Usar variables de entorno o Spring profiles
  (`application-local.properties` en `.gitignore`). Las credenciales de Cloudinary
  ya están filtradas — rotar antes de cualquier otra tarea.

---

## Buenas prácticas — Backend (Java 17 / Spring)

- **Nomenclatura**: `camelCase` idiomático en campos Java (`idPublicacion`, no
  `id_publicacion`). `snake_case` solo en columnas SQL (`@Column(name = "...")`).
- **Relaciones JPA**: `@ManyToOne(fetch = LAZY)` / `@OneToMany` con la entidad real,
  nunca `int` crudos como FK.
- **Inyección**: siempre por constructor (no `@Autowired` en campo).
- **Responsabilidades**: controllers finos (validar entrada → llamar service → devolver
  respuesta). Toda lógica de negocio en services con `@Transactional`.
- **DTOs**: preferir `record` de Java 17. Nunca devolver entidades JPA directamente.
- **Lombok**: `@Data` / `@Builder` / `@RequiredArgsConstructor` para eliminar
  boilerplate. Combinado con `record` donde aplique.
- **Validación**: Bean Validation (`@NotNull`, `@Size`, etc.) en DTOs de entrada.
- **Logging**: SLF4J (`private static final Logger log = ...`). Prohibido
  `System.out.println`.
- **Tests**: JUnit 5 + Mockito. Cada service tiene tests unitarios; cada endpoint
  tiene al menos un test de integración.
- **API REST**: verbos HTTP correctos, códigos de estado explícitos, paginación con
  `Pageable` en listados.

---

## Buenas prácticas — Frontend (React + TypeScript)

- **TypeScript strict**: `"strict": true` en `tsconfig.json`. Sin `any` sin justificar.
- **Componentes**: funcionales únicamente. Sin clases.
- **Estructura**: por feature (`/publicaciones`, `/chat`, `/perfil`), no por tipo
  (`/components`, `/pages`).
- **Data fetching**: TanStack Query (React Query) para caché, loading y error states.
- **Formularios**: react-hook-form + Zod para validación y tipos inferidos.
- **Routing**: React Router v6+.
- **UI**: React-Bootstrap con tema del manual de marca:
  - Fuentes: Inter / Sora
  - Colores: `#08359B` (primario), blanco, `#999999` (gris), `#1EB323` (éxito),
    `#FF0000` (error)
- **Tooling**: Vite (dev en `:5173`) · ESLint · Prettier.
- **CORS**: actualizar `CorsConfig.java` para incluir `http://localhost:5173`.

---

## Colaboración humano–agente

Cuando una tarea no la puede hacer Claude Code —acciones fuera del repo: paneles
externos, rotar/regenerar claves, instalar software, configurar cuentas, o pasos en
una UI web— no asumir ni simular. Dar un paso a paso claro y conciso para que el
humano la ejecute, y esperar confirmación antes de continuar.

---

## Metodología

- **Branching**: GitHub Flow — rama por issue desde `main`.
  Prefijos: `feat/`, `fix/`, `refactor/`, `chore/`.
- **Commits**: Conventional Commits (`feat: ...`, `fix: ...`, `refactor: ...`).
- **PRs**: revisión obligatoria antes de mergear a `main`.
- **Definition of Done**: compila + tests verdes + revisión aprobada + sin secretos
  commiteados.
- **Issues**: cada issue tiene criterios de aceptación y al menos uno de estos labels:
  `backend` · `frontend` · `refactor` · `pagos` · `chat` · `seguridad` · `bug`
- **Kanban**: GitHub Projects — solo columnas de estado (Backlog / En progreso / Review
  / Done). Sin roadmap de fechas.
- **Planificación**: Claude Code crea y mantiene los issues y el tablero según el
  avance del proyecto.

---

## Orden de tareas

1. **Rotar secretos** — Cloudinary + DB. Mover a variables de entorno. El historial
   de git sigue teniendo las claves viejas: asumir comprometidas.
2. **JWT auth** — reemplazar `SecurityConfig` in-memory. `UsuarioService` como
   `UserDetailsService`. Filtro JWT. Endpoints públicos: login, register, catálogos.
3. **Entidad `Mensaje` + repo** — mapear tabla `mensajes` existente en SQL.
4. **WebSocket** — chat único por publicación entre comprador y vendedor.
5. **Mercado Pago Marketplace** — split de pagos + comisión, webhook que registra en
   `ventas` al confirmar pago.
6. **Frontend React** en `frontend/` — estructura base, auth, routing.
7. **Filtros por tipo de material** dentro de cada colegio (UX prioritario).
8. **Refactor del modelo** — corregir mapeo JPA, agregar Lombok, corregir
   `@Enumerated`. Decidir el futuro de la capa de gamificación (XP/niveles).

---

## Entorno de desarrollo

| Herramienta | Estado |
|-------------|--------|
| Java 17 (Microsoft OpenJDK) | ✅ |
| Gradle 8.14.3 (wrapper en `site/`) | ✅ |
| Node 24 / npm 11 | ✅ |
| MySQL | ⚠️ no encontrado en PATH — verificar instalación |
| GitHub CLI (`gh`) | ❌ no instalado |

Build: `cd site && .\gradlew.bat build -x test`
DB local: `db_colevueltasv2` · `localhost:3306` · `root/root` (solo dev local)
Credenciales de prod: variables de entorno / Spring profile (nunca en el repo).
