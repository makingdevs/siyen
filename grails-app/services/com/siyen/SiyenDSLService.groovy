package com.siyen

class SiyenDSLService {

  def informePeriodicoService

  def dataGraph(closure) {
    closure.delegate = this
    def result = closure()
    result
  }

  def methodMissing(String name, args){
    switch(name){
      case("forYear"):
      // informePeriodicoService.obtenerDatosDeGraficacion(args[0])
      ['0':1, 'ACG':10]
      break
      case("inMonths"):
      ['0':[1], 'ACG':[10]]
      break
    }

  }


}
