# Tema de QueSabes para Alaveteli

Este es el tema de [QueSabes](http://quesabes.org/) para
[Alaveteli](http://alaveteli.org/). Recomendado leer aunque sea parte
de
[la documentación oficial](http://alaveteli.org/docs/getting_started/)
para empezar.

El tema contiene:

* Personalización CSS en public/stylesheets/custom.css
* Versiones personalizadas de páginas (como "acerca de" y otras tantas
 en `lib/views/help`).
* Personalizaciones de las vistas básicas del sistema en `lib/views`

# Funcionamiento básico

Lo importante está en el directorio `lib`. Alaveteli es una aplicación
Rails, y acá hay algunos archivos para parchear partes de Rails como
"controller_patches.rb", y "helper_patches.rb".

El archivo `alavetelitheme.rb` se encarga de importar las vistas y
monkey patchear el código de la app para incluir lo que haya en
`controller_patches.rb`, `helper_patches.rb` y
`patch_mailer_paths.rb`, así que de ser necesario incluir algun
archivo más, ese es el lugar.

Las **vistas** se sobrescriben desde `lib/views`. Cualquier vista de
la aplicación original se puede sobreescribir. Para incluir una vista
que no se encuentre en el tema, buscar desde la aplicación original la
ruta y copiar la vista a lib/views. Ejemplo: `app/views/public_body` a
`lib/views/public_body`.

# Instrucciones de instalación

[Ver instalación del tema en la wiki](https://github.com/datauy/quesabes-theme/wiki/Entorno-de-desarrollo-Alaveteli---quesabes-theme#instalar-tema)

En
[la wiki del proyecto](https://github.com/datauy/quesabes-theme/wiki)
hay más información. Particularmente sobre
[cómo levantar un entorno de desarrollo](https://github.com/datauy/quesabes-theme/wiki/Entorno-de-desarrollo-Alaveteli---quesabes-theme)
y algunas cosas que se fueron encontrando al hacer la migración al
tema nuevo.


