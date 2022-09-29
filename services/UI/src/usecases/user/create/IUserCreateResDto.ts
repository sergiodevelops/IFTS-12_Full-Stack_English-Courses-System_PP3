export default interface IUserCreateResDto {
    IdUsuario: number;
    tipo_usuario: number;
    es_admin: number;
    nombre_completo: string;
    username: string;
    password: string;
    fecha_alta: string;
}