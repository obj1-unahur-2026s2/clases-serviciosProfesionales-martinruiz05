class Profesionales {
  const universidadEnLaQueEstudiaron
  method honorariosPorHora() {

  }
  method provinciasEnLasQuePuedeEjercer(){

  }
  method getUniversidadEnLaQueEstudiaron() {
    return universidadEnLaQueEstudiaron
  }
  
}

class Universidad {
  const honorarioRecomendadoPorHora
  const provincia
  method honorarioQueRecomiendaLaUniversidad() {
    return honorarioRecomendadoPorHora

  }
  method getProvincia() {
    return provincia
  }

}

class ProfesionalesVinculadosAUniversidad inherits Profesionales {
  override method honorariosPorHora() {
    return universidadEnLaQueEstudiaron.honorarioQueRecomiendaLaUniversidad()

  }
  override method provinciasEnLasQuePuedeEjercer(){
    return [universidadEnLaQueEstudiaron.getProvincia()]
  }
}

class ProfesionalesAsociadosDelLitoral inherits Profesionales {
  override method honorariosPorHora(){
    return 3000
  }
  override method provinciasEnLasQuePuedeEjercer(){
    return ["Santa Fe", "Entre Ríos", "Corrientes"]
  }
}

class ProfesionalesLibres inherits Profesionales {
  const provinciasHabilitadas
  const tarifaPorHora

  override method provinciasEnLasQuePuedeEjercer() {
    return provinciasHabilitadas
  }

  override method honorariosPorHora() {
    return tarifaPorHora
  }
}

class EmpresaDeServicios {
  const profesionalesContratados = []
  const honorarioDeReferencia
  method contratarProfesional(profesional) {
    profesionalesContratados.add(profesional)
  }
  method cuantosEstudiaronEn(unaUniversidad){
    return profesionalesContratados.filter({p=>p.getUniversidadEnLaQueEstudiaron() === unaUniversidad}).size()
  }
  method profesionalesCaros(){
    return profesionalesContratados.filter({p=>p.honorariosPorHora() > honorarioDeReferencia})
  }
  method dondeEstudiaronLosProfesionales(){
    return profesionalesContratados.map({p=>p.getUniversidadEnLaQueEstudiaron()}).distinct()
  }
  method profesionalMasBarato(){
    return profesionalesContratados.min({p=>p.honorariosPorHora()})
  }
  method esDeGenteAcotada(){
    return profesionalesContratados.all({p=>p.provinciasEnLasQuePuedeEjercer().size() <= 3})
  }
}