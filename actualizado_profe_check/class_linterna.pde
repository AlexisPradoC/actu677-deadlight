class Linterna {
  PVector posicion;
  float alcance = 250;
  float ancho = PI / 3;
  float angulo;

  float distanciaMano = 35;
  float desplazamientoLateral = 17.2;
  PGraphics fondo = createGraphics(width, height);
  PGraphics fondoMask  = createGraphics(width, height);

  Linterna() {
    posicion = new PVector();
    fondo.beginDraw();
    fondo.image(fondoMapa, 0, 0, width, height);
    fondo.endDraw();
  }

  void actualizar(PVector posicionJugador, float anguloJugador) {
    angulo = anguloJugador;

    posicion.x = posicionJugador.x + cos(angulo) * distanciaMano + cos(angulo - HALF_PI) * desplazamientoLateral;
    posicion.y = posicionJugador.y + sin(angulo) * distanciaMano + sin(angulo - HALF_PI) * desplazamientoLateral;
  }

  void mostrar() {

    fondoMask.beginDraw();
    fondoMask.background(80);
    fondoMask.pushMatrix();
    fondoMask.translate(posicion.x, posicion.y);
    fondoMask.rotate(angulo);
    fondoMask.fill(255);
    fondoMask.noStroke();

    fondoMask.arc(
      0,
      0,
      alcance * 2,
      alcance * 2,
      -ancho / 2,
      ancho / 2,
      PIE
      );

    fondoMask.popMatrix();
    fondoMask.endDraw();

    fondo.mask(fondoMask);
    
    image(fondo, 0, 0);
  }

  boolean ilumina(Enemigo enemigo) {
    PVector direccion = PVector.sub(
      enemigo.posicion,
      posicion
      );

    float distancia = direccion.mag();

    if (distancia > alcance) {
      return false;
    }

    float anguloEnemigo = atan2(
      direccion.y,
      direccion.x
      );

    float diferencia = abs(
      atan2(
      sin(anguloEnemigo - angulo),
      cos(anguloEnemigo - angulo)
      )
      );

    if (diferencia <= ancho / 2) {
      return true;
    }

    return false;
  }
}
