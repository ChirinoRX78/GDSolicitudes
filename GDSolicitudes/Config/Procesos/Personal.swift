//
//  Personal.swift
//  TestWF
//
//  Created by TI on 28/01/26.
//

import SwiftUI

struct Personal: Codable, Identifiable {
    let id = UUID()
    //Tabla principal
    let solicitud: Int
    let prodescripcion: String
    let fechacad: FechaAPI
    let solicitante: String
	//Datos adicionales
    let nuevo: Int
    let soltemp: Int
    let famempsol: Int
    let contcompsol: Int
    //Datos RH
    let catpers: String
    let catpersdesc: String
    let contcompact: Int
    let famempact: Int
    let fechatempini: FechaAPI?
    let fechatempfin: FechaAPI?
    let nomact: String
    let apepatact: String
    let apematact: String
    let nomsol: String
    let apepatsol: String
    let apematsol: String
    let puestoact: String
    let puestosol: String
    let puestodescact: String
    let puestodescsol: String
    let nomfamact: String
    let nomfamsol: String
    let areafamact: Int
    let areafamsol: Int
    let areafamdescact: String 
    let areafamdescsol: String
    let puestofamact: Int
    let puestofamsol: Int
    let puestofamdescact: String
    let puestofamdescsol: String
    let parfamact: String
    let parfamsol: String
    let parfamdescact: String
    let parfamdescsol: String
    let fechainfamact: FechaAPI?
    let fechainfamsol: FechaAPI?
    let areaact: Int
    let areasol: Int
    let areadescact: String
    let areadescsol: String
    let numempact: String
    let numempsol: String
    let fechainact: FechaAPI?
    let fechainsol: FechaAPI?
    let fechabajaact: FechaAPI?
    let fechabajasol: FechaAPI?
    let fechanacact: FechaAPI?
    let fechanacsol: FechaAPI?
    let curpact: String
    let curpsol: String
    let tipocontact: String
    let tipocontsol: String
    let sangrecact: String
    let sangrecsol: String
    let tiposangrecact: String
    let tiposangrecsol: String
    let domact: String
    let domsol: String
    let numextact: String
    let numextsol: String
    let numintact: String
    let numintsol: String
    let cpsatact: String
    let cpsatsol: String
    let paissatact: String
    let paissatsol: String
    let edosatidact: String
    let edosatidsol: String
    let munsatact: String
    let munsatsol: String
    let locsatact: String
    let locsatsol: String
    let colsatact: String
    let colsatsol: String
    let telact: String
    let telsol: String
    let tel2act: String
    let tel2sol: String
    let numssact: String
    let numsssol: String
    let rfcact: String
    let rfcsol: String
    let catcomact: String
    let catcomsol: String
    let domemgact: String
    let domemgsol: String
    let telemgact: String
    let telemgsol: String
    let manusuact: Int
    let manususol: Int
    let usuact: String
    let ususol: String
    let privhoraentact: Int
    let privhoraentsol: Int
    let privhorasalact: Int
    let privhorasalsol: Int
    let privasisact: Int
    let privasissol: Int
    let joract: Int
    let jorsol: Int
    let tipojoract: String
    let tipojorsol: String
    let permhueact: Int
    let permhuesol: Int
    let permhuenipact: Int
    let permhuenipsol: Int
    let permtaract: Int
    let permtarsol: Int
    let permtarhueact: Int
    let permtarhuesol: Int
    let horasextact: Int
    let horasextsol: Int
    let nivelsegact: String
    let nivelsegsol: String
    let nipact: String
    let nipsol: String
    let ctadeudact: String
    let ctadeudsol: String
    let ctadeuddescact: String
    let ctadeuddescsol: String
    let ctaacreact: String
    let ctaacresol: String
    let ctaacredescact: String
    let ctaacredescsol: String
    let ctanomact: String
    let ctanomsol: String
    let ctanomdescact: String
    let ctanomdescsol: String
    let tiponomact: Int
    let tiponomsol: Int
    let tiponomdescact: String
    let tiponomdescsol: String
    let aguiact: Int
    let aguisol: Int
    let vacact: Int
    let vacsol: Int
    let sueldoimssact: String
    let sueldoimsssol: String
    let tiposalact: String
    let tiposalsol: String
    let tiposaldescact: String
    let tiposaldescsol: String
    let sucact: Int
    let sucsol: Int
    let sucdescact: String
    let sucdescsol: String
    let ctabcoact: String
    let ctabcosol: String
    let numtaract: String
    let numtarsol: String
    let salbiantact: String
    let salbiantsol: String
    let infoact: Int
    let infosol: Int
    let amoract: Int
    let amorsol: Int
    let numcredact: String
    let numcredsol: String
    let porcinfoact: Int
    let porcinfosol: Int
    let porcfijaact: Int
	let porcfijasol: Int
    let amormenact: String
    let amormensol: String
    let fechainidescinfoact: FechaAPI?
    let fechainidescinfosol: FechaAPI?
    let turnoact: Int
    let turnosol: Int
    let turnodescact: String
    let turnodescsol: String
    let cedact: String
    let cedsol: String
    let recontact: Int
    let recontsol: Int
    let suaact: Int
    let suasol: Int
    let modopagoact: String
    let modopagosol: String
    let modopagodescact: String
    let modopagodescsol: String
    let estcredact: String
    let estcredsol: String
    let estcreddescact: String
    let estcreddescsol: String
    let grupoact: Int
    let gruposol: Int
    let grupodescact: String
    let grupodescsol: String
    let nacact: String
    let nacsol: String
    let sexoact: String
    let sexosol: String
    let sexodescact: String
    let sexodescsol: String
    let civact: String
    let civsol: String
    let civdescact: String
    let civdescsol: String
    let notaact: String
    let notasol: String
    let licact: String
    let licsol: String
    let tipolicact: String
    let tipolicsol: String
    let tipolicdescact: String
    let tipolicdescsol: String
    let vigact: FechaAPI?
    let vigsol: FechaAPI?
    let umfact: String
    let umfsol: String
    let semjoract: String
    let semjorsol: String
    //let semjordescact: String
    let semjordescsol: String
    let fechareact: FechaAPI?
    let fecharesol: FechaAPI?
    let fechaimsact: FechaAPI?
    let fechaimssol: FechaAPI?
    let regsalminact: String
    let regsalminsol: String
	let regsalmindescact: String
	let regsalmindescsol: String
	let folioact: String
    let foliosol: String
    let asegact: Int
    let asegsol: Int
    let udnact: Int
    let udnsol: Int
    let bancoact: Int
    let bancosol: Int
    let bancodescact: String 
    let bancodescsol: String
    let cheqact: String
    let cheqsol: String
    let nompadreact: String
    let nompadresol: String
    let nommadreact: String
    let nommadresol: String
    let fechajubact: FechaAPI?
    let fechajubsol: FechaAPI?
    let foliojubact: Int
    let foliojubsol: Int
    let porcjubact: String
    let porcjubsol: String
	let pensact: Int
    let penssol: Int
    let porcalimact: String
    let porcalimsol: String
	let porcalim2act: String
    let porcalim2sol: String
	let porcalim3act: String
    let porcalim3sol: String
    let imppenact: String
    let imppensol: String
	let imppen2act: String
    let imppen2sol: String
	let imppen3act: String
    let imppen3sol: String
	let descpenalimact: String
    let descpenalimsol: String
	let descpenalim2act: String
    let descpenalim2sol: String
	let descpenalim3act: String
    let descpenalim3sol: String
	let folpenact: Int
    let folpensol: Int
	let folpen2act: Int
    let folpen2sol: Int
	let folpen3act: Int
    let folpen3sol: Int
	let sindact: Int
    let sindsol: Int
	let cuotasindact: String
    let cuotasindsol: String
	let tipocuentact: String
    let tipocuentsol: String
    let emailact: String
    let emailsol: String
    let emailempact: String
    let emailempsol: String
    let regcontact: String
    let regcontsol: String
    let tipcontsatact: String
    let tipcontsatsol: String
    let tipocontsatdescact: String
    let tipocontsatdescsol: String
    let tipojornsatact: String
    let tipojornsatsol: String
	let tipojornsatdescact: String
    let tipojornsatdescsol: String
	let tiporegsatact: String
    let tiporegsatsol: String
	let tiporegsatdescact: String
    let tiporegsatdescsol: String
	let edosatact: String
    let edosatsol: String
	let edosatdescact: String
    let edosatdescsol: String
	let puesimsact: Int
    let puesimssol: Int
	let puesimsdescact: String
    let puesimsdescsol: String
	let escact: Int
    let escsol: Int
	let escdescact: String
    let escdescsol: String
	let uniact: String
	let unisol: String
	let estactact: Int
    let estactsol: Int
	let queestact: String
    let queestsol: String
    let medestact: String
    let medestsol: String
	let medestdescact: String
    let medestdescsol: String
    let condvivact: String
    let condvivsol: String
    let condvivdescact: String
    let condvivdescsol: String
    let viveact: String
    let vivesol: String
    let vivedescact: String
    let vivedescsol: String
    let nomconyuact: String
    let nomconyusol: String
    let canthijosact: Int
    let canthijossol: Int
	let nomhijoact: String
    let nomhijosol: String
	let edadhijoact: Int
    let edadhijosol: Int
	let hijoescact: Int
    let hijoescsol: Int
	let numdepecact: Int
    let numdepecsol: Int
	let enfcroact: Int
    let enfcrosol: Int
	let nomenfcroact: String
    let nomenfcrosol: String
	let segvidaact: Int
    let segvidasol: Int
	let nombensegvidaact: String
    let nombensegvidasol: String
	let montoasegact: String
    let montoasegsol: String
	let seggastosact: Int
    let seggastossol: Int
	let nombecimact: String
    let nombecimsol: String
	let nomemgact: String
    let nomemgsol: String
	let bengasact: Int
    let bengassol: Int
    let bencomact: Int
    let bencomsol: Int
	let bentraact: Int
    let bentrasol: Int
    let benmamact: Int
    let benmamsol: Int
    let benpapact: Int
    let benpapsol: Int
    let bendianinoact: Int
    let bendianinosol: Int
    let suelreact: String
    let suelresol: String
    let bandepact: Int
    let bandepsol: Int
    let bandepdescact: String
    let bandepdescsol: String
    let claintdepact: String
    let claintdepsol: String
	let suelimpenact: Int
    let suelimpensol: Int
	let razpatact: String
    let razpatsol: String
	let empcompact: String
    let empcompsol: String
	let fonact: Int
    let fonsol: Int
	let numfonact: String
    let numfonsol: String
	let fechainifonact: FechaAPI?
    let fechainifonsol: FechaAPI?
	let impfonact: String
    let impfonsol: String
    //Detalles de la solicitud
    let nivel: Int
    let autoriza: String
    let fechasol: FechaAPI
    let sla: Int
    let fechasla: FechaAPI
    let motivo: Int
    let motivodesc: String
    let motivodetalle: String
    //Proceso
    let procesoid: Int
    let emp: Int
    let cns: Int
    let uuid: String
    enum CodingKeys: String, CodingKey {
        case solicitud = "SolicitudID"
        case prodescripcion = "ProcesoDescripcion"
        case fechacad = "FechaCaducidad"
        case solicitante = "SolicitanteNombre"
        //Datos adicionales
        case nuevo = "NuevoPersonal"
        case soltemp = "SolicitudTemporal"
        case famempsol = "FamiliaresEnLaEmpresaSolicitado"
        case contcompsol = "ContratacionCompetenciaSolicitado"
        //Datos RH
        case catpers = "CategoriaDelPersonalID"
        case catpersdesc = "CategoriaDelPersonalDescripcion"
        case contcompact = "ContratacionCompetenciaActual"
        case famempact = "FamiliaresEnLaEmpresaActual"
        case fechatempini = "FechaTemporalInicial"
        case fechatempfin = "FechaTemporalFinal"
        case nomact = "NombresActual"
        case apepatact = "ApellidoPaternoActual"
        case apematact = "ApellidoMaternoActual"
        case nomsol = "NombresSolicitado"
        case apepatsol = "ApellidoPaternoSolicitado"
        case apematsol = "ApellidoMaternoSolicitado"
        case puestoact = "PuestoActual"
        case puestosol = "PuestoSolicitado"
        case puestodescact = "PuestoDescripcionActual"
        case puestodescsol = "PuestoDescripcionSolicitado"
        case nomfamact = "NombreDelFamiliarActual"
        case nomfamsol = "NombreDelFamiliarSolicitado"
        case areafamact = "AreaDelFamiliarActual"
        case areafamsol = "AreaDelFamiliarSolicitado"
        case areafamdescact = "AreaDelFamiliarDescripcionActual"
        case areafamdescsol = "AreaDelFamiliarDescripcionSolicitado"
        case puestofamact = "PuestoDelFamiliarActual"
        case puestofamsol = "PuestoDelFamiliarSolicitado"
        case puestofamdescact = "PuestoDelFamiliarDescripcionActual"
        case puestofamdescsol = "PuestoDelFamiliarDescripcionSolicitado"
        case parfamact = "ParentescoDelFamiliarActual"
        case parfamsol = "ParentescoDelFamiliarSolicitado"
        case parfamdescact = "ParentescoDelFamiliarDescripcionActual"
        case parfamdescsol = "ParentescoDelFamiliarDescripcionSolicitado"
        case fechainfamact = "FechaIngresoDelFamiliarActual"
        case fechainfamsol = "FechaIngresoDelFamiliarSolicitado"
        //
        case areaact = "AreaActual"
        case areasol = "AreaSolicitado"
        case areadescact = "AreaDescripcionActual"
        case areadescsol = "AreaDescripcionSolicitado"
        case numempact = "NumeroEmpleadoActual"
        case numempsol = "NumeroEmpleadoSolicitado"
        case fechainact = "FechaIngresoActual"
        case fechainsol = "FechaIngresoSolicitado"
        case fechabajaact = "FechaBajaActual"
        case fechabajasol = "FechaBajaSolicitado"
        case fechanacact = "FechaNacimientoActual"
        case fechanacsol = "FechaNacimientoSolicitado"
        //
        case curpact = "CurpActual"
        case curpsol = "CurpSolicitado"
        case tipocontact = "TipoContratoActual"
        case tipocontsol = "TipoContratoSolicitado"
        case sangrecact = "TipoSangreActual"
        case sangrecsol = "TipoSangreSolicitado"
        case tiposangrecact = "TipoSangreDescripcionActual"
        case tiposangrecsol = "TipoSangreDescripcionSolicitado"
        case domact = "DomicilioActual"
        case domsol = "DomicilioSolicitado"
        case numextact = "NoExteriorActual"
        case numextsol = "NoExteriorSolicitado"
        case numintact = "NoInteriorActual"
        case numintsol = "NoInteriorSolicitado"
        //
        case cpsatact = "CpSATActual"
        case cpsatsol = "CpSATSolicitado"
        case paissatact = "PaisIDSATActual"
        case paissatsol = "PaisIDSATSolicitado"
        case edosatidact = "EstadoIDSATActual"
        case edosatidsol = "EstadoIDSATSolicitado"
        case munsatact = "MunicipioIDSATActual"
        case munsatsol = "MunicipioIDSATSolicitado"
        case locsatact = "LocalidadIDSATActual"
        case locsatsol = "LocalidadIDSATSolicitado"
        case colsatact = "ColoniaIDSATActual"
        case colsatsol = "ColoniaIDSATSolicitado"
        //
        case telact = "TelefonosActual"
        case telsol = "TelefonosSolicitado"
        case tel2act = "Telefono2Actual"
        case tel2sol = "Telefono2Solicitado"
        case numssact = "NumeroSeguridadSocialActual"
        case numsssol = "NumeroSeguridadSocialSolicitado"
        case rfcact = "RfcActual"
        case rfcsol = "RfcSolicitado"
        case catcomact = "CategoriaDeComisionesActual"
        case catcomsol = "CategoriaDeComisionesSolicitado"
        case domemgact = "DomicilioEmergenciaActual"
        case domemgsol = "DomicilioEmergenciaSolicitado"
        case telemgact = "TelefonoEmergenciaActual"
        case telemgsol = "TelefonoEmergenciaSolicitado"
        case manusuact = "ManejaCuentaUsuarioActual"
        case manususol = "ManejaCuentaUsuarioSolicitado"
        case usuact = "UsuarioActual"
        case ususol = "UsuarioSolicitado"
        case privhoraentact = "PrivilegioHoraEntradaActual"
        case privhoraentsol = "PrivilegioHoraEntradaSolicitado"
        case privhorasalact = "PrivilegioHoraSalidaActual"
        case privhorasalsol = "PrivilegioHoraSalidaSolicitado"
        case privasisact = "PrivilegioAsistenciaActual"
        case privasissol = "PrivilegioAsistenciaSolicitado"
        case joract = "JornadaActualActual"
        case jorsol = "JornadaActualSolicitado"
        case tipojoract = "TipoJornadaActualActual"
        case tipojorsol = "TipoJornadaActualSolicitado"
        case permhueact = "PermitirHuellaActual"
        case permhuesol = "PermitirHuellaSolicitado"
        case permhuenipact = "PermitirNipHuellaActual"
        case permhuenipsol = "PermitirNipHuellaSolicitado"
        case permtaract = "PermitirTarjetaActual"
        case permtarsol = "PermitirTarjetaSolicitado"
        case permtarhueact = "PermitirTarjetaHuellaActual"
        case permtarhuesol = "PermitirTarjetaHuellaSolicitado"
        case horasextact = "HorasExtraActual"
        case horasextsol = "HorasExtraSolicitado"
        case nivelsegact = "NivelSeguridadActual"
        case nivelsegsol = "NivelSeguridadSolicitado"
        case nipact = "NIPActual"
        case nipsol = "NIPSolicitado"
        case ctadeudact = "CuentaDeudorActual"
        case ctadeudsol = "CuentaDeudorSolicitado"
        case ctadeuddescact = "CuentaDeudorDescripcionActual"
        case ctadeuddescsol = "CuentaDeudorDescripcionSolicitado"
        case ctaacreact = "CuentaAcreedorActual"
        case ctaacresol = "CuentaAcreedorSolicitado"
        case ctaacredescact = "CuentaAcreedorDescripcionActual"
        case ctaacredescsol = "CuentaAcreedorDescripcionSolicitado"
        case ctanomact = "CuentaNominaActual"
        case ctanomsol = "CuentaNominaSolicitado"
        case ctanomdescact = "CuentaNominaDescripcionActual"
        case ctanomdescsol = "CuentaNominaDescripcionSolicitado"
        //
        case tiponomact = "TipoNominaActual"
        case tiponomsol = "TipoNominaSolicitado"
        case tiponomdescact = "TipoNominaDescripcionActual"
        case tiponomdescsol = "TipoNominaDescripcionSolicitado"
        case aguiact = "DiasAguinaldoActual"
        case aguisol = "DiasAguinaldoSolicitado"
        case vacact = "DiasVacacionesActual"
        case vacsol = "DiasVacacionesSolicitado"
        case sueldoimssact = "SueldoDiarioIMSSActual"
        case sueldoimsssol = "SueldoDiarioIMSSSolicitado"
        case tiposalact = "TipoSalarioActual"
        case tiposalsol = "TipoSalarioSolicitado"
        case tiposaldescact = "TipoSalarioDescripcionActual"
        case tiposaldescsol = "TipoSalarioDescripcionSolicitado"
        //
        case sucact = "SucursalIDActual"
        case sucsol = "SucursalIDSolicitado"
        case sucdescact = "SucursalIDDescripcionActual"
        case sucdescsol = "SucursalIDDescripcionSolicitado"
        case ctabcoact = "CuentaBancoActual"
        case ctabcosol = "CuentaBancoSolicitado"
        case numtaract = "NumeroTarjetaActual"
        case numtarsol = "NumeroTarjetaSolicitado"
        case salbiantact = "SalarioBiAnteriorActual"
        case salbiantsol = "SalarioBiAnteriorSolicitado"
        //
        case infoact = "TieneInfonavitActual"
        case infosol = "TieneInfonavitSolicitado"
        case amoract = "TipoAmortizacionActual"
        case amorsol = "TipoAmortizacionSolicitado"
        case numcredact = "NumeroCreditoActual"
        case numcredsol = "NumeroCreditoSolicitado"
        case porcinfoact = "PorcInfonavitActual"
        case porcinfosol = "PorcInfonavitSolicitado"
        case porcfijaact = "PorcCuotaFijaActual"
        case porcfijasol = "PorcCuotaFijaSolicitado"
        case amormenact = "AmortizacionMensualActual"
        case amormensol = "AmortizacionMensualSolicitado"
        case fechainidescinfoact = "FechaInicioDescuentInfonavitActual"
        case fechainidescinfosol = "FechaInicioDescuentInfonavitSolicitado"
        //
        case turnoact = "TurnoActual"
        case turnosol = "TurnoSolicitado"
        case turnodescact = "TurnoDescripcionActual"
        case turnodescsol = "TurnoDescripcionSolicitado"
        case cedact = "CedulaActual"
        case cedsol = "CedulaSolicitado"
        case recontact = "PermitirRecontratarActual"
        case recontsol = "PermitirRecontratarSolicitado"
        case suaact = "AltaSUAActual"
        case suasol = "AltaSUASolicitado"
        case modopagoact = "ModoPagoActual"
        case modopagosol = "ModoPagoSolicitado"
        case modopagodescact = "ModoPagoDescripcionActual"
        case modopagodescsol = "ModoPagoDescripcionSolicitado"
        case estcredact = "EstatusCredencialActual"
        case estcredsol = "EstatusCredencialSolicitado"
        case estcreddescact = "EstatusCredencialDescripcionActual"
        case estcreddescsol = "EstatusCredencialDescripcionSolicitado"
        //
        case grupoact = "GrupoIDActual"
        case gruposol = "GrupoIDSolicitado"
        case grupodescact = "GrupoIDDescripcionActual"
        case grupodescsol = "GrupoIDDescripcionSolicitado"
        case nacact = "LugarNacimientoActual"
        case nacsol = "LugarNacimientoSolicitado"
        case sexoact = "SexoActual"
        case sexosol = "SexoSolicitado"
        case sexodescact = "SexoDescripcionActual"
        case sexodescsol = "SexoDescripcionSolicitado"
        case civact = "EstadoCivilActual"
        case civsol = "EstadoCivilSolicitado"
        case civdescact = "EstadoCivilDescripcionActual"
        case civdescsol = "EstadoCivilDescripcionSolicitado"
        case notaact = "NotasActual"
        case notasol = "NotasSolicitado"
        case licact = "LicenciaActual"
        case licsol = "LicenciaSolicitado"
        case tipolicact = "TipoLicenciaActual"
        case tipolicsol = "TipoLicenciaSolicitado"
        case tipolicdescact = "TipoLicenciaDescripcionActual"
        case tipolicdescsol = "TipoLicenciaDescripcionSolicitado"
        case vigact = "VigenciaActual"
        case vigsol = "VigenciaSolicitado"
        case umfact = "UMFActual"
        case umfsol = "UMFSolicitado"
        case semjoract = "SemanaJornadaReducidaActual"
        case semjorsol = "SemanaJornadaReducidaSolicitado"
        //case semjordescact = "SemanaJornadaReducidaDescripcionActual"
        case semjordescsol = "SemanaJornadaReducidaDescripcionSolicitado"
        case fechareact = "FechaReingresoActual"
        case fecharesol = "FechaReingresoSolicitado"
        case fechaimsact = "FechaAltaImssActual"
        case fechaimssol = "FechaAltaImssSolicitado"
        //
        case regsalminact = "RegionSalarioMinimoActual"
        case regsalminsol = "RegionSalarioMinimoSolicitado"
		case regsalmindescact = "RegionSalarioMinimoDescripcionActual"
        case regsalmindescsol = "RegionSalarioMinimoDescripcionSolicitado"
		case folioact = "FolioCredencialActual"
        case foliosol = "FolioCredencialSolicitado"
        case asegact = "AseguradoIMSSActual"
        case asegsol = "AseguradoIMSSSolicitado"
        case udnact = "UnidadNegocioIDActual"
        case udnsol = "UnidadNegocioIDSolicitado"
        case bancoact = "BancoIDActual"
        case bancosol = "BancoIDSolicitado"
        case bancodescact = "BancoIDDescripcionActual"
        case bancodescsol = "BancoIDDescripcionSolicitado"
        case cheqact = "ChequeraIDActual"
        case cheqsol = "ChequeraIDSolicitado"
        case nompadreact = "NombrePadreActual"
        case nompadresol = "NombrePadreSolicitado"
        case nommadreact = "NombreMadreActual"
        case nommadresol = "NombreMadreSolicitado"
		//
        case fechajubact = "FechaJubilacionActual"
        case fechajubsol = "FechaJubilacionSolicitado"
        case foliojubact = "FolioJubilacionActual"
        case foliojubsol = "FolioJubilacionSolicitado"
        case porcjubact = "PorcJubilacionActual"
        case porcjubsol = "PorcJubilacionSolicitado"
		//
		case pensact = "TienePensionActual"
        case penssol = "TienePensionSolicitado"
        case porcalimact = "PorcPensionAlimenticia1Actual"
        case porcalimsol = "PorcPensionAlimenticia1Solicitado"
		case porcalim2act = "PorcPensionAlimenticia2Actual"
        case porcalim2sol = "PorcPensionAlimenticia2Solicitado"
		case porcalim3act = "PorcPensionAlimenticia3Actual"
        case porcalim3sol = "PorcPensionAlimenticia3Solicitado"
        case imppenact = "ImportePension1Actual"
        case imppensol = "ImportePension1Solicitado"
		case imppen2act = "ImportePension2Actual"
        case imppen2sol = "ImportePension2Solicitado"
		case imppen3act = "ImportePension3Actual"
        case imppen3sol = "ImportePension3Solicitado"
		case descpenalimact = "DescripcionPensionAlimenticia1Actual"
        case descpenalimsol = "DescripcionPensionAlimenticia1Solicitado"
		case descpenalim2act = "DescripcionPensionAlimenticia2Actual"
        case descpenalim2sol = "DescripcionPensionAlimenticia2Solicitado"
		case descpenalim3act = "DescripcionPensionAlimenticia3Actual"
        case descpenalim3sol = "DescripcionPensionAlimenticia3Solicitado"
		case folpenact = "FolioPension1Actual"
        case folpensol = "FolioPension1Solicitado"
		case folpen2act = "FolioPension2Actual"
        case folpen2sol = "FolioPension2Solicitado"
		case folpen3act = "FolioPension3Actual"
        case folpen3sol = "FolioPension3Solicitado"
		//
		case sindact = "EsSindicalizadoActual"
        case sindsol = "EsSindicalizadoSolicitado"
		case cuotasindact = "CuotaSindicalActual"
        case cuotasindsol = "CuotaSindicalSolicitado"
		case tipocuentact = "TipoCuentaActual"
        case tipocuentsol = "TipoCuentaSolicitado"
        case emailact = "EmailActual"
        case emailsol = "EmailSolicitado"
        case emailempact = "EmailDeLaEmpresaActual"
        case emailempsol = "EmailDeLaEmpresaSolicitado"
        case regcontact = "RegimenContratacionActual"
        case regcontsol = "RegimenContratacionSolicitado"
        case tipcontsatact = "TipoContratoSATActual"
        case tipcontsatsol = "TipoContratoSATSolicitado"
        case tipocontsatdescact = "TipoContratoSATDescripcionActual"
        case tipocontsatdescsol = "TipoContratoSATDescripcionSolicitado"
        case tipojornsatact = "TipoJornadaSATActual"
        case tipojornsatsol = "TipoJornadaSATSolicitado"
		case tipojornsatdescact = "TipoJornadaSATDescripcionActual"
        case tipojornsatdescsol = "TipoJornadaSATDescripcionSolicitado"
		case tiporegsatact = "TipoRegimenSATActual"
        case tiporegsatsol = "TipoRegimenSATSolicitado"
		case tiporegsatdescact = "TipoRegimenSATDescripcionActual"
        case tiporegsatdescsol = "TipoRegimenSATDescripcionSolicitado"
		case edosatact = "EstadoSATActual"
        case edosatsol = "EstadoSATSolicitado"
		case edosatdescact = "EstadoSATDescripcionActual"
        case edosatdescsol = "EstadoSATDescripcionSolicitado"
		case puesimsact = "PuestoIdIMSSActual"
        case puesimssol = "PuestoIdIMSSSolicitado"
		case puesimsdescact = "PuestoIdIMSSDescripcionActual"
        case puesimsdescsol = "PuestoIdIMSSDescripcionSolicitado"
		case escact = "EscolaridadActual"
        case escsol = "EscolaridadSolicitado"
		case escdescact = "EscolaridadDescripcionActual"
        case escdescsol = "EscolaridadDescripcionSolicitado"
		//
		case uniact = "CarreraUniversitariaActual"
        case unisol = "CarreraUniversitariaSolicitado"
		case estactact = "EstudiaActualmenteActual"
        case estactsol = "EstudiaActualmenteSolicitado"
		case queestact = "QueEstudiaActual"
        case queestsol = "QueEstudiaSolicitado"
        case medestact = "MedioDeEstudioActual"
        case medestsol = "MedioDeEstudioSolicitado"
		case medestdescact = "MedioDeEstudioDescripcionActual"
        case medestdescsol = "MedioDeEstudioDescripcionSolicitado"
        case condvivact = "CondicionesDeViviendaActual"
        case condvivsol = "CondicionesDeViviendaSolicitado"
        case condvivdescact = "CondicionesDeViviendaDescripcionActual"
        case condvivdescsol = "CondicionesDeViviendaDescripcionSolicitado"
        case viveact = "ConQuienViveActual"
        case vivesol = "ConQuienViveSolicitado"
        case vivedescact = "ConQuienViveDescripcionActual"
        case vivedescsol = "ConQuienViveDescripcionSolicitado"
        case nomconyuact = "NombreDelConyugueActual"
        case nomconyusol = "NombreDelConyugueSolicitado"
        case canthijosact = "CantidadDeHijosActual"
        case canthijossol = "CantidadDeHijosSolicitado"
		case nomhijoact = "NombreDelHijo1Actual"
        case nomhijosol = "NombreDelHijo1Solicitado"
		case edadhijoact = "EdadDelHijo1Actual"
        case edadhijosol = "EdadDelHijo1Solicitado"
		case hijoescact = "HijosEnEdadEscolarActual"
        case hijoescsol = "HijosEnEdadEscolarSolicitado"
		case numdepecact = "NumeroDeDependientesEconomicosActual"
        case numdepecsol = "NumeroDeDependientesEconomicosSolicitado"
		case enfcroact = "TieneEnfermedadCronicaActual"
        case enfcrosol = "TieneEnfermedadCronicaSolicitado"
		case nomenfcroact = "NombreDeLaEnfermedadCronicaActual"
        case nomenfcrosol = "NombreDeLaEnfermedadCronicaSolicitado"
		case segvidaact = "TieneSeguroDeVidaActual"
        case segvidasol = "TieneSeguroDeVidaSolicitado"
		case nombensegvidaact = "NombreDelBeneficiarioDelSeguroDeVidaActual"
        case nombensegvidasol = "NombreDelBeneficiarioDelSeguroDeVidaSolicitado"
		case montoasegact = "MontoAseguradoActual"
        case montoasegsol = "MontoAseguradoSolicitado"
		case seggastosact = "TieneSeguroDeGastosMedicosMayoresActual"
        case seggastossol = "TieneSeguroDeGastosMedicosMayoresSolicitado"
		//CAMBIAR NOMBRES DE CASOS MAÑANA
        //PRIORIDAD 1
		case nombecimact = "NombresDeLosBeneficiariosDelSGMMActual"
        case nombecimsol = "NombresDeLosBeneficiariosDelSGMMSolicitado"
		case nomemgact = "NombreDeLaPersonaDeEmergenciaActual"
        case nomemgsol = "NombreDeLaPersonaDeEmergenciaSolicitado"
		case bengasact = "BeneficioGasSinCargoActual"
        case bengassol = "BeneficioGasSinCargoSolicitado"
        case bencomact = "BeneficioComedorActual"
        case bencomsol = "BeneficioComedorSolicitado"
		case bentraact = "BeneficioTransporteActual"
        case bentrasol = "BeneficioTransporteSolicitado"
        case benmamact = "BeneficioMamaActual"
        case benmamsol = "BeneficioMamaSolicitado"
        case benpapact = "BeneficioPapaActual"
        case benpapsol = "BeneficioPapaSolicitado"
        case bendianinoact = "BeneficioDiaDelNiñoActual"
        case bendianinosol = "BeneficioDiaDelNiñoSolicitado"
        case suelreact = "SueldoDiarioRealActual"
        case suelresol = "SueldoDiarioRealSolicitado"
        case bandepact = "BancoDepositoActual"
        case bandepsol = "BancoDepositoSolicitado"
        case bandepdescact = "BancoDepositoDescripcionActual"
        case bandepdescsol = "BancoDepositoDescripcionSolicitado"
        case claintdepact = "ClaveInterbancariaDeDepositoActual"
        case claintdepsol = "ClaveInterbancariaDeDepositoSolicitado"
		case suelimpenact = "SueldoRealIMSSPorProcesoDePensionActual"
        case suelimpensol = "SueldoRealIMSSPorProcesoDePensionSolicitado"
		case razpatact = "RazónSocialPatronalActual"
        case razpatsol = "RazónSocialPatronalSolicitado"
		case empcompact = "EmpresaQueDispersaElComplementoDeNominaActual"
        case empcompsol = "EmpresaQueDispersaElComplementoDeNominaSolicitado"
		case fonact = "TieneFonacotActual"
        case fonsol = "TieneFonacotSolicitado"
		case numfonact = "NumeroCreditoFonacotActual"
        case numfonsol = "NumeroCreditoFonacotSolicitado"
		case fechainifonact = "FechaInicioDelDescuentoFonacotActual"
        case fechainifonsol = "FechaInicioDelDescuentoFonacotSolicitado"
		case impfonact = "ImporteDescuentoFonacotActual"
        case impfonsol = "ImporteDescuentoFonacotSolicitado"
        //Detalles de la solicitud
        case nivel = "SecuenciaAutorizacion"
        case autoriza = "QuienAutoriza"
        case fechasol = "FechaAlta"
        case sla = "SLA"
        case fechasla = "FechaFinSLA"
        case motivo = "MotivoID"
        case motivodesc = "MotivoDescripcion"
        case motivodetalle = "MotivoDetalle"
        //Proceso
        case procesoid = "ProcesoID"
        case uuid = "New_ID"
        case emp = "EmpresaID"
        case cns = "Cns"
    }
    var nomEmp: String {
        enum Empresa: Int {
            case dam = 1
            case tab = 2
            case ven = 3
            case mil = 4
            case nan = 5
            case tri = 7
            case tda = 8
            case gen = 12
            case pac = 14
            case pmil = 37
            var siglas: String {
                switch self {
                case .dam: return "Damigas"
                case .tab: return "Tabagas"
                case .ven: return "Vendogas"
                case .mil: return "Gas-Milenium"
                case .nan: return "Vendogas-Nanchital"
                case .tri: return "Vendogas-Trinitaria"
                case .tda: return "Transportes-D'Amiano"
                case .gen: return "Stargas"
                case .pac: return "Vendogas-del-Pacifico"
                case .pmil: return "Pacifico-Milenium"
                }
            }
        }
        let idBusqueda = emp
        return Empresa(rawValue: idBusqueda)?.siglas ?? "Desconocida"
    }
    var datosAux: String {
        let info = "\(nomEmp)--\(procesoid)--\(solicitud)--\(cns)"
        return info
    }
    var urlAutorizar: URL? {
        let urlString = "https://erpweb.intranetgd.com.mx/home/wf_ejecutarSP/\(emp)/\(procesoid)/\(solicitud)/\(cns)/\(uuid)/spDa_WfDocAutorizaSolicitudPersonalUpd/\(autoriza)/2/-/\(datosAux)"
        return URL(string: urlString)
    }
    var urlRechazar: URL? {
        let urlString = "https://erpweb.intranetgd.com.mx/home/wf_ejecutarSP/\(emp)/\(procesoid)/\(solicitud)/\(cns)/\(uuid)/spDa_WfDocAutorizaSolicitudPersonalUpd/\(autoriza)/3/"
        return URL(string: urlString)
    }
}
