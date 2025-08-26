1. Autenticación y Perfil
   Registro e inicio de sesión con email y contraseña.
   Creación y edición de perfil profesional (foto, nombre, cargo, empresa,
   sector, intereses).

2. Directorio de Contactos
   Listado paginado de profesionales con búsqueda, filtros y ordenamiento.
   Cada contacto muestra foto, nombre, cargo, empresa y sector.2. Directorio de Contactos
   Listado paginado de profesionales con búsqueda, filtros y ordenamiento.
   Cada contacto muestra foto, nombre, cargo, empresa y sector.
3. Detalle de Contacto
   Vista detallada con biografía, intereses y botones de 'Conectar' y 'Enviar
   Mensaje'.
4. Conexiones
   Gestión de solicitudes enviadas y recibidas.
   Aceptar o rechazar solicitudes y mantener lista de contactos actuales.
5. Mensajería
   Chat entre contactos con historial y notificaciones de nuevos mensajes.
6. Feed de Actividades
      Publicaciones cortas de contactos con likes y comentarios.
7. Notificaciones
   Solicitudes, mensajes, publicaciones y respuestas.
   - Cloud Firestore para base de datos.
   - Firebase Messaging para él envió de notificaciones push
   - Firebase Authentification para la creación y gestión de inicio sesión de los usuarios


El proyecto de Flutter debe usar el sistema de gestión de estado
GetX así como su sistema de internalización (multilenguaje).

Para la estructura de los archivos del proyecto se debe manejar de
una manera similar a esta:
- Config: Folder que contiene los archivos de configuración de
la aplicación (temas, idiomas, base de la url, etc).
- Data: Folder que contendrá sub-folderes que contengan los
modelos y el repositorio para las peticiones
- Presentation: el cual contiene subcarpetas que son las vistas
de la aplicación con su archivo de diseño y lógica por
separado.
- Routes: Folder que contiene el manejo de rutas de la
aplicación.
- Utils: Folder que puede contener sub-folderes o archivos con
funciones o widget de utilidad.