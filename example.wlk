class Profesionales {
  const universidadEnLaQueEstudiaron
  method honorariosPorHora() {

  }
  method provinciasEnLasQuePuedeEjercer() {
    return []
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
    return profesionalesContratados.map({p=>p.getUniversidadEnLaQueEstudiaron()}).asSet()
  }
  method profesionalMasBarato(){
    return profesionalesContratados.min({p=>p.honorariosPorHora()})
  }
  method esDeGenteAcotada(){
    return profesionalesContratados.all({p=>p.provinciasEnLasQuePuedeEjercer().size() <= 3})
  }
  method getProfesionalesContratados(){
    return profesionalesContratados
  }
}

class Solicitantes {
  method puedeSerAtendidoPor(profesional) {
  }
}

class Personas inherits Solicitantes {
  const provinciaEnLaQueReside
  method provinciaEnLaQueReside() {
    return provinciaEnLaQueReside
  }
  override method puedeSerAtendidoPor(profesional){
    return profesional.provinciasEnLasQuePuedeEjercer().any({ provincia =>
      provincia == self.provinciaEnLaQueReside()
    })
  }
}

class Institucion inherits Solicitantes{
  const listaDeUniversidadesQueReconoce = []
  override method puedeSerAtendidoPor(profesional) {
  return listaDeUniversidadesQueReconoce.any({ universidad =>
    universidad == profesional.getUniversidadEnLaQueEstudiaron()
  })
}

}

class Club inherits Solicitantes {
  const provinciasEnLasQueEsta = []
  override method puedeSerAtendidoPor(profesional) {
    return profesional.provinciasEnLasQuePuedeEjercer().any({ provinciaDelProfesional =>
      provinciasEnLasQueEsta.any({ provinciaDelClub =>
        provinciaDelProfesional == provinciaDelClub
      })
    })
  }
}