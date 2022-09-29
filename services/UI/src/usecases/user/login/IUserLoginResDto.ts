import IPersonFindResDto from "@usecases/user/find/IPersonFindResDto";
export default interface IUserLoginResDto {
    IdUsuario: number;
    tipo_usuario: number;
    es_admin: number;
    nombre_completo: string;  // PENDIENTE: Reemplazar por Persona.nombre + Persona.apellido
    username: string;
    password: string;
    fecha_alta: string;
    Persona: [IPersonFindResDto];
}