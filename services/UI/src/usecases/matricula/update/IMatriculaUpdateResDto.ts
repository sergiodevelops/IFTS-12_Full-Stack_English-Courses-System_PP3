export default interface IMatriculaUpdateResDto {
    "IdMatricula": number,
    "fecha": string,
    "estado": string,
    "Legajo": number,
    "Curso.CodCurso": number,
    "Curso.comision": string,
    "Curso.CodAula": number,
    "Curso.CodIdioma": number,
    "Curso.CodDocente": number,
    "Curso.CodNivel": number,
    "Alumno.nombre_completo": string
}
